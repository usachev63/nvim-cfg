" Entry point of my neovim configuration.

" General configuration
source ~/.config/nvim/plugins.vim     " plugins
source ~/.config/nvim/settings.vim    " general settings
source ~/.config/nvim/maps.vim        " general maps

" Filetype-specific configuration
source ~/.config/nvim/acm_cpp.vim     " custom filetype for acm cpp programs
source ~/.config/nvim/latex.vim       " utilities for using latex
source ~/.config/nvim/latex_lang.vim  " latex & xkbswitch
source ~/.config/nvim/markdown.vim    " markdown settings

" Change directory scripts
source ~/.config/nvim/chdir.vim

" Configuration of nvim-autopairs plugin
lua require('nvim-autopairs-cfg')

" Configuration of coq_nvim autocompletion engine
lua require('coq-cfg')

" Configuration of LSP, linters, formatters, etc.
lua require('lsp-cfg')

" Language auto-switching for latex
lua require('latex-xkb')
