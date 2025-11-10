return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#4B2222' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#4A3410' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#4B400B' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#1C3321' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#1A2F4A' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#4B2235' })

    require('render-markdown').setup {
      completions = { blink = { enabled = true } },
      heading = {
        border = true,
        icons = { '󰼏 ', '󰼐 ', '󰼑 ', '󰎲 ', '󰎯 ', '󰎴 ' },
      },
      bullet = {
        highlight = '',
      },
      code = {
        border = 'thick',
      },
      -- document = {
      --   conceal = {
      --     char_patterns = { '\\' },
      --   },
      -- },
    }
  end,
  init = function()
    vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle RenderMarkdown' })
  end,
}
