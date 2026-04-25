local M = {}

local function setup_vim_opts()
  -- Enable full builtin filetype support
  vim.cmd 'filetype plugin indent on'

  -- Buffers are not required to be written during buffer switch
  vim.o.hidden = true
  -- Register "+ is essentially equal to register ""
  vim.o.clipboard = 'unnamedplus'
  -- :substitute command has [g] flag by default
  vim.o.gdefault = true

  -- Add all subdirectories of current working directory.
  -- For use in :find, gf, etc.
  vim.opt.path:append { '**' }

  -- zsh-like autocompletion in Ex mode
  vim.o.wildmenu = true
  vim.o.wildmode = 'full'

  -- Search options
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.infercase = true

  -- Default indent options
  vim.o.softtabstop = 4
  vim.o.shiftwidth = 4
  vim.o.expandtab = true

  vim.o.spelloptions = 'camel'

  vim.o.wrap = false

  vim.o.foldenable = false

  -- UI options
  vim.o.number = true
  vim.o.hlsearch = false
  vim.opt.listchars = {
    tab = '..',
    nbsp = '+',
  }
  vim.o.list = true
  vim.o.splitright = true
  vim.o.termguicolors = true
  vim.o.showmode = false
  vim.o.linebreak = true
  vim.o.showbreak = '↳'
  vim.o.breakindent = true
  vim.o.breakindentopt = 'sbr'
  vim.o.pumheight = 8
  vim.o.pumblend = 16
end

---Set <Space> as the leader key.
local function set_leader()
  vim.keymap.set('n', '<Space>', '<Nop>')
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  -- Prevent unexpected insert mode leave
  vim.keymap.set('i', '<C-Space>', '<Space>')
end

---@param goto_command string
local function goto_callback(goto_command)
  local command = {
    cmd = goto_command,
    mods = {
      emsg_silent = true,
    },
  }
  local count = vim.v.count
  if count and count > 0 then
    command.range = { count }
  end
  vim.api.nvim_cmd(command, {})
end

---@param lhs string
---@param goto_command string
local function set_goto_keymap(lhs, goto_command)
  vim.keymap.set('n', lhs, function()
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
  vim.keymap.set('n', 'yoh', function()
    vim.o.hlsearch = not vim.o.hlsearch
  end)
  vim.keymap.set('n', 'yos', function()
    vim.o.spell = not vim.o.spell
  end)
  vim.keymap.set('n', 'yow', function()
    vim.o.wrap = not vim.o.wrap
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
local function setup_maps()
  -- ',' is another 'unofficial' leader key
  vim.keymap.set('n', ',', '<Nop>')
  vim.keymap.set('x', ',', '<Nop>')

  -- Destroy current buffer.
  vim.keymap.set('n', '<Leader>q', function()
    vim.api.nvim_buf_delete(0, { force = true })
  end)

  -- Replace all buffer content with content from "+ register.
  vim.keymap.set('n', '<Leader>dp', ':%delete|0put+<CR>gg')

  -- Switch with alternate file
  vim.keymap.set('n', '<BS>', '<C-^>')

  setup_goto_maps()
  setup_opt_toggle_maps()
  setup_diagnostic_maps()
end

function M.setup_all()
  setup_vim_opts()
  set_leader()
  setup_maps()
end

return M
