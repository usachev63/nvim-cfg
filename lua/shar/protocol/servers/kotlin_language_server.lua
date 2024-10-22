local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  local lspconfig = require 'lspconfig'
  lspconfig.kotlin_language_server.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_formatting = false
      lsp_setup.on_attach_no_formatting(client, bufnr)
    end,
    capabilities = lsp_setup.capabilities
  }
end
