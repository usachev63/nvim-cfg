---UI related settings: color themes, status line, tab line, etc.

local M = {}

local vim = vim
local o = vim.o
local opt = vim.opt
local g = vim.g
local treesitter = require 'nvim-treesitter'

---Set some UI-related vim options.
local function set_options()
  o.number = true
  o.hlsearch = false
  opt.listchars = {
    tab = '..',
    nbsp = '+',
  }
  o.list = true
  o.splitright = true
  o.termguicolors = true
  o.showmode = false
  o.linebreak = true
  o.showbreak = '↳'
  o.breakindent = true
  o.breakindentopt = 'sbr'
end

---Set up my favourite color scheme.
local function set_theme()
  g.gruvbox_italic = 1
  -- vim.cmd 'colorscheme gruvbox'
  -- vim.cmd 'colorscheme onedark'
  require('base16-colorscheme').setup {
    base00 = '#101218',
    base01 = '#1f222d',
    base02 = '#252936',
    base03 = '#7780a1',
    base04 = '#C0C5CE',
    base05 = '#d1d4e0',
    base06 = '#C9CCDB',
    base07 = '#ffffff',
    base08 = '#ee829f',
    base09 = '#f99170',
    base0A = '#ffefcc',
    base0B = '#a5ffe1',
    base0C = '#97e0ff',
    base0D = '#97bbf7',
    base0E = '#c0b7f9',
    base0F = '#fcc09e',
  }
end

local function get_treesitter_statusline()
  return treesitter.statusline() or ''
end

---Set up integration with lualine.nvim status line plugin.
local function setup_lualine()
  local lualine = require 'lualine'
  lualine.setup {
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_a = { 'branch' },
      lualine_b = { 'filename', 'location' },
      lualine_c = { get_treesitter_statusline },
      lualine_x = { 'encoding', 'filetype' },
      lualine_y = { 'diagnostics' },
      lualine_z = { 'mode' },
    },
    inactive_sections = {
      lualine_c = { 'branch', 'filename', 'location' },
      lualine_x = {},
    },
  }
end

---Set up integration with tabby.nvim tab line plugin.
local function setup_tabby()
  local theme = {
    fill = 'TabLineFill',
    -- Also you can do this:
    -- fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
    head = 'TabLine',
    current_tab = 'TabLineSel',
    tab = 'TabLine',
    win = 'TabLine',
    tail = 'TabLine',
  }
  require('tabby.tabline').set(function(line)
    return {
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep(' ', hl, theme.fill),
          tab.number(),
          tab.name(),
          hl = hl,
          margin = ' ',
        }
      end),
    }
  end, {
    tab_name = {
      name_fallback = function(tabid)
        local tabnum = vim.api.nvim_tabpage_get_number(tabid)
        local tabcwd = vim.fn.getcwd(-1, tabnum)
        local tabparent
        for parent in vim.fs.parents(tabcwd) do
          tabparent = vim.fs.basename(parent)
          break
        end
        local tabname = vim.fs.basename(tabcwd)
        if tabparent then
          tabname = tabparent .. '/' .. tabname
        end
        return tabname
      end,
    },
  })
end

function M.pack()
  local packer = require 'packer'
  packer.use 'ellisonleao/gruvbox.nvim'
  packer.use 'joshdick/onedark.vim'
  packer.use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  packer.use 'nanozuki/tabby.nvim'
  packer.use 'rcarriga/nvim-notify'
  packer.use 'stevearc/dressing.nvim'
  packer.use 'RRethy/base16-nvim'
end

---Initialize UI-related setup.
function M.init()
  set_options()
  set_theme()
  setup_lualine()
  setup_tabby()
end

return M
