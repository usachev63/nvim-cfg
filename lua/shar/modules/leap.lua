--[[
-- leap.nvim: fast and fancy navigation.
--]]
local packer = require 'packer'
packer.use 'ggandor/leap.nvim'

local leap = require 'leap'
local do_leap = leap.leap

local keymap = vim.keymap
local o = vim.o

keymap.set({ 'n', 'x', 'o' }, 'f', '<Nop>')
keymap.set({ 'n', 'x', 'o' }, 'F', '<Nop>')

local function map_leap(mode, key, leap_opts)
  keymap.set(mode, key, function()
    o.iminsert = 0
    do_leap(leap_opts)
  end)
  keymap.set(mode, ',' .. key, function()
    o.iminsert = 1
    do_leap(leap_opts)
  end)
end

map_leap('n', 'f', {})
map_leap({ 'n', 'x', 'o' }, 'F', { backward = true })
map_leap({ 'x', 'o' }, 'f', { offset = 1, inclusive_op = true })
map_leap({ 'x', 'o' }, 'x', { offset = -1, inclusive_op = true })
map_leap({ 'x', 'o' }, 'X', { backward = true, offset = 2, })
