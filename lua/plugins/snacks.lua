--- @type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    _G.bt = function()
      Snacks.debug.backtrace()
    end
    vim.print = _G.dd

    vim.g.snacks_animate = false

    vim.keymap.set('n', '<leader>g', function()
      Snacks.lazygit()
    end, { desc = 'Open Lazygit' })

    vim.keymap.set('n', '<leader>nh', function()
      Snacks.notifier.show_history()
    end, { desc = '[N]otifier [H]istory' })
  end,
  opts = {
    bigfile = {},
    dashboard = {},
    indent = {},
    input = {},
    lazygit = {},
    notifier = {},
    quickfile = {},
    scope = {},
    scroll = {},
    statuscolumn = {},
    words = {},
  },
}
