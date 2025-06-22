---Vim motion settings.

local M = {}

local u_leap = require 'usachev63.motion.leap'
local u_nullstart = require 'usachev63.motion.nullstar'
local u_spider = require 'usachev63.motion.spider'

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
