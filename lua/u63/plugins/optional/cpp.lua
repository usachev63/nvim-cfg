vim.lsp.config.clangd = {
  filetypes = { 'c', 'cpp', 'cpp.doxygen' },
}

vim.lsp.enable 'clangd'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('u63/clangd_lsp_attach', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == 'clangd' then
      vim.keymap.set('n', '<LocalLeader>th', ':LspClangdSwitchSourceHeader<CR>', { buffer = bufnr })
    end
  end,
})

return {}
