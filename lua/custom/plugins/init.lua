-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_view_zathura_use_synctex = 0
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      vim.print = _G.dd

      vim.g.snacks_animate = false

      vim.keymap.set('n', '<leader>g', function()
        Snacks.lazygit()
      end, { desc = 'Open Lazygit' })

      vim.keymap.set('n', '<leader>nh', function()
        Snacks.notifier.show_history()
      end, { desc = '[N]otifier [H]istory' })
    end,
    opts = {
      bigfile = { enable = true },
      dashboard = { enable = true },
      indent = { enable = true },
      input = { enable = true },
      lazygit = { enable = true },
      notifier = { enable = true },
      quickfile = { enable = true },
      scope = { enable = true },
      scroll = { enable = true },
      statuscolumn = { enable = true },
      words = { enable = true },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' }) -- Background of hover window
      vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'DiagnosticInfo' }) -- Border color
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'voldikss/vim-floaterm',
    init = function()
      vim.g.floaterm_keymap_toggle = '<F7>'
      vim.g.floaterm_keymap_prev = '<F8>'
      vim.g_floaterm_keymap_next = '<F9>'
      vim.g.floaterm_keymap_new = '<F12>'
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      -- 'echasnovski/mini.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        -- backgrounds = {},
      },
      bullet = {
        highlight = '',
      },
      code = {
        border = 'thick',
        -- highlight_inline = ''
      },
      pipe_table = {
        preset = 'round',
      },
    },
    init = function()
      vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle RenderMarkdown' })
    end,
  },
  {
    'danymat/neogen',
    init = function()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<Leader>nf', ":lua require('neogen').generate()<CR>", opts)
      vim.api.nvim_set_keymap('n', '<Leader>nc', ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
    end,
    config = true,
    opts = { snippet_engine = 'luasnip' },
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      -- cursor_color = 'none',
    },
  },
  {
    'let-def/texpresso.vim',
  },
}
