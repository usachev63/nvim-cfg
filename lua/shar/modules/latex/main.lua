local vim = vim

local packer = require 'packer'
packer.use { 'lervag/vimtex', ft = 'tex' }
packer.use { 'lyokha/vim-xkbswitch', ft = 'tex' }

vim.g.vimtex_view_method = 'zathura'

vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
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

vim.g.vimtex_subfile_start_local = true
vim.g.vimtex_quickfix_mode = false
vim.g.vimtex_indent_on_ampersands = false

vim.g.tex_conceal = 'abdgm'

vim.g.vimtex_env_toggle_math_map = {
      ['$'] = 'align*',
      ['align*'] = '$',
      ['align'] = '$',
      ['$$'] = 'align*',
      ['\\['] = 'align*',
}

--
-- Buffer-local keymaps
--

vim.api.nvim_exec2([[
" Wraps a TeX command around a visual selection
function Latex_WrapCommand(command)
    call vimtex#cmd#create(a:command, 1)
endfunction

" Wraps \underbrace around a visual selection
function Latex_WrapUnderbrace()
    call Latex_WrapCommand('underbrace')
    normal /{<CR>%a_{}
    startinsert
endfunction


function Latex_Wrap(open, close)
    execute('normal gv"vy')
    execute("normal gvc\<C-r>\<C-r>=a:open\<CR>\<C-r>\<C-r>v\<C-r>\<C-r>=a:close\<CR>")
endfunction

" Wraps a delimiter around a visual selection
function Latex_WrapDelimiter(del_open, del_close)
    call Latex_Wrap('\left' . a:del_open, ' \right' . a:del_close)
endfunction
]], {})

local init_keymaps = function()
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>bf',
    ':call Latex_WrapCommand("textbf")<CR>', {
      noremap = true,
      desc = 'Wrap a \\textbf command around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>it',
    ':call Latex_WrapCommand("textit")<CR>', {
      noremap = true,
      desc = 'Wrap a \\textit command around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>u',
    ':call Latex_WrapUnderbrace()<CR>', {
      noremap = true,
      desc = 'Wrap an \\underbrace around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sb',
    ":call Latex_WrapDelimiter('(', ')')<CR>", {
      noremap = true,
      desc = 'Wrap a \\left( .. \\right) delimiter around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sB',
    ":call Latex_WrapDelimiter('{', '}')<CR>", {
      noremap = true,
      desc = 'Wrap a \\left} .. \\right} delimiter around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sa',
    ":call Latex_WrapDelimiter('<Bar>', '<Bar>')<CR>", {
      noremap = true,
      desc = 'Wrap a \\left| .. \\right| delimiter around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sq',
    ":call Latex_WrapDelimiter('[', ']')<CR>", {
      noremap = true,
      desc = 'Wrap a \\left[ .. \\right] delimiter around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sn',
    ":call Latex_WrapDelimiter('\\<Bar>', '\\<Bar>')<CR>", {
      noremap = true,
      desc = 'Wrap a \\left\\| .. \\right\\| delimiter around a visual selection',
    })
  vim.api.nvim_buf_set_keymap(0, 'x', '<leader>sQ',
    ":call Latex_Wrap('<<', '>>')<CR>", {
      noremap = true,
      desc = 'Wrap a quote << .. >> around a visual selection',
    })

  -- Integration with inkscape-figures CLI tool
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-f>',
    "<Esc>: silent exec '.!~/.local/bin/inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>",
    { noremap = true })
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-f>',
    ": silent exec '!~/.local/bin/inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
    { noremap = true })
end

--
-- LaTeX autocommands
--

local latex_augroup = vim.api.nvim_create_augroup('Latex', {})

local on_new_file = function()
  vim.cmd '0:read ~/Templates/template.tex'
  local line_count = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_win_set_cursor(0, { line_count, 0 })
  vim.cmd 'write'
end

local on_open_file = function()
  vim.api.nvim_set_option('conceallevel', 0)

  -- autowrite
  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
    buffer = 0,
    command = 'silent update',
    group = latex_augroup,
  })

  init_keymaps()
end

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.tex',
  callback = function()
    on_new_file()
    on_open_file()
  end,
  group = latex_augroup,
})
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.tex',
  callback = on_open_file,
  group = latex_augroup,
})

require 'shar.modules.latex.language-switch'
