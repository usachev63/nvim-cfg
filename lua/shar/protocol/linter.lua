---Support of linters via nvim-lint.

local M = {}

function M.init()
  local packer = require 'packer'
  packer.use 'mfussenegger/nvim-lint'
  local lint = require 'lint'
  lint.linters_by_ft = {
    lua = { 'luacheck' }
  }
  local augroup = vim.api.nvim_create_augroup('SharLinter', {})
  vim.api.nvim_create_autocmd('BufWritePost', {
    callback = function()
      lint.try_lint()
    end,
    group = augroup,
  })
end

return M
