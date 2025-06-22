---Syntax-Aware Keyboard Layout Switching (sakls.nvim) for VimTeX workflow.

local M = {}

local m_options = require 'usachev63.options'

local function get_schema(schema_option)
  if type(schema_option) == 'string' then
    return require('sakls.schemas.tex.' .. schema_option)
  end
  return schema_option
end

function M.set_up()
  local opts = m_options.toolkit.tex.sakls
  local sakls = require 'sakls'
  sakls.attach_on_filetype(
    'tex',
    require 'sakls.syntax.vimsyn',
    get_schema(opts.schema)
  )
end

return M
