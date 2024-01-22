---Vim motion settings.

local M = {}

local shar_leap = require 'shar.motion.leap'
local shar_nullstar = require 'shar.motion.nullstar'

function M.pack()
  shar_leap.pack()
end

function M.setup()
  shar_leap.setup()
  shar_nullstar.setup()
end

return M
