---Utilities directly controlling text editing.

local M = {}

local options = require 'u63.options'
local cmp = require 'u63.editing.cmp'
local autopairs = require 'u63.editing.autopairs'
local ultisnips = require 'u63.editing.ultisnips'
local sakls = require 'u63.editing.sakls'

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
