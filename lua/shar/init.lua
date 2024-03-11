---The main module of shar-nvim-cfg.

local M = {}

local vim = vim
local fn = vim.fn

local shar_packer = require 'shar.packer'
local options = require 'shar.options'
local common = require 'shar.common'
local key = require 'shar.key'
local langmapper = require 'shar.key.langmapper'
local ui = require 'shar.ui'
local terminal = require 'shar.terminal'
local protocol = require 'shar.protocol'
local editing = require 'shar.editing'
local navigation = require 'shar.navigation'
local motion = require 'shar.motion'
local toolkit = require 'shar.toolkit'

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

  shar_packer.pack()

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
