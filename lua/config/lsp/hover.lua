--- Slightly *fancier* LSP hover handler.
local lsp_hover = {}

---@class hover.opts
---@field border_hl? string Highlight group for the window borders.
---@field icon string
---@field max_height? integer
---@field max_width? integer
---@field min_height? integer
---@field min_width? integer
---@field name string

--- Configuration for lsp_hovers from different servers
---@type { default: hover.opts, [string]: hover.opts }
lsp_hover.config = {
  default = {
    icon = ' ',
    min_width = 20,
    max_width = math.floor(vim.o.columns * 0.75),

    min_height = 1,
    max_height = math.floor(vim.o.lines * 0.5),
  },
}

--- Finds matching configuration for the provided LSP and merges that with the default config.
---@param lsp_name string
---@return hover.opts
local match = function(lsp_name)
  local ignore = { 'default' }
  local config = lsp_hover.config.default or {}

  ---@type string[]
  local keys = vim.tbl_keys(lsp_hover.config)
  table.sort(keys)

  for _, k in ipairs(keys) do
    if vim.list_contains(ignore, k) == false and string.match(lsp_name, k) then
      return vim.tbl_extend('force', config, lsp_hover.config[k])
    end
  end

  config.name = lsp_name
  config.border_hl = '@variable'

  return config
end

--- Get which quadrant to open the window on.
---
--- ```
---    top, left ↑ top, right
---            ← █ →
--- bottom, left ↓ bottom, right
--- ```
---@param w integer
---@param h integer
---@return ['left'|'right'|'center', 'top'|'bottom'|'center']
local function get_quadrant(w, h)
  local window = vim.api.nvim_get_current_win()
  local src_c = vim.api.nvim_win_get_cursor(window)

  --- (Terminal) Screen position.
  ---@class screen.pos
  ---@field row integer Screen row.
  ---@field col integer First screen column.
  ---@field endcol integer Last screen column.
  ---@field curscol integer Cursor screen column.
  local scr_p = vim.fn.screenpos(window, src_c[1], src_c[2])

  ---@type integer, integer Vim's width & height.
  local vW, vH = vim.o.columns, vim.o.lines - (vim.o.cmdheight or 0)
  ---@type 'left'|'right', 'bottom'|'top'
  local x, y

  if scr_p.curscol - w <= 0 then
    --- Not enough spaces on `left`.
    if scr_p.curscol + w >= vW then
      --- Not enough space on `right`.
      return { 'center', 'center' }
    else
      --- Enough spaces on `right`.
      x = 'right'
    end
  else
    --- Enough space on `left`.
    x = 'left'
  end

  if scr_p.row + h >= vH then
    --- Not enough spaces on `top`.
    if scr_p.row - h <= 0 then
      --- Not enough spaces on `bottom`.
      return { 'center', 'center' }
    else
      y = 'top'
    end
  else
    y = 'bottom'
  end

  return { x, y }
end

---@type integer? LSP hover buffer.
lsp_hover.buffer = nil
---@type integer? LSP hover window.
lsp_hover.window = nil

--- Initializes the hover buffer & window.
---@param config table
lsp_hover.__init = function(config)
  if not config then
    return
  end

  if not lsp_hover.buffer or vim.api.nvim_buf_is_valid(lsp_hover.buffer) then
    pcall(vim.api.nvim_buf_delete, lsp_hover.buffer, { force = true })
    lsp_hover.buffer = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_keymap(lsp_hover.buffer, 'n', 'q', '', {
      desc = 'Closes LSP hover window',
      callback = function()
        pcall(vim.api.nvim_win_close, lsp_hover.window, true)
        lsp_hover.window = nil
      end,
    })
  end

  if not lsp_hover.window then
    lsp_hover.window = vim.api.nvim_open_win(lsp_hover.buffer, false, config)
  elseif vim.api.nvim_win_is_valid(lsp_hover.window) == false then
    pcall(vim.api.nvim_win_close, lsp_hover.window, true)
    lsp_hover.window = vim.api.nvim_open_win(lsp_hover.buffer, false, config)
  else
    vim.api.nvim_win_set_config(lsp_hover.window, config)
  end
end

--- Custom hover function.
---@param error table Error.
---@param result table Result of the hover.
---@param context table Context for this hover.
---@param _ table Hover config (we won't use this).
lsp_hover.hover = function(error, result, context, _)
  if error then
    --- Emit error message.
    vim.api.nvim_echo({
      { '  Lsp hover: ', 'DiagnosticVirtualTextError' },
      { ' ' },
      { error.message, 'Comment' },
    }, true, {})
  end

  if lsp_hover.window and vim.api.nvim_win_is_valid(lsp_hover.window) then
    vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = lsp_hover.window })
    --- If Hover window is active then switch to that
    --- window.
    vim.api.nvim_set_current_win(lsp_hover.window)

    return
  elseif vim.api.nvim_get_current_buf() ~= context.bufnr then
    --- Buffer was changed before the request was
    --- resolved.
    return
  elseif not result or not result.contents or (type(result.contents) == 'string' and string.len(result.contents) == 0) then
    --- No result.
    vim.api.nvim_echo({
      { '  Lsp hover: ', 'DiagnosticVirtualTextInfo' },
      { ' ' },
      { 'No information available!', 'Comment' },
    }, true, {})
    return
  end

  ---@type string[]
  local lines = {}
  local ft

  local contents = result.contents

  if type(contents) == 'string' then
    lines = vim.split(contents, '\n', { trimempty = true })
    ft = 'markdown'
  elseif type(contents) == 'table' then
    if contents.kind then
      -- MarkupContent
      lines = vim.split(contents.value or '', '\n', { trimempty = true })
      ft = contents.kind == 'plaintext' and 'text' or 'markdown'
    else
      -- MarkedString[] (Java)
      lines = {}
      local has_lines = false
      for _, item in ipairs(contents) do
        has_lines = true
        if type(item) == 'string' then
          vim.list_extend(lines, vim.split(item, '\n', { trimempty = true }))
        elseif type(item) == 'table' then
          -- Java provides the method/class name here
          local header = {
            '```java',
            item.value,
            '```',
          }
          vim.list_extend(lines, header)
        end
      end

      if not has_lines then
        if not contents.value then
          vim.api.nvim_echo({
            { '  Lsp hover: ', 'DiagnosticVirtualTextInfo' },
            { ' ' },
            { 'No information available!', 'Comment' },
          }, true, {})
          return
        end

        -- For some reason, `ipairs(contents)` will be an empty iterable even though there is stuff to show
        local header = {
          '```java',
          contents.value,
          '```',
        }
        vim.list_extend(lines, header)
      end

      ft = 'markdown'
    end
  end

  ---@type integer LSP client ID.
  local client_id = context.client_id
  ---@type { name: string } LSP client info.
  local client = vim.lsp.get_client_by_id(client_id) or { name = 'Unknown' }

  ---@type hover.opts
  local config = match(client.name)

  -- Set highlight group of hover window
  local hl = vim.treesitter.get_captures_at_cursor(0)
  if #hl > 0 then
    local capture = hl[#hl]
    config.border_hl = '@' .. capture
    config.name = capture
  end

  local w = math.max(config.min_width or 20, vim.fn.strdisplaywidth(config.name) + 6)
  local h = config.min_height or 1

  local max_height = config.max_height or 10
  local max_width = config.max_width or 60

  local n_lines = 0
  for _, line in ipairs(lines) do
    if vim.fn.strdisplaywidth(line) >= max_width then
      w = max_width
    elseif vim.fn.strdisplaywidth(line) > w then
      w = vim.fn.strdisplaywidth(line)
    end
  end

  for _, line in ipairs(lines) do
    n_lines = n_lines + math.ceil(math.max(1, vim.fn.strdisplaywidth(line)) / w)
  end
  h = math.max(math.min(n_lines, max_height), h)

  --- Window configuration.
  local win_conf = {
    relative = 'cursor',

    row = 1,
    col = 0,
    width = w,
    height = h,

    style = 'minimal',

    footer = {
      { '╼ ', config.border_hl },
      { config.icon, config.border_hl },
      { config.name, config.border_hl },
      { ' ╾', config.border_hl },
    },
    footer_pos = 'right',
  }

  --- Window borders.
  local border = {
    { '╭', config.border_hl },
    { '─', config.border_hl },
    { '╮', config.border_hl },

    { '│', config.border_hl },
    { '╯', config.border_hl },
    { '─', config.border_hl },

    { '╰', config.border_hl },
    { '│', config.border_hl },
  }

  --- Which quadrant to open the window on.
  local quad = get_quadrant(w + 2, h + 2)

  if quad[1] == 'left' then
    win_conf.col = (w * -1) - 1
  elseif quad[1] == 'right' then
    win_conf.col = 0
  else
    win_conf.relative = 'editor'
    win_conf.col = math.ceil((vim.o.columns - w) / 2)
  end

  if quad[2] == 'top' then
    win_conf.row = (h * -1) - 2

    if quad[1] == 'left' then
      border[5][1] = '┤'
    else
      border[7][1] = '├'
    end
  elseif quad[2] == 'bottom' then
    win_conf.row = 1

    if quad[1] == 'left' then
      border[3][1] = '┤'
    else
      border[1][1] = '├'
    end
  else
    win_conf.relative = 'editor'
    win_conf.row = math.ceil((vim.o.lines - h) / 2)
  end

  win_conf.border = border
  lsp_hover.__init(win_conf)

  vim.api.nvim_buf_set_lines(lsp_hover.buffer, 0, -1, false, lines)

  vim.bo[lsp_hover.buffer].ft = ft

  vim.wo[lsp_hover.window].conceallevel = 3
  vim.wo[lsp_hover.window].concealcursor = 'n'
  vim.wo[lsp_hover.window].signcolumn = 'no'

  vim.wo[lsp_hover.window].wrap = true
  vim.wo[lsp_hover.window].linebreak = true
end

--- Setup function.
---@param config { default: hover.opts, [string]: hover.opts } | nil
lsp_hover.setup = function(config)
  if config then
    lsp_hover.config = vim.tbl_deep_extend('force', lsp_hover.config, config)
  end

  if vim.fn.has 'nvim-0.11' == 1 then
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        vim.api.nvim_buf_set_keymap(ev.buf, 'n', 'K', '', {
          callback = function()
            vim.lsp.buf_request(0, 'textDocument/hover', vim.lsp.util.make_position_params(0, 'utf-8'), lsp_hover.hover)
          end,
        })
      end,
    })
  end

  -- Set-up the new provider.
  vim.lsp.handlers['textDocument/hover'] = lsp_hover.hover

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    callback = function(event)
      if event.buf == lsp_hover.buffer then
        -- Don't do anything if the current buffer
        -- is the hover buffer.
        return
      elseif lsp_hover.window and vim.api.nvim_win_is_valid(lsp_hover.window) then
        pcall(vim.api.nvim_win_close, lsp_hover.window, true)
        lsp_hover.window = nil
      end
    end,
  })
end

return lsp_hover
