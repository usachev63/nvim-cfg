---Efficient and cozy workflow for working with TeX documents in Neovim.

local M = {}

local vim = vim
local api = vim.api
local g = vim.g

local options = require 'usachev63.options'

local tex_keymap = require 'usachev63.toolkit.tex.keymap'
local tex_sakls = require 'usachev63.toolkit.tex.sakls'

---Initialize related Vim global variables.
local function init_globals()
  g.vimtex_view_method = 'zathura'

  g.vimtex_compiler_method = 'latexmk'
  g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = true,
    continuous = true,
    executable = 'latexmk',
    hooks = {},
    options = {
      '-verbose',
      '-file-line-error',
      '-synctex=1',
      '-interaction=nonstopmode',
      '-shell-escape',
    },
  }

  g.vimtex_subfile_start_local = true
  g.vimtex_quickfix_mode = false
  g.vimtex_indent_on_ampersands = false

  g.tex_conceal = 'abdgm'

  g.vimtex_env_toggle_math_map = {
    ['$'] = 'align*',
    ['align*'] = '$',
    ['align'] = '$',
    ['$$'] = 'align*',
    ['\\['] = 'align*',
  }

  g.vimtex_mappings_enabled = false
end

---Initialize g:usachev63_latex_template vim global variable
---with the path to TeX template file. The contents of this template file
---can then be inserted with "template" snippet.
---
---@param template_path string
local function init_template(template_path)
  g.usachev63_latex_template = ''
  if type(template_path) ~= 'string' then
    return
  end
  local template_file = io.open(template_path, 'r')
  if not template_file then
    return
  end
  g.usachev63_latex_template = template_file:read 'a'
end

---Callback, invoked on opening a TeX document.
---
---@param augroup any TeX autocommand group.
local function on_open_file(augroup)
  api.nvim_win_set_option(0, 'conceallevel', 0)

  -- autowrite
  api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
    buffer = 0,
    command = 'silent update',
    group = augroup,
  })
end

---Initialize common TeX-related autocommands.
local function init_autocmds()
  local augroup = api.nvim_create_augroup('Latex', {})

  api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.tex',
    callback = function()
      on_open_file(augroup)
    end,
    group = augroup,
  })
end

function M.pack()
  local packer = require 'packer'
  packer.use 'lervag/vimtex'
end

---Set up TeX support.
function M.setup()
  local opts = options.toolkit.tex

  init_globals()
  init_template(opts.template_file)
  init_autocmds()

  -- if opts.sakls.enabled then
  --   tex_sakls.set_up()
  -- end
  tex_keymap.init()
end

return M
