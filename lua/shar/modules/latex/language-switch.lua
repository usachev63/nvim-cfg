local xkb_switch_lib

local function get_xkb_layout()
  return vim.fn.libcall(xkb_switch_lib, 'Xkb_Switch_getXkbLayout', '')
end
local function set_xkb_layout(layout)
  vim.fn.libcall(xkb_switch_lib, 'Xkb_Switch_setXkbLayout', layout)
end

-- At the moment these are global for all buffers
local default_layout = 'us'
local saved_layouts = {}
local last_layout
local last_synid = nil
local irrelevent_synids = {}

local function get_position()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  if vim.api.nvim_get_mode()["mode"]:sub(1, 1) ~= "i" then
    col = col + 1
  end
  if col <= 0 then
    col = 1
  end
  return row, col
end

local function get_synstack()
  local row, col = get_position()
  return vim.fn.synstack(row, col)
end

local function get_relevant_synid()
  local synstack = get_synstack()
  local cursor = #synstack
  while cursor > 0 and irrelevent_synids[synstack[cursor]] ~= nil do
    cursor = cursor - 1
  end
  if cursor <= 0 then
    return 0
  end
  return synstack[cursor]
end

LatexXkb_test = function()
  print("mode:", vim.api.nvim_get_mode()["mode"])
  local row, col = get_position()
  print("position: (", row, ",", col, ")")
  local synstack = get_synstack()
  print("synstack:")
  print(unpack(synstack))
  for k, v in pairs(synstack) do
    synstack[k] = vim.fn.synIDattr(v, 'name')
  end
  print(unpack(synstack))
  local synID = get_relevant_synid()
  print("relevant synID:", vim.fn.synIDattr(synID, 'name'), "(", synID, ")")
  print("layout: ", saved_layouts[synID])
end
vim.api.nvim_set_keymap("i", "<F10>", "<cmd>lua LatexXkb_test()<cr>", {})
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua LatexXkb_test()<cr>", {})
vim.api.nvim_set_keymap("v", "<F10>", "<cmd>lua LatexXkb_test()<cr>", {})

local function save()
  last_layout = get_xkb_layout()
  if last_synid == nil then
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
  if new_layout == nil then
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

LatexXkb_on_insert_mode_enter = function()
  last_synid = nil
  enter_new()
end

local augroup = vim.api.nvim_create_augroup("LatexXkb", {})

-- Initialize LatexXkb module upon entering a tex file.
-- Called on "FileType tex" event.
local function init()
  xkb_switch_lib = vim.g.XkbSwitchLib
  if not vim.fn.filereadable(xkb_switch_lib) then
    error('Failed to find XkbSwitch library. \
           Please make sure it is installed in the system.')
  end

  local current_buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("CursorMovedI", {
    buffer = current_buffer,
    callback = update,
    group = augroup,
  })

  vim.api.nvim_create_autocmd("InsertLeavePre", {
    buffer = current_buffer,
    callback = save,
    group = augroup,
  })

  saved_layouts = {
        [0] = 'ru', -- empty syntax ID
        [vim.fn.hlID('texAuthorArg')] = 'ru',
        [vim.fn.hlID('texTitleArg')] = 'ru',
        [vim.fn.hlID('texStyleBold')] = 'ru',
        [vim.fn.hlID('texStyleItal')] = 'ru',
        [vim.fn.hlID('texStyleArgConc')] = 'ru',
        [vim.fn.hlID('texPartArgTitle')] = 'ru',
        [vim.fn.hlID('texNewthmArgPrinted')] = 'ru',
        [vim.fn.hlID('texTheoremEnvOpt')] = 'ru',
        [vim.fn.hlID('texEnvOpt')] = 'ru',
        [vim.fn.hlID('texMathTextConcArg')] = 'ru',
        [vim.fn.hlID('texFootnoteArg')] = 'ru',
  }

  irrelevent_synids = {
        [vim.fn.hlID('texDelim')] = true,
        [vim.fn.hlID('texMathDelimZoneTI')] = true,
        [vim.fn.hlID('texRefEqConcealedDelim')] = true,
  }
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = init,
  group = augroup,
})

vim.g.XkbSwitchPostIEnterAuto = { {
  {
    ft = 'tex',
    cmd = 'execute("lua LatexXkb_on_insert_mode_enter()")'
  },
  1
} }
