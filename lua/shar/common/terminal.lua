--[[
-- Shell and terminal buffer settings.
--]]
local vim = vim

-- Set appropriate 'shell' option
if vim.fn.executable('zsh') then
  vim.o.shell = '/usr/bin/zsh -li'
elseif vim.fn.executable('bash') then
  vim.o.shell = '/usr/bin/bash -li'
end

-- Escape from terminal buffer with Esc.
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-[>', '<C-\\><C-n>', { noremap = true })

-- Autocommands
local augroup = vim.api.nvim_create_augroup('Terminal', {})
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
  end,
  group = augroup,
})
