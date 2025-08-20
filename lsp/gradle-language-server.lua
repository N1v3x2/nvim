--- @type vim.lsp.config
return {
  cmd = { 'gradle-language-server' },
  filetypes = { 'groovy' },
  init_options = {
    settings = {
      gradleWrapperEnabled = true,
    },
  },
  root_markers = { 'settings.gradle', 'build.gradle' },
}
