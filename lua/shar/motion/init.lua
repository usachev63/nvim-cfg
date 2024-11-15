---Vim motion settings.

local M = {}

local shar_leap = require 'shar.motion.leap'
local shar_nullstar = require 'shar.motion.nullstar'
local shar_spider = require 'shar.motion.spider'

function M.pack()
  shar_leap.pack()
  shar_spider.pack()
end

function M.setup()
  shar_leap.setup()
  shar_nullstar.setup()
  shar_spider.setup()
end

return M
