---Support of linters via nvim-lint.

local M = {}

function M.pack()
  require('packer').use 'mfussenegger/nvim-lint'
end

function M.init()
  local lint = require 'lint'
  lint.linters_by_ft = {
    lua = { 'luacheck' },
    yaml = { 'yamllint' },
  }
  local augroup = vim.api.nvim_create_augroup('SharLinter', {})
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost' }, {
    callback = function()
      lint.try_lint()
    end,
    group = augroup,
  })
end

return M
