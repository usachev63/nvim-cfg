---Language Server Protocol (LSP) support.

local M = {}

local vim = vim
local keymap = vim.keymap
local telescope_builtin = require 'telescope.builtin'

local function on_attach_default(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

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
  set('<Leader>ic', function()
    vim.lsp.buf.typehierarchy 'subtypes'
  end)
  -- Rename symbol
  set('<Leader>rn', vim.lsp.buf.rename)
  -- Load all references of the symbol into quickfix list
  set('grr', telescope_builtin.lsp_references)
  set('<Leader>ca', vim.lsp.buf.code_action)

  if client.name ~= 'kotlin_language_server' and client.name ~= 'lemminx' then
    -- Format the whole document with LSP formatter
    keymap.set('n', '<Leader>fm', vim.lsp.buf.format, { buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup('usachev63.lsp.format', {}),
      callback = function()
        vim.lsp.buf.format {
          async = false,
          id = args.data.client_id,
        }
      end,
    })
    vim.cmd {
      cmd = 'cnoreabbrev',
      args = {
        '<expr>',
        '<buffer>',
        'LspFmtDisable',
        '"autocmd! usachev63.lsp.format"',
      }
    }
  end
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
    group = vim.api.nvim_create_augroup('usachev63.lsp.attach', {}),
    callback = function(args)
      on_attach_default(args)
    end,
  })
end

return M
