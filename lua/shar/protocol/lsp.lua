---Language Server Protocol (LSP) support.

local M = {}

local vim = vim
local keymap = vim.keymap

local lsp_setup = require 'shar.protocol.lsp_setup'

---A list of language server handlers for mason-lspconfig.
local handlers = {
  lsp_setup.default_handler,
  clangd = require 'shar.protocol.servers.clangd',
  texlab = require 'shar.protocol.servers.texlab',
  lua_ls = require 'shar.protocol.servers.lua_ls',
  jdtls = function()
    -- Do nothing: the setup is done in ftplugin/java.lua,
    -- using nvim-jdtls plugin.
  end,
  kotlin_language_server = require 'shar.protocol.servers.kotlin_language_server',
}

function M.pack()
  local packer = require 'packer'
  packer.use 'neovim/nvim-lspconfig'
  packer.use 'williamboman/mason-lspconfig.nvim'
end

---Set up LSP support.
function M.init()
  vim.diagnostic.config { signs = false }
  lsp_setup.setup_capabilities()

  local mason_lspconfig = require 'mason-lspconfig'
  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers(handlers)

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  keymap.set('i', '<C-K>', '<Nop>')
end

return M
