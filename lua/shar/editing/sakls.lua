---Setup for sakls.nvim plugin.

local M = {}

local options = require 'shar.options'

function M.pack()
  require('packer').use(options.editing.sakls.sakls_nvim_path)
end

function M.set_up()
  local sakls = require 'sakls'
  sakls.init(options.editing.sakls.options)
end

return M
