--[[
-- Load optional modules of my neovim config.
--]]

local status, modules = pcall(require, 'shar.modules.config')
if not status then
  -- Not a critical error, just don't load any modules
  do return end
end

if modules.lsp then
  require 'shar.modules.lsp.main'
end

if modules.latex then
  require 'shar.modules.latex.main'
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
