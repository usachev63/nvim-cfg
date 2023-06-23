--[[
-- General indentation settings.
--]]
local vim = vim
local o = vim.o

-- Enable full builtin filetype support.
vim.cmd 'filetype plugin indent on'

-- Default indent
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4

o.expandtab = true
o.linebreak = true

o.breakindent = true
o.breakindentopt = 'sbr'
o.showbreak = '↳'
