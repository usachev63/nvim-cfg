local M = {}

local vim = vim
local keymap = vim.keymap
local api = vim.api
local v = vim.v

---@param goto_command string
local function goto_callback(goto_command)
  local command = {
    cmd = goto_command,
    mods = {
      emsg_silent = true,
    },
  }
  local count = v.count
  if count and count > 0 then
    command.range = { count }
  end
  api.nvim_cmd(command, {})
end

---@param lhs string
---@param goto_command string
local function set_goto_keymap(lhs, goto_command)
  keymap.set('n', lhs, function()
    goto_callback(goto_command)
  end)
end

---Setup keymaps for goto next/previous item in a list.
---Inspired by vim-unimpaired plugin.
local function setup_goto_maps()
  -- Quickfix list
  set_goto_keymap(']q', 'cnext')
  set_goto_keymap('[q', 'cprevious')
  set_goto_keymap(']Q', 'clast')
  set_goto_keymap('[Q', 'cfirst')
  set_goto_keymap(']<C-Q>', 'cnfile')
  set_goto_keymap('[<C-Q>', 'cpfile')
end

---Setup keymaps for toggling common options.
---Inspired by vim-unimpaired plugin.
local function setup_opt_toggle_maps()
  keymap.set('n', 'yoh', function()
    vim.o.hlsearch = not vim.o.hlsearch
  end)
  keymap.set('n', 'yos', function()
    vim.o.spell = not vim.o.spell
  end)
end

local function setup_diagnostic_maps()
  vim.keymap.set('n', '<Leader>ww', vim.diagnostic.open_float)
  vim.keymap.set('n', ']w', vim.diagnostic.goto_next)
  vim.keymap.set('n', '[w', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next {
      severity = vim.diagnostic.severity.ERROR,
    }
  end)
  vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev {
      severity = vim.diagnostic.severity.ERROR,
    }
  end)
end

---Setup common user keymaps.
function M.setup_maps()
  -- ',' is another 'unofficial' leader key
  keymap.set('n', ',', '<Nop>')
  keymap.set('x', ',', '<Nop>')

  -- Destroy current buffer.
  keymap.set('n', '<Leader>q', function()
    api.nvim_buf_delete(0, { force = true })
  end)

  -- Replace all buffer content with content from "+ register.
  keymap.set('n', '<Leader>dp', ':%delete|0put+<CR>gg')

  -- Switch with alternate file
  keymap.set('n', '<BS>', '<C-^>')

  setup_goto_maps()
  setup_opt_toggle_maps()
  setup_diagnostic_maps()
end

return M
