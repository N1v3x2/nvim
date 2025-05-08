--- @type LazyConfig
return {
  'aserowy/tmux.nvim',
  init = function()
    vim.keymap.set('n', '<C-n>', function()
      require('tmux').next_window()
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<C-p>', function()
      require('tmux').previous_window()
    end, { noremap = true, silent = true })
  end,
  opts = {
    copy_sync = { enable = false },
  },
}
