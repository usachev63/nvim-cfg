--[[
-- vim-fugitive: Git integration
--]]
local vim = vim
local packer = require 'packer'
packer.use 'tpope/vim-fugitive'

-- Merge conflict resolution keymaps
vim.api.nvim_set_keymap('n', '<Leader>df', ':Gvdiffsplit!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dh', ':diffget //2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':diffget //3<CR>', { noremap = true })

local augroup = vim.api.nvim_create_augroup('Fugitive', {})

-- Disable line numbers in fugitive window
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function()
    vim.api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
  end,
  group = augroup,
})

-- Abbreviate :w to :Gwrite in tracked files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  callback = function()
    if not vim.api.nvim_buf_is_valid(0) or vim.o.buftype ~= '' then
      return
    end
    local git_dir = vim.fn.FugitiveGitDir()
    if not git_dir or git_dir == '' then
      return
    end
    local file_path = vim.api.nvim_buf_get_name(0)
    local ls_files = vim.fn.FugitiveExecute {
      "ls-files", "--", file_path
    }
    if #ls_files.stdout <= 1 then
      return
    end
    vim.cmd {
      cmd = 'cnoreabbrev',
      args = {
        '<expr>', '<buffer>',
        'w',
        'getcmdtype() == ":" && getcmdline() == "w" ? "Gwrite" : "w"'
      },
    }
  end,
  group = augroup,
})
