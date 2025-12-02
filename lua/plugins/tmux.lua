return {
  'aserowy/tmux.nvim',
  config = function()
    local tmux = require 'tmux'
    tmux.setup {
      copy_sync = {
        enabled = false,
      },
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

    vim.api.nvim_set_keymap('n', '<M-h>', '', {
      desc = 'Move to the left nvim window or tmux pane',
      callback = tmux.move_left,
    })
    vim.api.nvim_set_keymap('n', '<M-j>', '', {
      desc = 'Move to the lower nvim window or tmux pane',
      callback = tmux.move_bottom,
    })
    vim.api.nvim_set_keymap('n', '<M-k>', '', {
      desc = 'Move to the upper nvim window or tmux pane',
      callback = tmux.move_top,
    })
    vim.api.nvim_set_keymap('n', '<M-l>', '', {
      desc = 'Move to the right nvim window or tmux pane',
      callback = tmux.move_right,
    })
  end,
}
