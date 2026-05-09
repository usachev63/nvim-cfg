local function lsp_setup_buf_formatting(bufnr, client_id)
  vim.keymap.set('n', '<Leader>fm',
    function()
      vim.lsp.buf.format({ bufnr = bufnr, id = client_id })
    end,
    { buffer = bufnr }
  )

  local autofmt_augroup_name = 'u63/lsp_format/' .. bufnr
  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup(autofmt_augroup_name, {}),
    callback = function()
      vim.lsp.buf.format {
        bufnr = bufnr,
        async = false,
        id = client_id,
      }
    end,
  })
  vim.keymap.set('n', 'yof', function()
    vim.print("[u63] disabled format-on-save")
    vim.cmd('autocmd! ' .. autofmt_augroup_name)
  end, { buffer = bufnr })
end

vim.diagnostic.config({ signs = false })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('u63/lsp_attach', {}),
  callback = function(args)
    local bufnr = args.buf
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)

    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      lsp_setup_buf_formatting(bufnr, client_id)
    end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
  end,
})

vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

return {
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  },
}
