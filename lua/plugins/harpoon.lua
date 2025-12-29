return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Ghostty remaps <C-number> to <C-b>number
    vim.keymap.set('n', '<C-b>1', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-b>2', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-b>3', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-b>4', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-p>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end)
  end,
}
