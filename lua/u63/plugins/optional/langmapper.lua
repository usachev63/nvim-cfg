---langmapper.nvim plugin: automatic translation of keymaps
---to different keyboard layouts.

local layout_api = require("u63.lib.layout_api")

---Escape a sequence in 'langmap' option.
local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en_lower = [[`qwertyuiop[]asdfghjkl'zxcvbnm]]
local ru_lower =
[[ёйцукенгшщзхъфывапролдэячсмить]]
local en_upper = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_upper =
[[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

---Set up 'langmap' vim option, which allows translating
---russian keycodes into english in Normal mode.
local function setup_langmap()
  vim.opt.langmap = vim.fn.join({
    escape(ru_lower) .. ';' .. escape(en_lower),
    escape(ru_upper) .. ';' .. escape(en_upper),
  }, ',')
end

local en_full =
[[`qwertyuiop[]asdfghjkl;'zxcvbnm,./~@$^&QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?]]
local ru_full =
[[ёйцукенгшщзхъфывапролджэячсмитьбю.Ё";:?ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,]]

---Set up langmapper.nvim itself.
local function setup_langmapper()
  local langmapper = require("langmapper")
  langmapper.setup {
    map_all_ctrl = false,
    default_layout = en_full,
    disable_hack_modes = { 'i', 't' },
    layouts = {
      ru = {
        id = 'ru',
        layout = ru_full,
      },
    },
    os = {
      Linux = {
        get_current_layout_id = layout_api.get_layout,
      },
    },
  }
end

---Set some langmapper-related keymaps.
local function setup_extra_keymaps()
  -- Handle this manually because
  -- adding it in langmapper layout
  -- will cause huge slow down
  -- on every key press.
  vim.keymap.set({ 'n', 'v', 'o' }, '№', '#')

  vim.keymap.set({ 'n', 'v', 'o' }, 'ж', ';')

  -- Switch to 'us' layout upon entering command-line mode
  if layout_api.set_layout then
    vim.keymap.set('n', ':', function()
      layout_api.set_layout 'us'
      return ':'
    end, { expr = true })
  end
end

return {
  "usachev63/langmapper.nvim",
  config = function()
    setup_langmap()
    setup_langmapper()
    setup_extra_keymaps()
  end,
  do_automapping = function()
    require("langmapper").automapping({
      global = true,
      buffer = false,
    })
  end
}
