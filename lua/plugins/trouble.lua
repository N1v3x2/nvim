return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '<leader>q',
      '<Cmd>Trouble diagnostics toggle filter.buf=0 pinned=true focus=true<CR>',
      desc = 'Buffer diagnostics (Trouble)',
    },
    {
      'gs',
      '<Cmd>Trouble lsp_document_symbols toggle pinned=true focus=true<CR>',
      desc = 'LSP document symbols (Trouble)',
    },
    {
      'gl',
      '<Cmd>Trouble lsp toggle focus=true<CR>',
      desc = 'LSP dump (Trouble)',
    },
    {
      'grr',
      '<Cmd>Trouble lsp_references toggle focus=true<CR>',
      desc = 'LSP references (Trouble)',
    },
    {
      'gd',
      '<Cmd>Trouble lsp_definitions toggle focus=true<CR>',
      desc = 'LSP definitions (Trouble)',
    },
  },
}
