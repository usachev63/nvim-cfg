local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  local lspconfig = require 'lspconfig'
  lspconfig.texlab.setup {
    on_attach = function(client, bufnr)
      lsp_setup.on_attach(client, bufnr)
      client.server_capabilities.document_formatting = false
    end,
    capabilities = lsp_setup.capabilities,
  }
end
