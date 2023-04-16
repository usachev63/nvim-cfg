local api = vim.api
local fn = vim.fn
local g = vim.g

local xkbSwitchLib

local getXkbLayout = function()
  return fn.libcall(xkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
end
local setXkbLayout = function(layout)
  fn.libcall(xkbSwitchLib, 'Xkb_Switch_setXkbLayout', layout)
end

-- At the moment these are global for all buffers
local defaultLayout = 'us'
local savedLayouts = {}
local lastLayout
local lastSynID = nil
local irrelevantSynIDs = {}

local getPosition = function()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  if api.nvim_get_mode()["mode"]:sub(1, 1) ~= "i" then
    col = col + 1
  end
  if col <= 0 then
    col = 1
  end
  return row, col
end

local getSynStack = function()
  local row, col = getPosition()
  return fn.synstack(row, col)
end

local getRelevantSynID = function()
  local synStack = getSynStack()
  local cursor = #synStack
  while cursor > 0 and irrelevantSynIDs[synStack[cursor]] ~= nil do
    cursor = cursor - 1
  end
  if cursor <= 0 then
    return 0
  end
  return synStack[cursor]
end

TestLatexXkb = function()
  print("mode:", api.nvim_get_mode()["mode"])
  local row, col = getPosition()
  print("position: (", row, ",", col, ")")
  local synstack = getSynStack()
  print("synstack:")
  print(unpack(synstack))
  for k, v in pairs(synstack) do
    synstack[k] = fn.synIDattr(v, 'name')
  end
  print(unpack(synstack))
  local synID = getRelevantSynID()
  print("relevant synID:", fn.synIDattr(synID, 'name'), "(", synID, ")")
  print("layout: ", savedLayouts[synID])
end
api.nvim_set_keymap("i", "<F10>", "<cmd>lua TestLatexXkb()<cr>", {})
api.nvim_set_keymap("n", "<F10>", "<cmd>lua TestLatexXkb()<cr>", {})
api.nvim_set_keymap("v", "<F10>", "<cmd>lua TestLatexXkb()<cr>", {})

local save = function()
  lastLayout = getXkbLayout()
  savedLayouts[lastSynID] = lastLayout
end

local enterNew = function()
  local synID = getRelevantSynID()
  if synID == lastSynID then
    return
  end
  local newLayout = savedLayouts[synID]
  if newLayout == nil then
    savedLayouts[synID] = defaultLayout
    newLayout = defaultLayout
  end
  setXkbLayout(newLayout)
  lastSynID = synID
  lastLayout = newLayout
end

local update = function()
  save()
  enterNew()
end

LatexXkb_onInsertModeEnter = function()
  lastSynID = nil
  enterNew()
end

local latexXkbAuGroup = api.nvim_create_augroup("LatexXkb", {})

-- Initialize LatexXkb module upon entering a tex file.
-- Called on "FileType tex" event.
local init = function()
  xkbSwitchLib = g.XkbSwitchLib
  if not fn.filereadable(xkbSwitchLib) then
    error('Failed to find XkbSwitch library. \
           Please make sure it is installed in the system.')
  end

  local currentBuffer = api.nvim_get_current_buf()
  api.nvim_create_autocmd("CursorMovedI", {
    buffer = currentBuffer,
    callback = update,
    group = latexXkbAuGroup,
  })

  api.nvim_create_autocmd("InsertLeavePre", {
    buffer = currentBuffer,
    callback = save,
    group = latexXkbAuGroup,
  })

  savedLayouts = {
        [0] = 'ru',   -- empty syntax ID
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

  irrelevantSynIDs = {
        [fn.hlID('texDelim')] = true,
        [fn.hlID('texMathDelimZoneTI')] = true,
        [fn.hlID('texRefEqConcealedDelim')] = true,
  }
end

api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = init,
  group = latexXkbAuGroup,
})

g.XkbSwitchPostIEnterAuto = { {
  {
    ft = 'tex',
    cmd = 'execute("lua LatexXkb_onInsertModeEnter()")'
  },
  1
} }
