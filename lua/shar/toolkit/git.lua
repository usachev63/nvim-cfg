---Integration with Git version control system.

local M = {}

local vim = vim
local keymap = vim.keymap
local api = vim.api
local fn = vim.fn
local o = vim.o

---Set up useful autocommands.
local function setup_autocmds()
  local augroup = api.nvim_create_augroup('Fugitive', {})

  -- Disable line numbers in fugitive window
  api.nvim_create_autocmd('FileType', {
    pattern = 'fugitive',
    callback = function()
      api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
    end,
    group = augroup,
  })

  -- Abbreviate :w to :Gwrite in tracked files
  api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
    callback = function()
      if not api.nvim_buf_is_valid(0) or o.buftype ~= '' then
        return
      end
      local git_dir = fn.FugitiveGitDir()
      if not git_dir or git_dir == '' then
        return
      end
      local file_path = api.nvim_buf_get_name(0)
      local ls_files = fn.FugitiveExecute {
        'ls-files',
        '--',
        file_path,
      }
      if #ls_files.stdout <= 1 then
        return
      end
      vim.cmd {
        cmd = 'cnoreabbrev',
        args = {
          '<expr>',
          '<buffer>',
          'w',
          'getcmdtype() == ":" && getcmdline() == "w" ? "Gwrite" : "w"',
        },
      }
    end,
    group = augroup,
  })
end

function M.pack()
  local packer = require 'packer'
  packer.use 'tpope/vim-fugitive'
  packer.use 'sindrets/diffview.nvim'
end

---Set up integration with Git.
function M.setup()
  -- Merge conflict resolution keymaps
  keymap.set('n', '<Leader>df', ':Gvdiffsplit!<CR>')
  keymap.set('n', '<Leader>dh', ':diffget //2<CR>')
  keymap.set('n', '<Leader>dl', ':diffget //3<CR>')

  setup_autocmds()
end

return M
