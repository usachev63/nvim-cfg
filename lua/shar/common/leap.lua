--[[
-- leap.nvim: fast and fancy navigation.
--]]
local packer = require 'packer'
packer.use 'ggandor/leap.nvim'

local leap = require 'leap'
leap.add_default_mappings()
