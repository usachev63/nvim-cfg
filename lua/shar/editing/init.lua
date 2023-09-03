---Utilities directly controlling text editing.

local M = {}

local options = require 'shar.options'
local cmp = require 'shar.editing.cmp'
local autopairs = require 'shar.editing.autopairs'
local ultisnips = require 'shar.editing.ultisnips'
local sakls = require 'shar.editing.sakls'

function M.pack()
  local opts = options.editing
  if opts.cmp then
    cmp.pack()
  end
  if opts.enable_autopairs then
    autopairs.pack()
  end
  if opts.sakls.enabled then
    sakls.pack()
  end
  ultisnips.pack()
end

---Set up editing module.
function M.setup()
  local opts = options.editing
  if opts.cmp then
    cmp.init()
  end
  if opts.enable_autopairs then
    autopairs.init()
  end
  if opts.sakls.enabled then
    sakls.set_up()
  end
  ultisnips.setup()
end

return M
