return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local actions = require 'telescope.actions'

    local git_commit_opts = {
      mappings = {
        i = {
          ['<C-v>'] = false,
          ['<C-x>'] = false,
          ['<C-t>'] = false,
          ['<CR>'] = 'select_vertical',
        },
      },
    }

    telescope.setup {
      defaults = {
        sorting_strategy = 'ascending',

        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            prompt_position = 'top',
            width = { 0.95, max = 120 },
            preview_height = 0.7,
          },
        },

        dynamic_preview_title = true,
        preview = {
          filesize_limit = false,
          timeout = false,
        },

        mappings = {
          i = {
            ['<M-f>'] = false,
            ['<M-k>'] = false,
            ['<C-f>'] = false,

            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-h>'] = 'preview_scrolling_left',
            ['<C-l>'] = 'preview_scrolling_right',
            ['<C-r>'] = 'to_fuzzy_refine',
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
          },
        },
      },

      pickers = {
        colorscheme = { enable_preview = true },
        git_bcommits = git_commit_opts,
        git_bcommits_range = git_commit_opts,
      },

      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')

    -- General
    vim.keymap.set('n', '<Leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<Leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<Leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<Leader>st', builtin.builtin, { desc = '[S]earch [T]elescope' })
    vim.keymap.set('n', '<Leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<Leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<Leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<Leader>sR', builtin.registers, { desc = '[S]earch [R]egisters' })
    vim.keymap.set('n', '<Leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
    vim.keymap.set('n', '<Leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<Leader>/', function()
      builtin.current_buffer_fuzzy_find()
    end, { desc = '[/] Fuzzy search in current buffer' })

    -- LSP overrides
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function()
        vim.keymap.set('n', '<Leader>q', builtin.diagnostics, {
          desc = 'Diagnostics; overrides vim.diagnostic.setloclist()',
        })
        vim.keymap.set('n', 'grr', builtin.lsp_references, {
          desc = 'LSP references; overrides vim.lsp.buf.references()',
        })
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, {
          desc = 'LSP definition; overrides vim.lsp.buf.definition()',
        })
        vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, {
          desc = 'LSP document symbols; overrides vim.lsp.buf.document_symbol()',
        })
        vim.keymap.set('n', '<Leader>O', builtin.lsp_workspace_symbols, {
          desc = 'LSP workspace symbols',
        })
      end,
    })

    -- Git
    vim.keymap.set('n', '<Leader>gh', builtin.git_bcommits, { desc = '[G]it buffer commit [H]istory' })
    vim.keymap.set('v', '<Leader>gh', builtin.git_bcommits_range, { desc = '[G]it buffer commit [H]istory' })
  end,
}
