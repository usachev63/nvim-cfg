vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.wo.spell = true
vim.bo.spelloptions = 'camel'

vim.keymap.set('n', '<LocalLeader>th', ':ClangdSwitchSourceHeader<CR>')

-- Fix comment string for vim-commentary
vim.bo.commentstring = '// %s'

vim.g.load_doxygen_syntax = true

vim.opt_local.wildignore = {
  'build*/**',
  'third-party/**'
}
