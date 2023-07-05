--- Options of my Neovim config.
-- @module options

local M = {}

local default_options = {
  localvimrc = false,
  key = {
    enable_langmapper = false,
    layout_api = nil
  },
  protocol = {
    treesitter = nil,
    lsp = nil,
    formatter = nil
  },
  editing = {
    enable_autopairs = true,
    cmp = nil
  },
  navigation = {
    nvim_tree = {
      enabled = false
    }
  },
  toolkit = {
    tex = {
      enabled = false,
      template_file = nil,
      inkscape_figures = nil
    }
  }
}

function M.init(opts)
  opts = opts or {}
  if type(opts) ~= 'table' then
    error('[shar.options] init called with non-table second argument!', 3)
  end
  opts = vim.tbl_deep_extend('force', default_options, opts)
  setmetatable(M, { __index = opts })
  return M
end

return M
