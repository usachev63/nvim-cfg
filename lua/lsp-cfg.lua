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

function Format_range_operator_overkill()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
        vim.lsp.buf.formatting()
        vim.go.operatorfunc = old_func
        _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_formatting'
    vim.api.nvim_feedkeys('g@', 'n', false)
end

-- Default for all language servers.
--
-- Mostly copied from https://github.com/neovim/nvim-lspconfig README.md.
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    if vim.api.nvim_buf_get_option(bufnr, 'filetype') ~= 'tex' then
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- Function "on_attach" sets up buffer-local keymaps, etc.
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ww', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']w', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

end

local on_attach_formatting = function()
    -- Formatting
    vim.api.nvim_set_keymap("", "=", "<cmd>lua Format_range_operator()<CR>", { noremap = true })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })

end

local on_attach_formatting_overkill = function()
    -- Formatting
    vim.api.nvim_set_keymap("", "=", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", { noremap = true })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })

end

local mason = require("mason")
mason.setup()

--
-- LSP
--

local cmp_nvim_lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
local lspconfig = require("lspconfig")
mason_lspconfig.setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                on_attach_formatting()
            end,
            filetypes = { "c", "cpp", "objc", "objcpp", "acm_cpp" },
            capabilities = cmp_nvim_lsp_capabilities,
        }
    end,
})
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.latexindent.with({
            args = { "-", "-y",
                "defaultIndent:\" \",indentAfterItems:itemize:0;itemize*:0;enumerate:0;enumerate*:0;description:0;description*:0;list:0,lookForAlignDelims:align*:alignDoubleBackSlash:0" }
        }),
    },
    on_attach = function(client, bufnr)
        on_attach_formatting_overkill()
    end,
})
