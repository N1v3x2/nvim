return {
  'folke/trouble.nvim',
  opts = {
    focus = true,
    auto_refresh = false,
  },
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
      '<Cmd>Trouble lsp toggle<CR>',
      desc = 'LSP dump (Trouble)',
    },
    {
      'grr',
      '<Cmd>Trouble lsp_references toggle<CR>',
      desc = 'LSP references (Trouble)',
    },
    {
      'gd',
      '<Cmd>Trouble lsp_definitions toggle<CR>',
      desc = 'LSP definitions (Trouble)',
    },
  },
}
