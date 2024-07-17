--- Support for nnn file manager in Neovim

local M = {}

local augroup = vim.api.nvim_create_augroup('shar.navigation.nnn', {})

local function setup_keymaps()
  vim.keymap.set('n', '<leader>n', '<cmd>NnnPicker<CR>')
  vim.api.nvim_create_autocmd('TermEnter', {
    group = augroup,
    callback = function()
      if vim.o.filetype == 'nnn' then
        vim.keymap.set(
          { 'n', 't' },
          '<C-c>',
          '<cmd>NnnPicker<CR>',
          { buffer = true }
        )
      end
    end,
  })
end

function M.pack()
  local packer = require 'packer'
  packer.use 'luukvbaal/nnn.nvim'
end

local function open(files)
  for _, file in ipairs(files) do
    vim.cmd('edit ' .. file)
  end
end

function M.setup()
  local nnn = require 'nnn'
  setup_keymaps()
  nnn.setup {
    replace_netrw = 'picker',
    mappings = {
      { 'l', open },
      { 'e', open },
    },
  }
end

return M
