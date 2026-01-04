return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'editorconfig',
      'git_config',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'jsonc',
      'latex',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'properties',
      'python',
      'query',
      'regex',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    },
    highlight = {
      enable = true,
      disable = { 'latex', 'tmux' },
      additional_vim_regex_highlighting = { 'ruby' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gi',
        node_incremental = 'gi',
        node_decremental = 'go',
      },
    },
    indent = {
      enable = true,
      disable = { 'ruby', 'python' },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
