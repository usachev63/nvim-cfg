local M = {}

function M.pack()
  local packer = require 'packer'
  -- packer.use {
  --   'nvim-java/nvim-java',
  --   requires = {
  --     'nvim-java/nvim-java-refactor',
  --     'nvim-java/nvim-java-core',
  --     'nvim-java/nvim-java-test',
  --     'nvim-java/nvim-java-dap',
  --     'nvim-java/lua-async-await',
  --     'MunifTanjim/nui.nvim',
  --     'mfussenegger/nvim-dap',
  --     {
  --       'JavaHello/spring-boot.nvim',
  --       commit = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
  --     }, {
  --     'williamboman/mason.nvim',
  --     -- opts = {
  --     -- registries = {
  --     -- 	'github:nvim-java/mason-registry',
  --     -- 	'github:mason-org/mason-registry',
  --     -- },
  --     -- },
  --   },
  --   },
  -- }
  packer.use {
    'mfussenegger/nvim-jdtls',
    requires = { 'mfussenegger/nvim-dap' }
  }
end

function M.setup()
  -- require('java').setup()
end

return M
