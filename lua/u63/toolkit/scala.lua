local M = {}

local lsp_setup = require 'u63.protocol.lsp_setup'

function M.pack()
  local packer = require 'packer'
  packer.use {
    'scalameta/nvim-metals',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }
end

function M.setup()
  local metals = require 'metals'
  local metals_config = metals.bare_config()
  metals_config.on_attach = lsp_setup.on_attach
  local nvim_metals_group =
    vim.api.nvim_create_augroup('nvim-metals', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'scala', 'sbt' },
    callback = function()
      metals.initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end

return M
