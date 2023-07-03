local libcall = vim.fn.libcall

local xkb_switch_lib = '/usr/local/lib/libxkbswitch.so'
local get_layout_function = 'Xkb_Switch_getXkbLayout'
local set_layout_function = 'Xkb_Switch_setXkbLayout'

local M = {}

function M.get_layout()
  return libcall(xkb_switch_lib, get_layout_function, '')
end

function M.set_layout(layout)
  return libcall(xkb_switch_lib, set_layout_function, layout)
end

return M
