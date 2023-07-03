--- UI related settings: color themes, status line, tab line, etc.

local M = {}

local vim = vim
local o = vim.o
local opt = vim.opt
local g = vim.g

local packer = require 'packer'
local lualine = require 'lualine'

--- Set some UI-related vim options.
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

--- Set up Gruvbox color scheme.
local function set_theme()
  packer.use 'morhetz/gruvbox'
  g.gruvbox_italic = 1
  vim.cmd 'colorscheme gruvbox'
end

local function setup_lualine()
  packer.use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  lualine.setup {
    options = {
      theme = 'gruvbox',
    },
    sections = {
      lualine_b = { 'diagnostics' },
      lualine_x = { 'encoding', 'filetype' },
      lualine_y = {},
    },
    inactive_sections = {
      lualine_x = {},
    },
  }
end

local function setup_tabby()
  packer.use 'nanozuki/tabby.nvim'
  local theme = {
    fill = 'TabLineFill',
    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
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
  end)
end

function M.init()
  set_options()
  set_theme()
  setup_lualine()
  setup_tabby()
end

return M
