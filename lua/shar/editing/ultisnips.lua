---Support for snippets via UltiSnips snippet engine.

local M = {}

local vim = vim
local keymap = vim.keymap
local g = vim.g

local packer = require 'packer'

---Set up UltiSnips support.
function M.setup()
  packer.use {
    'SirVer/ultisnips',
    requires = {
      'reconquest/vim-pythonx',
    }
  }

  keymap.set({ 'n', 'i' }, '<C-J>', '<Nop>')
  g.UltiSnipsExpandTrigger = '<C-l>'
  g.UltiSnipsJumpForwardTrigger = '<C-j>'
  g.UltiSnipsJumpBackwardTrigger = '<C-k>'
end

return M
