--[[
-- General user keymaps.
--]]
local vim = vim
local keymap = vim.keymap
local g = vim.g
local api = vim.api
local v = vim.v

-- Space is the leader key.
keymap.set('n', '<Space>', '<Nop>')
g.mapleader = ' '
g.maplocalleader = ' '
keymap.set('i', '<C-Space>', '<Space>') -- prevent unexpected insert mode leave

-- ',' is another leader key
keymap.set('n', ',', '<Nop>')
keymap.set('x', ',', '<Nop>')

-- Open netrw at the directory of the file.
-- Instead of :E (now getting E464 error)
keymap.set('n', '<Leader>e', ':e %%<CR>', { remap = true })

-- Destroy current buffer.
keymap.set('n', '<Leader>q', function()
  api.nvim_buf_delete(0, { force = true })
end)

-- Replace all buffer content with content from "+ register.
keymap.set('n', '<Leader>dp', ':%delete|0put+<CR>gg')

-- Switch with alternate file
keymap.set('n', '<BS>', '<C-^>')

-- Goto next/previous item in a list.
-- Inspired by vim-unimpaired plugin.
local function goto_callback(goto_command)
  local command = {
    cmd = goto_command,
    mods = {
      emsg_silent = true,
    }
  }
  local count = v.count
  if count and count > 0 then
    command.range = { count }
  end
  api.nvim_cmd(command, {})
end

local function set_goto_keymap(lhs, goto_command)
  keymap.set('n', lhs, function()
    goto_callback(goto_command)
  end)
end

-- Argument list.
set_goto_keymap(']a', 'next')
set_goto_keymap('[a', 'previous')
set_goto_keymap(']A', 'last')
set_goto_keymap('[A', 'first')
-- Quickfix list.
set_goto_keymap(']q', 'cnext')
set_goto_keymap('[q', 'cprevious')
set_goto_keymap(']Q', 'clast')
set_goto_keymap('[Q', 'cfirst')
set_goto_keymap(']<C-Q>', 'cnfile')
set_goto_keymap('[<C-Q>', 'cpfile')

-- Toggle common options.
-- Inspired by vim-unimpaired plugin.
keymap.set('n', 'yoh', function()
  vim.o.hlsearch = not vim.o.hlsearch
end)
