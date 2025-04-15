---@type vim.lsp.Config
return {
  cmd = {
    vim.fn.stdpath 'data' .. '/mason/bin/clangd',
    '--clang-tidy',
    '--header-insertion=never',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json' },
}
