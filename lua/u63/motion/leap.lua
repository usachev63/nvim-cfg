---leap.nvim plugin: fast and fancy motions in Neovim.

local M = {}

local vim = vim
local keymap = vim.keymap

local leap

local layout_api = require 'u63.key.layout_api'

local safe_labels = {
  's',
  'f',
  'n',
  'u',
  't',
  '/',
  'S',
  'F',
  'N',
  'L',
  'H',
  'M',
  'U',
  'G',
  'T',
  '?',
  'Z',
}
local labels = {
  's',
  'f',
  'n',
  'j',
  'k',
  'l',
  'h',
  'o',
  'd',
  'w',
  'e',
  'm',
  'b',
  'u',
  'y',
  'v',
  'r',
  'g',
  't',
  'c',
  'x',
  '/',
  'z',
  'S',
  'F',
  'N',
  'J',
  'K',
  'L',
  'H',
  'O',
  'D',
  'W',
  'E',
  'M',
  'B',
  'U',
  'Y',
  'V',
  'R',
  'G',
  'T',
  'C',
  'X',
  '?',
  'Z',
}
local ru_safe_labels = {
  'ы',
  'а',
  'т',
  'г',
  'е',
  '.',
  'Ы',
  'А',
  'Т',
  'Д',
  'Р',
  'Ь',
  'Г',
  'П',
  'Е',
  ',',
  'Я',
}
local ru_labels = {
  'ы',
  'а',
  'т',
  'о',
  'л',
  'д',
  'р',
  'щ',
  'в',
  'ц',
  'у',
  'ь',
  'и',
  'г',
  'н',
  'м',
  'к',
  'п',
  'е',
  'с',
  'ч',
  '.',
  'я',
  'Ы',
  'А',
  'Т',
  'О',
  'Л',
  'Д',
  'Р',
  'Щ',
  'В',
  'Ц',
  'У',
  'Ь',
  'И',
  'Г',
  'Н',
  'М',
  'К',
  'П',
  'Е',
  'С',
  'Ч',
  ',',
  'Я',
}

---Create a leap keymap.
---
---If layout API is available, an additional keymap prefixed with ','
---is added, which allows to leap onto russian text.
---
---@param mode string|string[] Vim mode/modes influenced by the mapping.
---@param key string Left-hand side of the keymap.
---@param leap_opts table Leap 'opts' table (see leap docs).
local function map_leap(mode, key, leap_opts)
  if layout_api.get_layout then
    keymap.set(mode, key, function()
      layout_api.set_layout 'us'
      leap.leap(leap_opts)
    end)
    keymap.set(mode, ',' .. key, function()
      layout_api.set_layout 'ru'
      local ru_opts = {
        opts = {
          safe_labels = {},
          labels = ru_labels,
        },
      }
      setmetatable(ru_opts, { __index = leap_opts })
      leap.leap(ru_opts)
    end)
  else
    keymap.set(mode, key, function()
      leap.leap(leap_opts)
    end)
  end
end

---Set up leap keymaps (which differ from defaults).
local function setup_keymaps()
  map_leap('n', 's', {})
  map_leap({ 'n', 'x', 'o' }, 'S', { backward = true })
  map_leap({ 'x', 'o' }, 's', { offset = 1, inclusive_op = true })
  map_leap({ 'x', 'o' }, 'x', { offset = -1, inclusive_op = true })
  map_leap({ 'x', 'o' }, 'X', { backward = true, offset = 2 })
end

function M.pack()
  require('packer').use 'ggandor/leap.nvim'
end

---Set up integration leap.nvim.
function M.setup()
  leap = require 'leap'
  leap.opts.safe_labels = safe_labels
  leap.opts.labels = labels
  setup_keymaps()
end

return M
