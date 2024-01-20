local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  local lspconfig = require 'lspconfig'
  lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      lsp_setup.on_attach(client, bufnr)
    end,
    cmd = {
      "clangd",
      "--header-insertion=never",
      "--limit-references=100",
      "--limit-results=20",
      "-j=8",
      "--malloc-trim",
      "--background-index",
      "--pch-storage=memory",
    },
    capabilities = lsp_setup.capabilities,
  }
end
