return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix',
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]rouble' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
