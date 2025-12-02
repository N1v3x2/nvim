vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-q>', '<Cmd>bd!<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<C-y>', '<Cmd>%y<CR>', { desc = 'Yank entire file' })

vim.keymap.set('n', '[[', '?{<CR>w99[{', { remap = true })
vim.keymap.set('n', '][', '/}<CR>b99]}', { remap = true })
vim.keymap.set('n', ']]', 'j0[[%/{<CR>', { remap = true })
vim.keymap.set('n', '[]', 'k$][%?}<CR>', { remap = true })
