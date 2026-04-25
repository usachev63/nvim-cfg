local M = {}

local u_options = require 'u63_2.options'

---source: lazy.nvim docs
local function bootstrap_lazy()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      lazyrepo,
      lazypath,
    }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
        { out, 'WarningMsg' },
        { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

local function vim_primitive_config()
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

  vim.o.foldenable = false

  ---Set <Space> as the leader key.
  vim.keymap.set('n', '<Space>', '<Nop>')
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  -- Prevent unexpected insert mode leave
  vim.keymap.set('i', '<C-Space>', '<Space>')
end

---Initialize u63-nvim-cfg.
---
---It is pretty much the entry point of u63-nvim-cfg.
---A good place to call it is directly in init.lua.
---
---Same version of u63-nvim-cfg can be used on many setups simultaneously.
---Each setup will have a different init.lua, in which init is called with
---different options, adjusting the config for this particular setup.
---For this exact reason init.lua is a part of .gitignore.
---
---@param opts any Raw, user-provided options for u63-nvim-cfg.
---@see Options class for all available options
---and their default values (`default_options` local variable)
function M.init(opts)
  u_options.init(opts)
  bootstrap_lazy()
  vim_primitive_config()
  local lazy = require 'lazy'
  lazy.setup 'u63_2.plugins'

  -- u_packer.pack()

  -- key.init()
  -- common.setup()
  -- ui.init()
  -- terminal.setup()
  -- editing.setup()
  -- navigation.setup()
  -- motion.setup()
  -- toolkit.setup()
  -- protocol.init()
  -- u63_quickfix.setup()

  -- if options.key.enable_langmapper then
  --   langmapper.do_automapping()
  -- end
end

return M
