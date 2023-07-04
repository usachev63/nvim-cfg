--- Navigation between files (or other entities) in Neovim.
-- @module navigation

local M = {}

local vim = vim
local g = vim.g
local o = vim.o
local b = vim.b
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

local telescope = require 'shar.navigation.telescope'
local nvim_tree = require 'shar.navigation.nvim_tree'
local options = require 'shar.options'

local function setup_cur_dir_abbrev()
  keymap.set('c', '%%', function()
    if fn.getcmdtype() == ':' then
      return M.get_current_buf_dir()
    end
    return '%%'
  end, {
    expr = true,
    replace_keycodes = true,
  })
end

local function tab_change_to_current_buf_dir()
  local dir = M.get_current_buf_dir()
  vim.cmd('tchdir ' .. dir)
  print("Changed tab directory to '" .. dir .. "'")
end

local function setup_keymaps()
  -- %% in command-line mode maps to the path of directory of current buffer
  setup_cur_dir_abbrev()

  -- <Leader>tc: change tab cwd to directory of current buffer
  keymap.set('n', '<Leader>tc', tab_change_to_current_buf_dir)

  -- <Leader>e: open directory of current buffer
  if options.navigation.nvim_tree.enabled then
    keymap.set('n', '<Leader>e', require('nvim-tree').open_replacing_current_buffer)
  else
    keymap.set('n', '<Leader>e', ':e %%<CR>', { remap = true })
  end
end

--- Get the path to the directory
--  corresponding to the current buffer.
function M.get_current_buf_dir()
  if o.filetype == 'netrw' and b.netrw_curdir then
    return b.netrw_curdir .. "/"
  end
  if o.buftype == 'terminal' and b.term_title then
    return b.term_title:match(":(.*)") .. "/"
  end
  return api.nvim_buf_get_name(0):match("(.*/)")
end

function M.pre_netrw()
  g.netrw_banner = false
  if options.navigation.nvim_tree.enabled then
    -- Early hijack netrw for nvim-tree
    g.loaded_netrw = 1
    g.loaded_netrwPlugin = 1
  end
end

function M.setup()
  telescope.setup()
  if options.navigation.nvim_tree.enabled then
    nvim_tree.setup()
  end
  setup_keymaps()
end

return M
