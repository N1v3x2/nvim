return {
  'ojroques/vim-oscyank',
  init = function()
    vim.keymap.set('n', '<leader>y', '<Plug>OSCYankOperator', { remap = true })
    vim.keymap.set('n', '<leader>yy', '<leader>y_', { remap = true })
    vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual', { remap = true })
  end,
}
