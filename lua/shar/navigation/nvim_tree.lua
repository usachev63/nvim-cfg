---nvim-tree: a file explorer tree (instead of netrw)

local M = {}

local vim = vim
local keymap = vim.keymap

local nvim_tree
local api
local augroup

---Custom nvim-tree on_attach function.
---
---@param bufnr integer Buffer ID.
local function on_attach(bufnr)
  local function map(lhs, rhs, desc)
    keymap.set('n', lhs, rhs, {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    })
  end

  -- BEGIN_DEFAULT_ON_ATTACH
  map('<C-]>', api.tree.change_root_to_node, 'CD')
  map('<C-e>', api.node.open.replace_tree_buffer, 'Open: In Place')
  map('<C-k>', api.node.show_info_popup, 'Info')
  map('<C-r>', api.fs.rename_sub, 'Rename: Omit Filename')
  map('<C-t>', api.node.open.tab, 'Open: New Tab')
  map('<C-v>', api.node.open.vertical, 'Open: Vertical Split')
  map('<C-x>', api.node.open.horizontal, 'Open: Horizontal Split')
  map('<BS>', api.node.navigate.parent_close, 'Close Directory')
  map('<CR>', api.node.open.edit, 'Open')
  map('<Tab>', api.node.open.preview, 'Open Preview')
  map('>', api.node.navigate.sibling.next, 'Next Sibling')
  map('<', api.node.navigate.sibling.prev, 'Previous Sibling')
  map('.', api.node.run.cmd, 'Run Command')
  map('-', api.tree.change_root_to_parent, 'Up')
  map('a', api.fs.create, 'Create')
  map('bd', api.marks.bulk.delete, 'Delete Bookmarked')
  map('bmv', api.marks.bulk.move, 'Move Bookmarked')
  map('B', api.tree.toggle_no_buffer_filter, 'Toggle No Buffer')
  map('c', api.fs.copy.node, 'Copy')
  map('C', api.tree.toggle_git_clean_filter, 'Toggle Git Clean')
  map('[c', api.node.navigate.git.prev, 'Prev Git')
  map(']c', api.node.navigate.git.next, 'Next Git')
  map('d', api.fs.remove, 'Delete')
  map('D', api.fs.trash, 'Trash')
  map('E', api.tree.expand_all, 'Expand All')
  map('e', api.fs.rename_basename, 'Rename: Basename')
  map(']e', api.node.navigate.diagnostics.next, 'Next Diagnostic')
  map('[e', api.node.navigate.diagnostics.prev, 'Prev Diagnostic')
  -- map('F', api.live_filter.clear, 'Clean Filter')
  -- map('f', api.live_filter.start, 'Filter')
  map('g?', api.tree.toggle_help, 'Help')
  map('gy', api.fs.copy.absolute_path, 'Copy Absolute Path')
  map('H', api.tree.toggle_hidden_filter, 'Toggle Dotfiles')
  map('I', api.tree.toggle_gitignore_filter, 'Toggle Git Ignore')
  map('J', api.node.navigate.sibling.last, 'Last Sibling')
  map('K', api.node.navigate.sibling.first, 'First Sibling')
  map('m', api.marks.toggle, 'Toggle Bookmark')
  map('o', api.node.open.edit, 'Open')
  map('O', api.node.open.no_window_picker, 'Open: No Window Picker')
  map('p', api.fs.paste, 'Paste')
  map('P', api.node.navigate.parent, 'Parent Directory')
  map('q', api.tree.close, 'Close')
  map('r', api.fs.rename, 'Rename')
  map('R', api.tree.reload, 'Refresh')
  -- map('s', api.node.run.system, 'Run System')
  -- map('S', api.tree.search_node, 'Search')
  map('U', api.tree.toggle_custom_filter, 'Toggle Hidden')
  map('W', api.tree.collapse_all, 'Collapse')
  map('x', api.fs.cut, 'Cut')
  map('y', api.fs.copy.filename, 'Copy Name')
  map('Y', api.fs.copy.relative_path, 'Copy Relative Path')
  -- map('<2-LeftMouse>', api.node.open.edit, 'Open')
  -- map('<2-RightMouse>', api.tree.change_root_to_node, 'CD')
  -- END_DEFAULT_ON_ATTACH

  -- map('<CR>', api.node.open.replace_tree_buffer, 'Open: In Place')
end

function M.pack()
  require('packer').use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
end

local function custom_directory_hijack()
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.fn.isdirectory(bufname) ~= 1 then
    return
  end
  api.tree.open { path = bufname, current_window = true }
end

local function setup_custom_directory_hijack()
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
    augroup = augroup,
    callback = custom_directory_hijack,
  })
end

---Set up integration with nvim-tree.
function M.setup()
  nvim_tree = require 'nvim-tree'
  api = require 'nvim-tree.api'
  local nvim_tree_opts = {
    disable_netrw = true,
    on_attach = on_attach,
    actions = {
      change_dir = {
        -- enable = false,
      },
      open_file = {
        -- quit_on_open = true,
        -- eject = false,
        -- resize_window = false,
        -- window_picker = {
        --   enable = false,
        -- },
      },
    },
    hijack_directories = {
      -- enable = false,
    },
    git = {
      enable = false,
    },
  }

  nvim_tree.setup(nvim_tree_opts)
  -- setup_custom_directory_hijack()
  vim.keymap.set('n', '<Leader>nt', ':NvimTreeFindFile<CR>')
end

return M
