local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  local lspconfig = require 'lspconfig'
  lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
      lsp_setup.on_attach(client, bufnr)
    end,
    filetypes = {
      'c',
      'cpp',
      'cpp.doxygen'
    },
    cmd = {
      "clangd",
      "-j=1",
    },
    capabilities = lsp_setup.capabilities
  }
end
