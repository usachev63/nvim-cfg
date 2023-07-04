--- Language Server Protocol (LSP) Support.
-- @module protocol.lsp

local M = {}

local vim = vim
local keymap = vim.keymap

local packer = require 'packer'
local lsp_setup = require 'shar.protocol.lsp_setup'

local handlers = {
  lsp_setup.default_handler,
  clangd = require 'shar.protocol.servers.clangd',
  texlab = require 'shar.protocol.servers.texlab',
  lua_ls = require 'shar.protocol.servers.lua_ls',
}

--- Setup LSP support.
function M.init()
  packer.use 'neovim/nvim-lspconfig'
  packer.use 'williamboman/mason-lspconfig.nvim'

  vim.diagnostic.config { signs = false }
  lsp_setup.setup_capabilities()

  local mason_lspconfig = require 'mason-lspconfig'
  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers(handlers)

  keymap.set('i', '<C-K>', '<Nop>')
end

return M
