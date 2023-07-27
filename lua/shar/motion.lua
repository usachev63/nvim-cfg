---Vim motion settings.

local M = {}

local shar_leap = require 'shar.motion.leap'

function M.pack()
  shar_leap.pack()
end

function M.setup()
  shar_leap.init()
end

return M
