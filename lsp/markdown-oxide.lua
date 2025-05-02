local function check_codelens_support()
  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
  buffer = bufnr,
  callback = function()
    if check_codelens_support() then
      vim.lsp.codelens.refresh { bufnr = 0 }
    end
  end,
})

-- trigger codelens refresh
vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

---@type vim.lsp.Config
return {
  cmd = { 'markdown-oxide' },
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
  filetypes = { 'markdown' },
  root_markers = { '.git', '.obsidian', '.moxide.toml' },
}
