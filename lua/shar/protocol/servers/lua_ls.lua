local lsp_setup = require 'shar.protocol.lsp_setup'
local options = require 'shar.options'

return function()
  local lspconfig = require 'lspconfig'
  local on_attach_impl
  if options.protocol.formatter then
    on_attach_impl = lsp_setup.on_attach_no_formatting
  else
    on_attach_impl = lsp_setup.on_attach
  end
  lspconfig.lua_ls.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      on_attach_impl(client, bufnr)
    end,
    capabilities = lsp_setup.capabilities,
  }
end
