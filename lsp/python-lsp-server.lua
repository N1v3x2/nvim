---@type vim.lsp.Config
return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = { '.git', 'pyproject.toml', 'requirements.txt' },
  settings = {
    pylsp = {
      configurationSources = {},
      plugins = {
        ruff = {
          enabled = true, -- Enable the plugin
          formatEnabled = true, -- Enable formatting using ruffs formatter
        },
        pylsp_mypy = {
          enabled = false,
          live_mode = true,
        },
      },
    },
  },
}
