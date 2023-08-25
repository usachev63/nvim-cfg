local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { 'markdown' },
  }
end

function M.setup() end

return M
