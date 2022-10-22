" Entry point of my neovim configuration.

" General configuration
source ~/.config/nvim/plugins.vim     " plugins
source ~/.config/nvim/settings.vim    " general settings
source ~/.config/nvim/maps.vim        " general maps

" Filetype-specific configuration
source ~/.config/nvim/acm_cpp.vim     " custom filetype for acm cpp programs
source ~/.config/nvim/latex.vim       " utilities for using latex
source ~/.config/nvim/markdown.vim    " markdown settings

" Change directory scripts
source ~/.config/nvim/chdir.vim

" Configuration of nvim-cmp autocompletion engine
lua require('nvim-cmp-cfg')

" Configuration of LSP, linters, formatters, etc.
lua require('lsp-cfg')
