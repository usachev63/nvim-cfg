--[[
-- Misc user settings.
--]]
local vim = vim
local o = vim.o
local opt = vim.opt
local g = vim.g

--- General

-- Buffers are not required to be written during buffer switch
o.hidden = true
-- Register "+ is essentially equal to register ""
o.clipboard = 'unnamedplus'
-- :substitute command has [g] flag by default
o.gdefault = true

-- Add all subdirectories of current working directory.
-- For use in :find, gf, etc.
opt.path:append { "**" }

-- zsh-like autocompletion in Ex mode
o.wildmenu = true
o.wildmode = 'full'

--- Search options

o.ignorecase = true
o.smartcase = true
o.infercase = true

-- Workaround for SQLComplete:
-- the dbext plugin must be loaded
-- for dynamic SQL completion problem
g.omni_sql_default_compl_type = 'syntax'

-- Fixed python3 provider
g.python3_host_prog = '/usr/bin/python3'
