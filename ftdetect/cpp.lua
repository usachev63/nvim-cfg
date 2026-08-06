local augroup = vim.api.nvim_create_augroup("u63/cpp_extra_ftdetect", {})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tpp" },
  callback = function()
    vim.bo.filetype = 'cpp'
  end,
  group = augroup,
})
