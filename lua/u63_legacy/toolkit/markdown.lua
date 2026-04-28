local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    ft = { 'markdown' },
  }
end

function M.setup()
  vim.g.mkdp_echo_preview_url = 1
  vim.g.mkdp_auto_close = 0

  vim.cmd {
    cmd = 'cnoreabbrev',
    args = {
      '<expr>',
      'MDP',
      '"MarkdownPreview"',
    },
  }
end

return M
