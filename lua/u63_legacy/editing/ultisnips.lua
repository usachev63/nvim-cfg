---Support for snippets via UltiSnips snippet engine.

local M = {}

local vim = vim
local keymap = vim.keymap
local g = vim.g

function M.pack()
  require('packer').use {
    'SirVer/ultisnips',
    requires = {
      'reconquest/vim-pythonx',
    },
  }
end

---Set up UltiSnips support.
function M.setup()
  keymap.set({ 'n', 'i' }, '<C-J>', '<Nop>')
  g.UltiSnipsExpandTrigger = '<C-l>'
  g.UltiSnipsJumpForwardTrigger = '<C-j>'
  g.UltiSnipsJumpBackwardTrigger = '<C-k>'
end

return M
