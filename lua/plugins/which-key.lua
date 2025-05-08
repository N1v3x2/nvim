---@type LazySpec
return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
