return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>q',
      '<Cmd>Trouble diagnostics toggle filter.buf=0 pinned=true<CR>',
      desc = 'Buffer diagnostics (Trouble)',
    },
    {
      'gs',
      '<Cmd>Trouble lsp_document_symbols toggle pinned=true<CR>',
      desc = 'LSP document symbols (Trouble)',
    },
    {
      'gl',
      '<Cmd>Trouble lsp toggle win.position=right<CR>',
      desc = 'LSP dump (Trouble)',
    },
    {
      'grr',
      '<Cmd>Trouble lsp_references toggle win.position=right<CR>',
      desc = 'LSP references (Trouble)',
    },
    {
      'gd',
      '<Cmd>Trouble lsp_definitions toggle win.position=right<CR>',
      desc = 'LSP definitions (Trouble)'
    }
  },
}
