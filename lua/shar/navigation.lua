---Navigation between files (or other entities) in Neovim.

local M = {}

local vim = vim
local g = vim.g
local o = vim.o
local b = vim.b
local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

local nvim_tree
local nvim_tree_api

local options = require 'shar.options'
local telescope = require 'shar.navigation.telescope'
local shar_nvim_tree = require 'shar.navigation.nvim_tree'

---'%%' in command-line mode maps to the current buffer directory path.
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

---Change current tab directory to current buffer directory.
local function tab_change_to_current_buf_dir()
  local dir = M.get_current_buf_dir()
  vim.cmd('tchdir ' .. dir)
  print("Changed tab directory to '" .. dir .. "'")
end

---Set up some useful navigation keymaps.
local function setup_keymaps()
  setup_cur_dir_abbrev()

  -- <Leader>tc: change tab cwd to directory of current buffer
  keymap.set('n', '<Leader>tc', tab_change_to_current_buf_dir)

  -- <Leader>e: open directory of current buffer
  if nvim_tree then
    keymap.set('n', '<Leader>e', nvim_tree.open_replacing_current_buffer)
  else
    keymap.set('n', '<Leader>e', ':e %%<CR>', { remap = true })
  end
end

---Get the path to the current buffer directory.
---@return string
function M.get_current_buf_dir()
  if nvim_tree and nvim_tree_api.tree.is_tree_buf(0) then
    return nvim_tree_api.tree.get_nodes().absolute_path
  end
  if o.filetype == 'netrw' and b.netrw_curdir then
    return b.netrw_curdir .. "/"
  end
  if o.buftype == 'terminal' and b.term_title then
    return b.term_title:match(":(.*)") .. "/"
  end
  return api.nvim_buf_get_name(0):match("(.*/)")
end

---A callback, which is called before netrw is loaded.
---
---If nvim-tree is activated, this function prevents
---netrw from loading.
function M.pre_netrw()
  g.netrw_banner = false
  if nvim_tree then
    -- Early hijack netrw for nvim-tree
    g.loaded_netrw = 1
    g.loaded_netrwPlugin = 1
  end
end

---Set up navigation module.
function M.setup()
  telescope.setup()
  if options.navigation.nvim_tree.enabled then
    nvim_tree = require 'nvim-tree'
    nvim_tree_api = require 'nvim-tree.api'
    shar_nvim_tree.setup()
  end
  setup_keymaps()
end

return M
