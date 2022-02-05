" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff
" ftplugin settings

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" import all settings from cpp filetype
runtime! ftplugin/cpp.vim

set autowriteall     " autowrite always

" maps
" compile and run
nnoremap <F10> :first<CR>:w <bar> terminal acm % -o %:r && ./%:r<CR>
" only run
nnoremap <F9> :first<CR>:terminal ./%:r<CR>
