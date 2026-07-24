local augroup = vim.api.nvim_create_augroup('u63/formatter_bind', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'astro' },
  callback = function()
    vim.keymap.set('n', '<Leader>fm', ':Format<CR>', { buffer = true })
  end,
  group = augroup,
})

return {
  {
    "mhartington/formatter.nvim",
    lazy = false,
    config = function()
      require("formatter").setup({
        filetype = {
          astro = require("formatter.defaults.prettier"),
        }
      })
    end,
  }
}
