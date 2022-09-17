" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff
" ftplugin settings

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

setlocal softtabstop=2
setlocal shiftwidth=2

" import all settings from cpp filetype
runtime! ftplugin/cpp.vim

set autowriteall          " autowrite always
