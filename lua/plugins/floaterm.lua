--- @type LazySpec
return {
  'voldikss/vim-floaterm',
  init = function()
    vim.g.floaterm_keymap_toggle = '<F7>'
    vim.g.floaterm_keymap_prev = '<F8>'
    vim.g_floaterm_keymap_next = '<F9>'
    vim.g.floaterm_keymap_new = '<F12>'
  end,
}
