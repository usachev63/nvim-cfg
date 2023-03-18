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
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
  --     '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>fm', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ww', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']w', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
end

--
-- LSP
--

local mason = require("mason")
mason.setup()

local coq = require("coq")

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
local lspconfig = require("lspconfig")
mason_lspconfig.setup_handlers({
  function(server_name)   -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = LSP_OnAttach
    })
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
      }
    })
  end,
  ["texlab"] = function()
    lspconfig.texlab.setup({
      on_attach = function(client, bufnr)
        LSP_OnAttach(client, bufnr)
        client.server_capabilities.document_formatting = false
      end,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      },
      on_attach = LSP_OnAttach,
    })
  end,
  ["hls"] = function()
    lspconfig.hls.setup({
      on_attach = function(client, bufnr)
        LSP_OnAttach(client, bufnr)
      end,
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
