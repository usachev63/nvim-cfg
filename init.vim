" Entry point of my neovim configuration

source plugins.vim     " plugins

source settings.vim    " general settings
source maps.vim        " general maps

source python_map.vim  " useful run maps for *.py files

source acm_cpp.vim     " custom filetype for acm cpp programs

source latex.vim       " utilities for using latex
source markdown.vim    " markdown settings

lua require('nvim-lsp-installer-config')
