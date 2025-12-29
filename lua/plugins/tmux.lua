return {
  'aserowy/tmux.nvim',
  config = function()
    local tmux = require 'tmux'

    tmux.setup {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enabled_default_keybindings = false,
      },
      cycle = {
        enabled_default_keybindings = false,
      },
    }

    vim.keymap.set('n', '<M-h>', tmux.move_left,
      { desc = 'Move to the left nvim window or tmux pane' })
    vim.keymap.set('n', '<M-j>', tmux.move_bottom,
      { desc = 'Move to the lower nvim window or tmux pane' })
    vim.keymap.set('n', '<M-k>', tmux.move_top,
      { desc = 'Move to the upper nvim window or tmux pane' })
    vim.keymap.set('n', '<M-l>', tmux.move_right,
      { desc = 'Move to the right nvim window or tmux pane' })
  end,
}
