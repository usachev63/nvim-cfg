---leap.nvim
-- Fast and fancy navigation in Neovim.

local M = {}

local packer = require 'packer'
local leap = require 'leap'
local layout_api = require 'shar.os_layout_api'
local do_leap = leap.leap
local keymap = vim.keymap

local safe_labels = {
  "f", "s", "n", "u", "t", "/",
  "F", "S", "N", "L", "H", "M", "U", "G", "T", "?", "Z",
}
local labels = {
  "f", "s", "n",
  "j", "k", "l", "h", "o", "d", "w", "e", "m", "b",
  "u", "y", "v", "r", "g", "t", "c", "x", "/", "z",
  "F", "S", "N",
  "J", "K", "L", "H", "O", "D", "W", "E", "M", "B",
  "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z",
}
local ru_safe_labels = {
  'а', 'ы', 'т', 'г', 'е', '.',
  'А', 'Ы', 'Т', 'Д', 'Р', 'Ь', 'Г', 'П', 'Е', ',', 'Я',
}
local ru_labels = {
  'а', 'ы', 'т',
  'о', 'л', 'д', 'р', 'щ', 'в', 'ц', 'у', 'ь', 'и',
  'г', 'н', 'м', 'к', 'п', 'е', 'с', 'ч', '.', 'я',
  'А', 'Ы', 'Т',
  'О', 'Л', 'Д', 'Р', 'Щ', 'В', 'Ц', 'У', 'Ь', 'И',
  'Г', 'Н', 'М', 'К', 'П', 'Е', 'С', 'Ч', ',', 'Я',
}

local function map_leap(mode, key, leap_opts)
  keymap.set(mode, key, function()
    layout_api.set_layout('us')
    do_leap(leap_opts)
  end)
  keymap.set(mode, ',' .. key, function()
    layout_api.set_layout('ru')
    local ru_opts = {
      opts = {
        safe_labels = ru_safe_labels,
        ru_labels = ru_labels
      }
    }
    setmetatable(ru_opts, { __index = leap_opts })
    do_leap(ru_opts)
  end)
end

local function setup_keymaps()
  map_leap('n', 'f', {})
  map_leap({ 'n', 'x', 'o' }, 'F', { backward = true })
  map_leap({ 'x', 'o' }, 'f', { offset = 1, inclusive_op = true })
  map_leap({ 'x', 'o' }, 'x', { offset = -1, inclusive_op = true })
  map_leap({ 'x', 'o' }, 'X', { backward = true, offset = 2, })
end

---Setup leap.nvim plugin
function M.init()
  packer.use 'ggandor/leap.nvim'
  leap.opts.safe_labels = safe_labels
  leap.opts.labels = labels
  setup_keymaps()
end

return M
