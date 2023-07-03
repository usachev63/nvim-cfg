--- The main module of my Neovim config.

local M = {}

local vim = vim
local g = vim.g
local o = vim.o
local opt = vim.opt

local packer = require 'packer'
local key = require 'shar.key'
local ui = require 'shar.ui'
local terminal = require 'shar.terminal'

--- Initialize packer.nvim plugin manager.
local function init_packer()
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- plugin manager itself
end

--- Initialize common plugins.
local function require_common_plugins()
  packer.use 'tpope/vim-surround'   -- surround text objects
  packer.use 'tpope/vim-commentary' -- comments
  packer.use 'tpope/vim-repeat'
  packer.use 'nelstrom/vim-visual-star-search'
  packer.use 'lambdalisue/suda.vim' -- sudo write fix
end

local function setup_indent()
  -- Enable full builtin filetype support
  vim.cmd 'filetype plugin indent on'

  -- Default indent
  o.tabstop = 8
  o.softtabstop = 4
  o.shiftwidth = 4
  o.expandtab = true
end

--- Initialize common vim options.
local function set_common_options()
  -- Buffers are not required to be written during buffer switch
  o.hidden = true
  -- Register "+ is essentially equal to register ""
  o.clipboard = 'unnamedplus'
  -- :substitute command has [g] flag by default
  o.gdefault = true

  -- Add all subdirectories of current working directory.
  -- For use in :find, gf, etc.
  opt.path:append { "**" }

  -- zsh-like autocompletion in Ex mode
  o.wildmenu = true
  o.wildmode = 'full'

  -- Search options
  o.ignorecase = true
  o.smartcase = true
  o.infercase = true

  setup_indent()

  -- Fix python3 provider
  g.python3_host_prog = '/usr/bin/python3'
end

--- Initialize the Neovim config.
function M.init()
  -- Early hijack netrw for nvim-tree
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1

  init_packer()
  key.init()
  require_common_plugins()
  set_common_options()
  ui.init()
  terminal.setup()

  -- Optional modules.
  --
  -- The list of loaded modules and their parameters
  -- are configured in lua/shar/modules/config.lua.
  require 'shar.modules.load'
end

return M
