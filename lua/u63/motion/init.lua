---Vim motion settings.

local M = {}

local u_leap = require 'u63.motion.leap'
local u_nullstart = require 'u63.motion.nullstar'
local u_spider = require 'u63.motion.spider'

function M.pack()
  u_leap.pack()
  u_spider.pack()
end

function M.setup()
  u_leap.setup()
  u_nullstart.setup()
  u_spider.setup()
end

return M
