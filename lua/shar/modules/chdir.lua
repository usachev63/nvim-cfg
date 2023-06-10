--[[
-- Useful commands for changing current working directory.
--]]
local vim = vim
local api = vim.api
local o = vim.o
local b = vim.b
local keymap = vim.keymap
local fn = vim.fn

local function get_dir_of_current_buffer()
  if o.filetype == 'netrw' and b.netrw_curdir then
    return b.netrw_curdir .. "/"
  end
  if o.buftype == 'terminal' and b.term_title then
    return b.term_title:match(":(.*)") .. "/"
  end
  return api.nvim_buf_get_name(0):match("(.*/)")
end

keymap.set('c', '%%', function()
  if fn.getcmdtype() == ':' then
    return get_dir_of_current_buffer()
  end
  return '%%'
end, {
  expr = true,
  replace_keycodes = true,
})

local function tab_change_to_current_buffer_dir()
  local dir = get_dir_of_current_buffer()
  vim.cmd('tchdir ' .. dir)
  print("Changed tab directory to '" .. dir .. "'")
end

keymap.set('n', '<Leader>tc', tab_change_to_current_buffer_dir)
