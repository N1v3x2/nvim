vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Turn off line numbers in terminal mode',
  group = vim.api.nvim_create_augroup('term-options', { clear = true }),
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end,
})
