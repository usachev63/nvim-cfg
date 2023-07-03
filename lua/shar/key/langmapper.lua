--- langmapper.nvim: automatic translation of keymaps
--  in different keyboard layouts.
--
-- @module key.langmapper

local M = {}

local vim = vim
local fn = vim.fn
local opt = vim.opt
local keymap = vim.keymap

local packer = require 'packer'
local layout_api = require 'shar.key.layout_api'

local function escape(str)
  local escape_chars = [[;,."|\]]
  return fn.escape(str, escape_chars)
end

local en_lower = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru_lower = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_upper = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_upper = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

local function setup_langmap()
  opt.langmap = fn.join({
    escape(ru_lower) .. ';' .. escape(en_lower),
    escape(ru_upper) .. ';' .. escape(en_upper),
  }, ',')
end

local en_full = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,./~@$^&QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?]]
local ru_full = [[ёйцукенгшщзхъфывапролджэячсмитьбю.Ё";:?ЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,]]

local function setup_langmapper()
  local langmapper = require 'langmapper'
  langmapper.setup {
    map_all_ctrl = false,
    default_layout = en_full,
    disable_hack_modes = { 'i', 't' },
    layouts = {
      ru = {
        id = 'ru',
        layout = ru_full,
      }
    },
    os = {
      Linux = {
        get_current_layout_id = layout_api.get_layout,
      },
    },
  }
end

local function setup_extra_keymaps()
  -- Handle this manually because
  -- adding it in langmapper layout
  -- will cause huge slow down
  -- on every key press.
  keymap.set({ 'n', 'v', 'o' }, '№', '#')

  -- Switch to 'us' layout upon entering command-line mode
  keymap.set('n', ':', function()
    layout_api.set_layout('us')
    return ':'
  end, { expr = true })
end

--- Setup langmapper.nvim plugin.
function M.init()
  packer.use 'sharkov63/langmapper.nvim'
  setup_langmap()
  setup_langmapper()
  setup_extra_keymaps()
end

return M
