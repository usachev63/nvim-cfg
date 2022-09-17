" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0

function MarkdownOnEnter() abort
    nnoremap <buffer> <F10> :MarkdownPreview<CR>
    nnoremap <buffer> <F9> :MarkdownPreview<CR>
endfunction

augroup MarkdownOnEnterMap
    autocmd BufNewFile,BufRead,BufEnter *.md call MarkdownOnEnter()
augroup END
