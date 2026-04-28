---@class Options
local M = {}

---@class Options
---
---Options for u63-nvim-cfg.
---
---@field cpp Options_Cpp
---@field tex Options_Tex
---@field langmapper Options_Langmapper

---@class Options_Cpp
---
---@field enabled boolean

---@class Options_Tex
---
---@field enabled boolean
---@field autowrite boolean

---@class Options_Langmapper
---
---@field enabled boolean

---Default u63-nvim-cfg options.
---
---@type Options
local default_options = {
  cpp = {
    enabled = false,
  },
  tex = {
    enabled = false,
    autowrite = false,
  },
  langmapper = {
    enabled = false,
  },
}

---Handle u63-nvim-cfg options provided by the user.
---
---@param opts any Raw, user-provided options for u63-nvim-cfg.
---@return Options M Processed and ready-to-use options table.
---Throws an error if provided options are ill-formed.
function M.init(opts)
  opts = opts or {}
  if type(opts) ~= 'table' then
    error('[u63.options] init called with non-table second argument!', 3)
  end
  opts = vim.tbl_deep_extend('force', default_options, opts)
  setmetatable(M, { __index = opts })
  return M
end

return M
