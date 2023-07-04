local lspconfig = require 'lspconfig'
local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      }
    },
    on_attach = lsp_setup.on_attach,
    capabilities = lsp_setup.capabilities,
  }
end
