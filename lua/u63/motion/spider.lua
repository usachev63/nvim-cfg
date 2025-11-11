---Spider, that bandage on your foot is bigger than your fucking head.
---Next thing you know he'll have one of these fucking walkers.
---But you can still dance. Give us a couple of fucking steps, Spider.
---You fucking bullshitter, you. Tell the truth.
---You want sympathy, is that right, sweetie?

local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use 'chrisgrieser/nvim-spider'
end

function M.setup()
  vim.keymap.set(
    { 'n', 'o', 'x' },
    'w',
    "<cmd>lua require('spider').motion('w')<CR>",
    { desc = 'Spider-w' }
  )
  vim.keymap.set(
    { 'n', 'o', 'x' },
    'e',
    "<cmd>lua require('spider').motion('e')<CR>",
    { desc = 'Spider-e' }
  )
  vim.keymap.set(
    { 'n', 'o', 'x' },
    'b',
    "<cmd>lua require('spider').motion('b')<CR>",
    { desc = 'Spider-b' }
  )
end

return M
