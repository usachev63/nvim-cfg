--- Utilities which directly simplify editing text.
-- @module editing

local M = {}

local options = require 'shar.options'

local cmp = require 'shar.editing.cmp'
local autopairs = require 'shar.editing.autopairs'
local ultisnips = require 'shar.editing.ultisnips'

function M.setup()
  local opts = options.editing
  if opts.cmp then
    cmp.init()
  end
  if opts.enable_autopairs then
    autopairs.init()
  end
  ultisnips.setup()
end

return M
