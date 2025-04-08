---@type vim.lsp.Config
return {
  cmd = {
    vim.fn.stdpath 'data' .. '/mason/bin/clangd',
    '--clang-tidy',
  },
  root_markers = { '.clangd', 'compile_commands.json' },
  filetypes = { 'c', 'cpp' },
}
