local lsp_setup = require 'shar.protocol.lsp_setup'

return function()
  local lspconfig = require 'lspconfig'
  lspconfig.rust_analyzer.setup {
    on_attach = function(client, bufnr)
      lsp_setup.on_attach(client, bufnr)
    end,
    filetypes = {
      'rust',
    },
    capabilities = lsp_setup.capabilities,
    root_dir = lspconfig.util.root_pattern 'Cargo.toml',
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  }
end
