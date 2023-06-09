--[[
-- Utilities for ACM-style programming in C++.
--]]
local vim = vim
local keymap = vim.keymap

local load_template = function()
  local template_file = assert(io.open("/home/danila/ACM/lib/Template.cpp", "r"))
  local lines = {}
  for line in template_file:lines() do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local set_build_keymaps = function()
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

local augroup = vim.api.nvim_create_augroup("AcmCpp", {})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.acm",
  callback = function()
    load_template()
    local line_count = vim.api.nvim_buf_line_count(0)
    vim.api.nvim_win_set_cursor(0, { line_count, 0 })
  end,
  group = augroup
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.acm",
  callback = set_build_keymaps,
  group = augroup,
})
