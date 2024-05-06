local options = require 'shar.options'
local java = require 'shar.toolkit.java'
local lsp_setup = require 'shar.protocol.lsp_setup'

vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.wo.spell = true
vim.bo.spelloptions = 'camel'

if options.toolkit.java.enabled then
  local jdtls = require 'jdtls'
  jdtls.start_or_attach(java.make_config())
  local bufnr = vim.api.nvim_get_current_buf()
  lsp_setup.on_attach(nil, bufnr)
  vim.keymap.set('n', '<Leader>oi', jdtls.organize_imports, { buffer = bufnr })
end
