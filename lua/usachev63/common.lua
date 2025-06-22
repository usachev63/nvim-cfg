---Common settings.

local M = {}

local packer = require 'packer'
local options = require 'usachev63.options'

function M.pack()
  packer.use 'tpope/vim-surround' -- surround text objects
  packer.use 'tpope/vim-commentary' -- comments
  packer.use 'tpope/vim-repeat'
  packer.use 'lambdalisue/suda.vim' -- sudo write fix
  if options.localvimrc then
    packer.use 'klen/nvim-config-local'
  end
end

---Set up nvim-config-local plugin for support of project-local .vimrc files.
local function setup_localvimrc()
  require('config-local').setup {
    config_files = { '.vimrc.lua', '.vimrc' },
    hashfile = vim.fn.stdpath 'data' .. '/config-local',
    autocommands_create = true,
    commands_create = true,
    silent = false,
    lookup_parents = false,
  }
end

---Set common vim options and globals.
function M.setup()
  -- Enable full builtin filetype support
  vim.cmd 'filetype plugin indent on'

  -- Buffers are not required to be written during buffer switch
  vim.o.hidden = true
  -- Register "+ is essentially equal to register ""
  vim.o.clipboard = 'unnamedplus'
  -- :substitute command has [g] flag by default
  vim.o.gdefault = true

  -- Add all subdirectories of current working directory.
  -- For use in :find, gf, etc.
  vim.opt.path:append { '**' }

  -- zsh-like autocompletion in Ex mode
  vim.o.wildmenu = true
  vim.o.wildmode = 'full'

  -- Search options
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.infercase = true

  -- Default indent options
  vim.o.softtabstop = 4
  vim.o.shiftwidth = 4
  vim.o.expandtab = true

  vim.o.spelloptions = 'camel'

  vim.o.wrap = false

  if options.localvimrc then
    vim.o.exrc = true
    setup_localvimrc()
  end
  -- setup_venv_selector()
end

return M
