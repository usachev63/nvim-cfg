---Language Server Protocol (LSP) support.

local M = {}

local vim = vim
local keymap = vim.keymap

local function on_attach_default(bufnr)
  local function set(binding, action)
    keymap.set('n', binding, action, { buffer = bufnr })
  end

  -- Go to declaration
  set('gD', vim.lsp.buf.declaration)
  -- Go to definition
  set('gd', vim.lsp.buf.definition)
  -- Hover floating window
  set('K', vim.lsp.buf.hover)
  -- Signature help floating window
  set('<C-K>', vim.lsp.buf.signature_help)
  -- Go to type definition
  set('<Leader>td', vim.lsp.buf.type_definition)
  -- Show subtypes
  set('<Leader>ic', function ()
    vim.lsp.buf.typehierarchy('subtypes')
  end)
  -- Rename symbol
  set('<Leader>rn', vim.lsp.buf.rename)
  -- Load all references of the symbol into quickfix list
  set('gr', vim.lsp.buf.references)
  set('<Leader>ca', vim.lsp.buf.code_action)
  -- Format the whole document with LSP formatter
  keymap.set('n', '<Leader>fm', vim.lsp.buf.format, { buffer = bufnr })
end

function M.pack()
  local packer = require 'packer'
  packer.use 'neovim/nvim-lspconfig'
  packer.use 'williamboman/mason-lspconfig.nvim'
end

---Set up LSP support.
function M.init()
  require('mason').setup()
  require('mason-lspconfig').setup()
  vim.diagnostic.config { signs = false }
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("usachev63.protocol.lsp", {}),
    callback = function(args)
      on_attach_default(args.buf)
    end
  })
end

return M
