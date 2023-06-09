--[[
-- Configuration of various protocols:
-- LSPs, formatters, linters, DAPs, treesitter, etc.
--]]
local vim = vim
local keymap = vim.keymap
local lsp = vim.lsp
local lsp_buf = lsp.buf
local diagnostic = vim.diagnostic

local packer = require 'packer'
packer.use 'neovim/nvim-lspconfig'
packer.use 'williamboman/mason.nvim'
packer.use 'williamboman/mason-lspconfig.nvim'
packer.use 'mhartington/formatter.nvim'
packer.use {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_install = require 'nvim-treesitter.install'
    local ts_update = ts_install.update({ with_sync = true })
    ts_update()
  end,
}

local function setup_buf_keymaps(buffer)
  local set = function(binding, action)
    keymap.set('n', binding, action, { buffer = buffer })
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

-- Default for all language servers.
--
-- Mostly copied from https://github.com/neovim/nvim-lspconfig README.md.
LSP_OnAttach = function(_, buffer)
  vim.diagnostic.config({
    signs = false
  })

  setup_buf_keymaps(buffer)
end

--
-- LSP
--

local mason = require("mason")
mason.setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
local lspconfig = require("lspconfig")
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup {
      on_attach = LSP_OnAttach,
      capabilities = cmp_capabilities,
    }
  end,
  ["clangd"] = function()
    lspconfig.clangd.setup({
      on_attach = function(client, bufnr)
        LSP_OnAttach(client, bufnr)
      end,
      filetypes = { "c", "cpp", "objc", "objcpp", "acm_cpp" },
      cmd = {
        "clangd",
        "--header-insertion=never",
        "--limit-references=100",
        "--limit-results=20",
        "-j=8",
        "--malloc-trim",
        "--background-index",
        "--pch-storage=memory",
      },
      capabilities = cmp_capabilities,
    })
  end,
  ["texlab"] = function()
    lspconfig.texlab.setup({
      on_attach = function(client, bufnr)
        LSP_OnAttach(client, bufnr)
        client.server_capabilities.document_formatting = false
      end,
      capabilities = cmp_capabilities,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        }
      },
      on_attach = LSP_OnAttach,
      capabilities = cmp_capabilities,
    })
  end,
  ["hls"] = function()
    lspconfig.hls.setup({
      on_attach = function(client, bufnr)
        LSP_OnAttach(client, bufnr)
      end,
      capabilities = cmp_capabilities,
    })
  end,
})

-- formatter.nvim
require("formatter").setup {
  filetype = {
    json = {
      require("formatter.filetypes.json").fixjson,
    }
  }
}

keymap.set('i', '<C-K>', '<Nop>')
