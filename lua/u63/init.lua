---The main module of u63-nvim-cfg.

local M = {}

local u_packer = require 'u63.packer'
local options = require 'u63.options'
local common = require 'u63.common'
local key = require 'u63.key'
local langmapper = require 'u63.key.langmapper'
local ui = require 'u63.ui'
local terminal = require 'u63.terminal'
local protocol = require 'u63.protocol'
local editing = require 'u63.editing'
local navigation = require 'u63.navigation'
local motion = require 'u63.motion'
local toolkit = require 'u63.toolkit'
local u63_quickfix = require 'u63.quickfix'

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
  options.init(opts)

  navigation.pre_netrw()

  u_packer.pack()

  key.init()
  common.setup()
  ui.init()
  terminal.setup()
  editing.setup()
  navigation.setup()
  motion.setup()
  toolkit.setup()
  protocol.init()
  u63_quickfix.setup()

  if options.key.enable_langmapper then
    langmapper.do_automapping()
  end
end

return M
