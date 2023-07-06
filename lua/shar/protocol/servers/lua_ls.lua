local lspconfig = require 'lspconfig'
local lsp_setup = require 'shar.protocol.lsp_setup'
local options = require 'shar.options'

return function()
  local on_attach
  if options.protocol.formatter then
    on_attach = lsp_setup.on_attach_no_formatting
  else
    on_attach = lsp_setup.on_attach
  end
  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = lsp_setup.capabilities,
  }
end
