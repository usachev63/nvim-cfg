local augroup = vim.api.nvim_create_augroup("CppExtraFtDetect", {})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tpp", "*.acm" },
  callback = function()
    vim.bo.filetype = 'cpp'
  end,
  group = augroup,
})
