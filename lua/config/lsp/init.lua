local servers = require 'config.lsp.servers'
vim.lsp.enable(servers)

vim.filetype.add {
  filename = {
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
  },
}

vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'vim.lsp.buf.references()' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition()' })
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'vim.lsp.buf.type_definition()' })

require('config.lsp.hover').setup()

vim.diagnostic.config {
  severity_sort = true,
  virtual_lines = { current_line = true },
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = false,
}
