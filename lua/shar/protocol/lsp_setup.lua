---Setup utilities for LSP support.

local M = {}

local vim = vim
local keymap = vim.keymap
local lsp_buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local options = require 'shar.options'

---Set up common user buffer keymaps upon attaching a LSP server.
---
---@param bufnr integer Buffer ID.
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

---Default LSP on_attach function.
---
---@param _ any
---@param bufnr integer Buffer ID.
---
---@diagnostic disable-next-line: unused-local
function M.on_attach(_, bufnr)
  setup_buf_keymaps(bufnr)
  -- Format the whole document with LSP formatter
  keymap.set('n', '<Leader>fm', lsp_buf.format, { buffer = bufnr })
end

---Same as default on_attach, but without formatting keymap.
---
---@param _ any
---@param bufnr integer Buffer ID.
---
---@diagnostic disable-next-line: unused-local
function M.on_attach_no_formatting(_, bufnr)
  setup_buf_keymaps(bufnr)
end

---Set up M.capabilities depending on shar-nvim-cfg options.
function M.setup_capabilities()
  if options.editing.cmp then
    M.capabilities = require('cmp_nvim_lsp').default_capabilities()
  else
    M.capabilities = vim.lsp.protocol.make_client_capabilities()
  end
end

---Default mason-lspconfig handler function.
---
---@param server_name string Server identifier.
function M.default_handler(server_name)
  local lspconfig = require 'lspconfig'
  lspconfig[server_name].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
end

return M
