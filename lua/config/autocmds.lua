vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Open help windows to the right',
  group = vim.api.nvim_create_augroup('help-options', { clear = true }),
  pattern = '*/doc/*.{txt,md}',
  callback = function()
    local tab_id = vim.api.nvim_get_current_tabpage()
    -- TODO: only open to the right if window is wide enough
    pcall(vim.api.nvim_win_set_config, 0, { split = 'right', win = 0 })
  end,
})
