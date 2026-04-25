local M = {}

local u_basic_config = require 'u63_2.basic_config'
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
  u_basic_config.setup_all()
  local lazy = require 'lazy'
  lazy.setup {
    spec = { { import = 'u63_2.plugins' } },
    install = { colorscheme = { 'catppuccin-frappe' } },
  }
end

return M
