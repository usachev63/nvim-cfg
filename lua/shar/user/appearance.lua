--[[
-- Appearance default settings.
--]]
local vim = vim
local o = vim.o
local g = vim.g

o.number = true
o.hlsearch = false
o.listchars = 'tab:..,nbsp:+'
o.list = true
o.splitright = true
o.termguicolors = true
o.showmode = false

--- Gruvbox color scheme.
g.gruvbox_italic = 1
vim.cmd 'colorscheme gruvbox'
