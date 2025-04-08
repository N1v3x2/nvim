---@type vim.lsp.Config
return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'requirements.txt' },
  settings = {
    pylsp = {
      configurationSources = {},
      plugins = {
        ruff = {
          enabled = true, -- Enable the plugin
          formatEnabled = true, -- Enable formatting using ruffs formatter
        },
      },
    },
  },
}
