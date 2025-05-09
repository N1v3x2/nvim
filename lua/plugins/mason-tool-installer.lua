--- @type LazySpec
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
  },
  config = function()
    local servers = require 'config.lsp.servers'
    local ensure_installed = servers
    vim.list_extend(ensure_installed, {
      'stylua',
      'clang-format',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  end,
}
