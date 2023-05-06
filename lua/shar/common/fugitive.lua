--[[
-- vim-fugitive: Git integration
--]]
local vim = vim
local packer = require 'packer'
packer.use 'tpope/vim-fugitive'

-- Merge conflict resolution keymaps
vim.api.nvim_set_keymap('n', '<Leader>df', ':Gvdiffsplit!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dh', ':diffget //2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':diffget //3<CR>', { noremap = true })

local augroup = vim.api.nvim_create_augroup('Fugitive', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    vim.api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
  end,
  group = augroup,
})
