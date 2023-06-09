--[[
-- Configuration of various protocols:
-- LSPs, formatters, linters, DAPs, treesitter, etc.
--]]
local vim = vim
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

-- Default for all language servers.
--
-- Mostly copied from https://github.com/neovim/nvim-lspconfig README.md.
LSP_OnAttach = function(_, bufnr)
  local opts = { noremap = true, silent = true }

  vim.diagnostic.config({
    signs = false
  })

  -- Enable completion triggered by <c-x><c-o>
  -- if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'tex' then
  --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- end

  -- Mappings.
  -- compare
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Function "on_attach" sets up buffer-local keymaps, etc.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>wl',
  --     '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ww', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    ']w',
    '<cmd>lua vim.diagnostic.goto_next()<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    '[w',
    '<cmd>lua vim.diagnostic.goto_prev()<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    ']e',
    '<cmd>lua vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    '[e',
    '<cmd>lua vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }<CR>',
    opts
  )
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

vim.api.nvim_set_keymap('i', '<C-K>', 'Nop', { noremap = true })
