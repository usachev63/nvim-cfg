--- Keyboard layout switching API.
--
-- An interface providing getting and setting system keyboard layout.
-- This interface is agnostic of the underlying backend library which
-- handles layout switching. Currently, only xkb-switch is supported.
--
-- This module should first be initialized with @{init} function;
-- after that @{get_layout} and @{set_layout} can be used to 
-- query/modify keyboard layout. In case of any error upon initialization,
-- the get/set functions are set to nil.
--
-- @module key.layout_api

local M = {}

local vim = vim
local fn = vim.fn
local libcall = fn.libcall
local filereadable = fn.filereadable

--- Get current system keyboard layout
-- @return string identifier of the layout
-- function M.get_layout()

--- Set current system keyboard layout
-- @param layout identifier of the layout
-- function M.set_layout(layout)

--- Initialize module with xkb-switch backend.
local function init_xkb_switch(options)
  local lib_path = options.xkb_switch_lib_path
  if type(lib_path) ~= 'string' or not filereadable(lib_path) then
    return
  end
  M.get_layout = function()
    return libcall(lib_path, 'Xkb_Switch_getXkbLayout', '')
  end
  M.set_layout = function(layout)
    return libcall(lib_path, 'Xkb_Switch_setXkbLayout', layout)
  end
end

--- Initialize layout_api module.
--
-- If the @{options} define a valid layout switching backend,
-- then @{get_layout} and @{set_layout} are initialized with
-- correct functions. Otherwise, those remain nil.
--
-- @param options options which specify
--   the backend library for keyboard layout switching
function M.init(options)
  if type(options) ~= 'table' or #options ~= 1 then
    return
  end
  local backend_id = options[1]
  if backend_id == 'xkb-switch' then
    return init_xkb_switch(options)
  end
end

return M
