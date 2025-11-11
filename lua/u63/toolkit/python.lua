---Python development settings.

local M = {}

local packer = require 'packer'
local options = require 'u63.options'

function M.pack()
  if options.toolkit.python.venv_selector then
    packer.use 'linux-cultist/venv-selector.nvim'
  end
end

local function setup_venv_selector()
  require('venv-selector').setup {
    anaconda_envs_path = '~/.anaconda3/envs',
  }
  vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>')
end

function M.setup()
  if options.toolkit.python.venv_selector then
    setup_venv_selector()
  end
end

return M
