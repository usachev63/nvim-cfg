function Format_range_operator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
        local start = vim.api.nvim_buf_get_mark(0, '[')
        local finish = vim.api.nvim_buf_get_mark(0, ']')
        vim.lsp.buf.range_formatting({}, start, finish)
        vim.go.operatorfunc = old_func
        _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_formatting'
    vim.api.nvim_feedkeys('g@', 'n', false)
end

-- Default for all language servers.
--
-- Mostly copied from https://github.com/neovim/nvim-lspconfig README.md.
LSP_OnAttach = function(_, bufnr)
    local opts = { noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'tex' then
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    -- Mappings.
    -- compare
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- Function "on_attach" sets up buffer-local keymaps, etc.
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
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
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ww', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']w', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

end

local on_attach_formatting = function()
    -- formatting
    vim.api.nvim_set_keymap("", "=", "<cmd>lua Format_range_operator()<cr>", { noremap = true })
    vim.api.nvim_create_autocmd({ "bufwritepre" }, {
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })
end

-- local on_attach_formatting_overkill = function()
--     -- formatting
--     vim.api.nvim_set_keymap("", "=", "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", { noremap = true })
--     vim.api.nvim_create_autocmd({ "bufwritepre" }, {
--         callback = function()
--             vim.lsp.buf.formatting_sync()
--         end,
--     })
-- end

local mason = require("mason")
mason.setup()

--
-- LSP
--

local cmp_nvim_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
local lspconfig = require("lspconfig")
mason_lspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {
            on_attach = LSP_OnAttach,
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup {
            on_attach = function(client, bufnr)
                LSP_OnAttach(client, bufnr)
                on_attach_formatting()
            end,
            filetypes = { "c", "cpp", "objc", "objcpp", "acm_cpp" },
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
    ["texlab"] = function()
        lspconfig.texlab.setup {
            on_attach = function(client, bufnr)
                LSP_OnAttach(client, bufnr)
                client.resolved_capabilities.document_formatting = false
            end,
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            },
            on_attach = LSP_OnAttach,
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
    ["hls"] = function()
        lspconfig.hls.setup {
            on_attach = function(client, bufnr)
                LSP_OnAttach(client, bufnr)
                on_attach_formatting()
            end,
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
})

-- local null_ls = require("null-ls")
-- null_ls.setup({
--     sources = {
--         -- null_ls.builtins.formatting.latexindent.with({
--         --     extra_args = { "-y",
--         --         "defaultIndent:\" \",indentAfterItems:itemize:0;itemize*:0;enumerate:0;enumerate*:0;description:0;description*:0;list:0,lookForAlignDelims:align*:alignDoubleBackSlash:0" },
--         -- })
--     },
--     on_attach = function(_, _)
--         on_attach_formatting_overkill()
--     end
-- })
