--[[
-- Load optional modules of my neovim config.
--]]

local status, modules = pcall(require, 'shar.modules.config')
if not status then
  -- Not a critical error, just don't load any modules
  do return end
end

if modules.localcfg then
  require 'shar.modules.localcfg'
end

if modules.leap then
  require('shar.modules.leap').init()
end

if modules.ultisnips then
  require 'shar.modules.ultisnips'
end

if modules.latex then
  assert(modules.ultisnips)
  local latex = require 'shar.modules.latex.main'
  latex.init(modules.latex)
end

if modules.acmcpp then
  require 'shar.modules.acmcpp'
end

if modules.coq then
  require 'shar.modules.coq'
end

if modules.dafny then
  require 'shar.modules.dafny'
end
