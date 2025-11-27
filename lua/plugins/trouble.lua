return {
  'folke/trouble.nvim',
  opts = {
    modes = {
      mydiags = {
        mode = 'diagnostics',
        filter = {
          any = {
            buf = 0,
            {
              severity = vim.diagnostic.severity.ERROR, -- errors only
              -- limit to files in the current project
              function(item)
                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
              end,
            },
          },
        },
      },
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>q',
      '<cmd>Trouble mydiags toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle pinned=true focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>tl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      -- NOTE: this remaps the default LSP keymap for references
      'grr',
      '<cmd>Trouble lsp_references toggle focus=false win.position=right<cr>',
      desc = 'LSP References (Trouble)',
    },
    {
      '<leader>ti',
      '<cmd>Trouble lsp_incoming_calls toggle focus=false win.position=right<cr>',
      desc = 'LSP Incoming Calls (Trouble)',
    },
  },
}
