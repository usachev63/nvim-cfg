--- Setup Utilities for LSP.
-- @module protocol.lsp_setup

local M = {}

local vim = vim
local keymap = vim.keymap
local lsp_buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local lspconfig = require 'lspconfig'
local options = require 'shar.options'

--- Setup common user buffer keymaps upon attaching a LSP server.
local function setup_buf_keymaps(bufnr)
  local function set(binding, action)
    keymap.set('n', binding, action, { buffer = bufnr })
  end

  -- Go to declaration
  set('gD', lsp_buf.declaration)
  -- Go to definition
  set('gd', lsp_buf.definition)
  -- Hover floating window
  set('K', lsp_buf.hover)
  -- Signature help floating window
  set('<C-K>', lsp_buf.signature_help)
  -- Go to type definition
  set('<Leader>td', lsp_buf.type_definition)
  -- Rename symbol
  set('<Leader>rn', lsp_buf.rename)
  -- Load all references of the symbol into quickfix list
  set('gr', lsp_buf.references)
  -- Format the whole document
  set('<Leader>fm', lsp_buf.format)
  -- Open diagnostics window
  set('<Leader>ww', diagnostic.open_float)
  -- Move between diagnostic messages
  set(']w', diagnostic.goto_next)
  set('[w', diagnostic.goto_prev)
  -- Move between errors
  set(']e', function()
    diagnostic.goto_next {
      severity = diagnostic.severity.ERROR
    }
  end)
  set(']e', function()
    diagnostic.goto_prev {
      severity = diagnostic.severity.ERROR
    }
  end)
end

--- Default on_attach LSP function.
function M.on_attach(_, bufnr)
  setup_buf_keymaps(bufnr)
end

--- Default client capabilities.
-- @table M.capabilities

function M.setup_capabilities()
  if options.editing.cmp then
    M.capabilities = require('cmp_nvim_lsp').default_capabilities()
  else
    M.capabilities = vim.lsp.protocol.make_client_capabilities()
  end
end

function M.default_handler(server_name)
  lspconfig[server_name].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
end

return M
