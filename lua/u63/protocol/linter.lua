---Support of linters via nvim-lint.

local M = {}

function M.pack()
  require('packer').use 'mfussenegger/nvim-lint'
end

function M.init()
  local lint = require 'lint'
  lint.linters_by_ft = {
    -- yaml = { 'yamllint' },
  }
  local augroup = vim.api.nvim_create_augroup('u63.linter', {})
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost' }, {
    callback = function()
      lint.try_lint()
    end,
    group = augroup,
  })
end

return M
