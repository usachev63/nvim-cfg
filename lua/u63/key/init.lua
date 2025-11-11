---Manipulations with keymaps and keyboard layouts.

local M = {}

local vim = vim
local keymap = vim.keymap
local g = vim.g

local options = require 'u63.options'
local layout_api = require 'u63.key.layout_api'
local langmapper = require 'u63.key.langmapper'
local user_maps = require 'u63.key.user_maps'

---Set <Space> as the leader key.
local function set_leader()
  keymap.set('n', '<Space>', '<Nop>')
  g.mapleader = ' '
  g.maplocalleader = ' '
  -- Prevent unexpected insert mode leave
  keymap.set('i', '<C-Space>', '<Space>')
end

function M.pack()
  if options.key.enable_langmapper then
    langmapper.pack()
  end
end

---Initialize key module.
function M.init()
  layout_api.init(options.key.layout_lib)
  set_leader()
  if options.key.enable_langmapper then
    langmapper.init()
    if not layout_api.get_layout then
      error(
        '[u63.key] Cannot use langmapper.nvim without layout_api backend!',
        3
      )
    end
  end
  user_maps.setup_maps()
end

return M
