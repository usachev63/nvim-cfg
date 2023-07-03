--- key module:
-- keymaps, keyboard layouts support.

local M = {}

local vim = vim
local keymap = vim.keymap
local g = vim.g

local langmapper = require 'shar.key.langmapper'
local user_maps = require 'shar.key.user_maps'

--- Set <Space> as the leader key.
local function set_leader()
  keymap.set('n', '<Space>', '<Nop>')
  g.mapleader = ' '
  g.maplocalleader = ' '
  -- Prevent unexpected insert mode leave
  keymap.set('i', '<C-Space>', '<Space>')
end

function M.init()
  set_leader()
  langmapper.init()
  user_maps.setup_maps()
end

return M
