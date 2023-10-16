local M = {}

local vim = vim

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

function M.setup()
  vim.g.mkdp_echo_preview_url = 1
end

return M
