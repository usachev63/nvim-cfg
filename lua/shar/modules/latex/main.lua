--[[
-- LaTeX module: efficient and cozy workflow for
-- working with LaTeX documents.
--]]
local vim = vim

local latex = {}

local function init_globals()
  local g = vim.g

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
end

local function init_autocmds()
  local api = vim.api

  local augroup = api.nvim_create_augroup('Latex', {})

  local function on_new_file()
    vim.cmd '0:read ~/Templates/template.tex'
    local line_count = api.nvim_buf_line_count(0)
    api.nvim_win_set_cursor(0, { line_count, 0 })
    vim.cmd 'write'
  end

  local function on_open_file()
    api.nvim_win_set_option(0, 'conceallevel', 0)

    -- autowrite
    api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
      buffer = 0,
      command = 'silent update',
      group = augroup,
    })
  end

  api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.tex',
    callback = function()
      on_new_file()
      on_open_file()
    end,
    group = augroup,
  })
  api.nvim_create_autocmd('BufRead', {
    pattern = '*.tex',
    callback = on_open_file,
    group = augroup,
  })
end

function latex.init(options)
  local packer = require 'packer'
  packer.use { 'lervag/vimtex' }

  init_globals()
  init_autocmds()

  require 'shar.modules.latex.layoutswitch'
  local keymap = require 'shar.modules.latex.keymap'
  keymap.init(options)
end

return latex
