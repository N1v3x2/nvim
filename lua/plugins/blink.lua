return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = '2.*' },
    'folke/lazydev.nvim',
  },
  init = function()
    require('luasnip.loaders.from_snipmate').lazy_load()
  end,
  opts = {
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },

      ['<Tab>'] = { 'accept', 'fallback' },

      ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-p>'] = { 'select_next', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_prev', 'fallback_to_mappings' },

      ['<C-l>'] = { 'snippet_forward', 'fallback_to_mappings' },
      ['<C-h>'] = { 'snippet_backward', 'fallback_to_mappings' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    cmdline = {
      keymap = {
        preset = 'inherit',
      }
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = {
        -- auto_show = true,
        -- auto_show_delay_ms = 500,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:Normal',
        },
      },
      ghost_text = { enabled = true },
      menu = {
        border = 'rounded',
        draw = {
          treesitter = { 'lsp' },
        },
        winhighlight = 'Normal:Normal,PmenuExtra:Normal,CursorLine:TelescopeSelection',
      },
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },
  },
}
