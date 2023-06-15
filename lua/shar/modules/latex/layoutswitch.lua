--[[
-- Syntax-sensitive keyboard layout switching.
--]]
local vim = vim
local fn = vim.fn
local api = vim.api
local g = vim.g
local keymap = vim.keymap

local xkb_switch_lib

local function get_xkb_layout()
  return fn.libcall(xkb_switch_lib, 'Xkb_Switch_getXkbLayout', '')
end
local function set_xkb_layout(layout)
  fn.libcall(xkb_switch_lib, 'Xkb_Switch_setXkbLayout', layout)
end

-- At the moment these are global for all buffers
local default_layout = 'us'
local saved_layouts = {}
local last_layout
local last_synid
local irrelevent_synids = {}

local function get_position()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  if api.nvim_get_mode()["mode"]:sub(1, 1) ~= "i" then
    col = col + 1
  end
  if col <= 0 then
    col = 1
  end
  return row, col
end

local function get_synstack()
  local row, col = get_position()
  return fn.synstack(row, col)
end

local function get_relevant_synid()
  local synstack = get_synstack()
  local cursor = #synstack
  while cursor > 0 and irrelevent_synids[synstack[cursor]] do
    cursor = cursor - 1
  end
  if cursor <= 0 then
    return 0
  end
  return synstack[cursor]
end

local function test_print()
  print("mode:", api.nvim_get_mode()["mode"])
  local row, col = get_position()
  print("position: (", row, ",", col, ")")
  local synstack = get_synstack()
  print("synstack:")
  print(unpack(synstack))
  for k, v in pairs(synstack) do
    synstack[k] = fn.synIDattr(v, 'name')
  end
  print(unpack(synstack))
  local synID = get_relevant_synid()
  print("relevant synID:", fn.synIDattr(synID, 'name'), "(", synID, ")")
  print("layout: ", saved_layouts[synID])
end
keymap.set({ 'i', 'n', 'v' }, '<F10>', test_print)

local function save()
  last_layout = get_xkb_layout()
  if not last_synid then
    return
  end
  saved_layouts[last_synid] = last_layout
end

local function enter_new()
  local synid = get_relevant_synid()
  if synid == last_synid then
    return
  end
  local new_layout = saved_layouts[synid]
  if not new_layout then
    saved_layouts[synid] = default_layout
    new_layout = default_layout
  end
  set_xkb_layout(new_layout)
  last_synid = synid
  last_layout = new_layout
end

local function update()
  save()
  enter_new()
end

Shar_LatexXkb_on_insert_mode_enter = function()
  last_synid = nil
  enter_new()
end

local augroup = api.nvim_create_augroup("LatexXkb", {})

-- Initialize LatexXkb module upon entering a tex file.
local function init()
  xkb_switch_lib = vim.g.XkbSwitchLib
  if not fn.filereadable(xkb_switch_lib) then
    error('Failed to find XkbSwitch library. \
           Please make sure it is installed in the system.')
  end

  local current_buffer = api.nvim_get_current_buf()

  api.nvim_set_option_value('keymap', 'russian-jcukenwin', { scope = 'local' })

  api.nvim_create_autocmd("CursorMovedI", {
    buffer = current_buffer,
    callback = update,
    group = augroup,
  })

  api.nvim_create_autocmd("InsertLeavePre", {
    buffer = current_buffer,
    callback = save,
    group = augroup,
  })

  saved_layouts = {
    [0] = 'ru', -- empty syntax ID
    [fn.hlID('texAuthorArg')] = 'ru',
    [fn.hlID('texTitleArg')] = 'ru',
    [fn.hlID('texStyleBold')] = 'ru',
    [fn.hlID('texStyleItal')] = 'ru',
    [fn.hlID('texStyleArgConc')] = 'ru',
    [fn.hlID('texPartArgTitle')] = 'ru',
    [fn.hlID('texNewthmArgPrinted')] = 'ru',
    [fn.hlID('texTheoremEnvOpt')] = 'ru',
    [fn.hlID('texEnvOpt')] = 'ru',
    [fn.hlID('texMathTextConcArg')] = 'ru',
    [fn.hlID('texFootnoteArg')] = 'ru',
  }

  irrelevent_synids = {
    [fn.hlID('texDelim')] = true,
    [fn.hlID('texMathDelimZoneTI')] = true,
    [fn.hlID('texRefEqConcealedDelim')] = true,
    [fn.hlID('texGroup')] = true,
  }
end

api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.tex",
  callback = init,
  group = augroup,
})

g.XkbSwitchPostIEnterAuto = { {
  {
    ft = 'tex',
    cmd = 'execute("lua Shar_LatexXkb_on_insert_mode_enter()")'
  },
  1
} }
