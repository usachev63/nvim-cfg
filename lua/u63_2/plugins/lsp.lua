vim.diagnostic.config { signs = false }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('u63/lsp_attach', {}),
  callback = function(args)
    local bufnr = args.buf
    local client_id = args.data.client_id

    vim.keymap.set('n', '<Leader>fm', vim.lsp.buf.format, { buffer = bufnr })
    local autofmt_augroup_name = 'u63/lsp_format/' .. bufnr
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup(autofmt_augroup_name, {}),
      callback = function()
        vim.lsp.buf.format {
          async = false,
          id = client_id,
        }
      end,
    })
    vim.keymap.set('n', 'yof', function()
      vim.cmd('autocmd! ' .. autofmt_augroup_name)
    end, { buffer = bufnr })
  end,
})

return {
  'neovim/nvim-lspconfig',
}
