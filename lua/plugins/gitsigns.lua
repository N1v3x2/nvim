return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'git [p]review hunk inline' })
      map('n', '<leader>hP', gitsigns.preview_hunk, { desc = '[G]it [P]review hunk in float' })
      map('n', '<leader>gB', gitsigns.blame_line, { desc = '[G]it [B]lame line' })
      map('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame' })
      map('n', '<leader>gd', function()
        gitsigns.diffthis '@'
      end, { desc = 'git [D]iff against last commit' })
    end,

    preview_config = {
      row = 1,
    },
  },
}
