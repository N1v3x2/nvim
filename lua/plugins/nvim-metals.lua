local map = vim.keymap.set
local fn = vim.fn

--- @type LazySpec
return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
    {
      'mfussenegger/nvim-dap',
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require 'dap'

        dap.configurations.scala = {
          {
            type = 'scala',
            request = 'launch',
            name = 'RunOrTest',
            metals = {
              runType = 'runOrTestFile',
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = 'scala',
            request = 'launch',
            name = 'Test Target',
            metals = {
              runType = 'testTarget',
            },
          },
        }
      end,
    },
  },
  ft = { 'scala', 'sbt' },
  opts = function()
    local metals_config = require('metals').bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
    }
    metals_config.init_options.statusBarProvider = 'off'
    metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()

    --- @diagnostic disable-next-line: unused-local
    metals_config.on_attach = function(client, bufnr)
      map('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'vim.lsp.codelens.run' })

      map('n', '<leader>ws', function()
        require('metals').hover_worksheet()
      end)

      -- all workspace diagnostics
      map('n', '<leader>aa', vim.diagnostic.setqflist)

      -- all workspace errors
      map('n', '<leader>ae', function()
        vim.diagnostic.setqflist { severity = 'E' }
      end)

      -- all workspace warnings
      map('n', '<leader>aw', function()
        vim.diagnostic.setqflist { severity = 'W' }
      end)

      -- Example mappings for usage with nvim-dap. If you don't use that, you can
      -- skip these
      --- @diagnostic disable: undefined-field
      map('n', '<leader>dc', function()
        require('dap').continue()
      end)

      map('n', '<leader>dr', function()
        require('dap').repl.toggle()
      end)

      map('n', '<leader>dK', function()
        require('dap.ui.widgets').hover()
      end)

      map('n', '<leader>dt', function()
        require('dap').toggle_breakpoint()
      end)

      map('n', '<leader>dso', function()
        require('dap').step_over()
      end)

      map('n', '<leader>dsi', function()
        require('dap').step_into()
      end)

      map('n', '<leader>dl', function()
        require('dap').run_last()
      end)
      --- @diagnostic enable: undefined-field
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
