---@class LayoutApi
---
---Keyboard layout switching API: an interface providing
---getting and setting system keyboard layout.
---
---This interface is agnostic of the underlying backend library, which actually
---handles layout switching. Currently, only xkb-switch is supported.
---
---This module should first be initialized with init function;
---after that get_layout and set_layout can be used to query/modify
---system keyboard layout. In case of any error upon initialization,
---the get_layout and set_layout functions are set to nil.
---
---@field get_layout (fun(): string)? Get current system keyboard layout.
---@field set_layout (fun(string))? Set current system keyboard layout.

---@type LayoutApi
local M = {}

local vim = vim
local fn = vim.fn
local libcall = fn.libcall
local filereadable = fn.filereadable

---Initialize Layout API with xkb-switch backend.
---
---@param lib XkbSwitchLayoutLib Configuration of xkb-switch library.
local function init_xkb_switch(lib)
  local lib_path = lib.xkb_switch_lib_path
  if not filereadable(lib_path) then
    return
  end
  M.get_layout = function()
    return libcall(lib_path, 'Xkb_Switch_getXkbLayout', '')
  end
  M.set_layout = function(layout)
    return libcall(lib_path, 'Xkb_Switch_setXkbLayout', layout)
  end
end

---Initialize Layout API.
---
---If the lib parameter defines a valid layout switching backend,
---then M.get_layout and M.set_layout are initialized with
---correct implementations. Otherwise, they will remain nil.
---
---@param lib LayoutLib? The backend layout switching library.
function M.init(lib)
  if not lib then
    return
  end
  local backend_id = lib[1]
  if backend_id == 'xkb-switch' then
    return init_xkb_switch(lib)
  end
end

return M
