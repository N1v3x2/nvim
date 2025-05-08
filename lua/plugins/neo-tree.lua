-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      --- Stop netrw from loading to prevent split-second netrw flash
      vim.g.loaded_netrwPlugin = 1
      vim.g.loaded_netrw = 1

      ---@diagnostic disable-next-line: param-type-mismatch
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree').setup {
          filesystem = {
            hijack_netrw_behavior = 'open_current',
          },
        }
      end
    end
  end,
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
