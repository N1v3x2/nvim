local colorschemes = {
  ['gruvbox-material'] = {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 20000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_float_style = 'blend'
      vim.g.gruvbox_material_disable_terminal_colors = true
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_current_word = 'bold'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  ['zenbones'] = {
    'zenbones-theme/zenbones.nvim',
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme 'zenbones'
    end,
  },

  ['kanagawa-paper'] = {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa-paper'
    end
  },
}

return colorschemes['gruvbox-material']
