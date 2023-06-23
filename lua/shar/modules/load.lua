--[[
-- Load optional modules of my neovim config.
--]]

local status, modules = pcall(require, 'shar.modules.config')
if not status then
  -- Not a critical error, just don't load any modules
  do return end
end

if modules.cmp then
  require 'shar.modules.cmp'
end

if modules.lsp then
  require 'shar.modules.lsp.main'
end

if modules.fugitive then
  require 'shar.modules.fugitive'
end

if modules.localcfg then
  require 'shar.modules.localcfg'
end

if modules.leap then
  require 'shar.modules.leap'
end

if modules.telescope then
  require 'shar.modules.telescope'
end

if modules.ultisnips then
  require 'shar.modules.ultisnips'
end

if modules.tabby then
  require 'shar.modules.tabby'
end

if modules.autopairs then
  require 'shar.modules.autopairs'
end

if modules.lualine then
  require 'shar.modules.lualine'
end

if modules.keyboardlayout then
  require 'shar.modules.keyboardlayout'
end

if modules.chdir then
  require 'shar.modules.chdir'
end

if modules.latex then
  assert(modules.ultisnips)
  assert(modules.keyboardlayout)
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
