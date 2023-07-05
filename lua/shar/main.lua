---The main module of shar-nvim-cfg.

local M = {}

local vim = vim
local g = vim.g
local o = vim.o
local opt = vim.opt
local fn = vim.fn

local packer = require 'packer'

local options = require 'shar.options'
local key = require 'shar.key'
local langmapper = require 'shar.key.langmapper'
local ui = require 'shar.ui'
local terminal = require 'shar.terminal'
local protocol = require 'shar.protocol'
local editing = require 'shar.editing'
local navigation = require 'shar.navigation'
local motion = require 'shar.motion'
local toolkit = require 'shar.toolkit'

---Initialize packer.nvim plugin manager.
local function init_packer()
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- declare plugin manager itself
end

---Declare common plugins.
local function require_common_plugins()
  packer.use 'tpope/vim-surround'   -- surround text objects
  packer.use 'tpope/vim-commentary' -- comments
  packer.use 'tpope/vim-repeat'
  packer.use 'nelstrom/vim-visual-star-search'
  packer.use 'lambdalisue/suda.vim' -- sudo write fix
end

---Set common vim options and globals.
local function set_common_options()
  -- Enable full builtin filetype support
  vim.cmd 'filetype plugin indent on'

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

  -- Default indent options
  o.softtabstop = 4
  o.shiftwidth = 4
  o.expandtab = true

  -- Fix python3 provider,
  -- useful when working under a python venv
  g.python3_host_prog = '/usr/bin/python3'
end

---Set up nvim-config-local plugin for support of project-local .vimrc files.
local function setup_localvimrc()
  packer.use 'klen/nvim-config-local'
  require('config-local').setup {
    config_files = { ".vimrc.lua", ".vimrc" },
    hashfile = fn.stdpath("data") .. "/config-local",
    autocommands_create = true,
    commands_create = true,
    silent = false,
    lookup_parents = false,
  }
end

---Initialize shar-nvim-cfg.
---
---It is pretty much the entry point of shar-nvim-cfg.
---A good place to call it is directly in init.lua.
---
---Same version of shar-nvim-cfg can be used on many setups simultaneously.
---Each setup will have a different init.lua, in which init is called with
---different options, adjusting the config for this particular setup.
---For this exact reason init.lua is a part of .gitignore.
---
---@param opts any Raw, user-provided options for shar-nvim-cfg.
---@see Options class for all available options
---and their default values (`default_options` local variable)
function M.init(opts)
  options.init(opts)

  navigation.pre_netrw()

  init_packer()
  key.init()

  require_common_plugins()
  set_common_options()
  ui.init()
  terminal.setup()
  protocol.init()
  editing.setup()
  navigation.setup()
  motion.setup()
  if options.localvimrc then
    setup_localvimrc()
  end
  toolkit.setup()

  if options.key.enable_langmapper then
    langmapper.do_automapping()
  end
end

return M
