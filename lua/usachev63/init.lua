---The main module of usachev63-nvim-cfg.

local M = {}

local u_packer = require 'usachev63.packer'
local options = require 'usachev63.options'
local common = require 'usachev63.common'
local key = require 'usachev63.key'
local langmapper = require 'usachev63.key.langmapper'
local ui = require 'usachev63.ui'
local terminal = require 'usachev63.terminal'
local protocol = require 'usachev63.protocol'
local editing = require 'usachev63.editing'
local navigation = require 'usachev63.navigation'
local motion = require 'usachev63.motion'
local toolkit = require 'usachev63.toolkit'

---Initialize usachev63-nvim-cfg.
---
---It is pretty much the entry point of usachev63-nvim-cfg.
---A good place to call it is directly in init.lua.
---
---Same version of usachev63-nvim-cfg can be used on many setups simultaneously.
---Each setup will have a different init.lua, in which init is called with
---different options, adjusting the config for this particular setup.
---For this exact reason init.lua is a part of .gitignore.
---
---@param opts any Raw, user-provided options for usachev63-nvim-cfg.
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

  if options.key.enable_langmapper then
    langmapper.do_automapping()
  end
end

return M
