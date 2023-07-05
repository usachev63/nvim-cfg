---Utilities for ACM-style programming in C++.

local M = {}

local vim = vim
local keymap = vim.keymap

local options = require 'shar.options'

local template_path

---Load C++ template into current buffer.
local function load_template()
  local template_file = assert(io.open(template_path, "r"))
  local lines = {}
  for line in template_file:lines() do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

---Set up build & run keymaps.
local function set_build_keymaps()
  -- Build & Run mapping
  keymap.set('n', '<F10>',
    ":write | terminal acm % && ./%:r < in<CR>", {
      buffer = true
    })
  -- Only Run mapping
  keymap.set('n', '<F9>',
    ":write | terminal ./%:r < in<CR>", {
      buffer = true
    })
end

---Set up support for ACM C++.
function M.setup()
  local opts = options.toolkit.acmcpp
  if type(opts.template_path) == 'string' then
    template_path = opts.template_path
  end

  local augroup = vim.api.nvim_create_augroup("AcmCpp", {})
  if template_path then
    vim.api.nvim_create_autocmd("BufNewFile", {
      pattern = "*.acm",
      callback = function()
        load_template()
        local line_count = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(0, { line_count, 0 })
      end,
      group = augroup
    })
  end
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.acm",
    callback = set_build_keymaps,
    group = augroup,
  })
end

return M
