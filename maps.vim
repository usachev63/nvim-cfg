" <Space> is the leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Sometimes this works unexpected
inoremap <C-Space> <Space>

" UltiSnips keys
nnoremap <C-j> <Nop>
inoremap <C-j> <Nop>
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" some bracket maps from vim-unimpaired
nnoremap [a     :previous<CR>
nnoremap ]a     :next<CR>
nnoremap [A     :first<CR>
nnoremap ]A     :last<CR>
nnoremap [b     :bprevious<CR>
nnoremap ]b     :bnext<CR>
nnoremap [B     :bfirst<CR>
nnoremap ]B     :blast<CR>
nnoremap [l     :lprevious<CR>
nnoremap ]l     :lnext<CR>
nnoremap [L     :lfirst<CR>
nnoremap ]L     :llast<CR>
nnoremap [<C-L> :lpfile<CR>
nnoremap ]<C-L> :lnfile<CR>
nnoremap [q     :cprevious<CR>
nnoremap ]q     :cnext<CR>
nnoremap [Q     :cfirst<CR>
nnoremap ]Q     :clast<CR>
nnoremap [<C-Q> :cpfile<CR>
nnoremap ]<C-Q> :cnfile<CR>
nnoremap [t     :tprevious<CR>
nnoremap ]t     :tnext<CR>
nnoremap [T     :tfirst<CR>
nnoremap ]T     :tlast<CR>
nnoremap [<C-T> :ptprevious<CR>
nnoremap ]<C-T> :ptnext<CR>

" useful key for closing terminal buffer
nnoremap <Leader>q :b#<CR>:bdelete! #<CR>

" instead of :E (now getting E464 error)
nmap <Leader>e :e %%<CR>

" Replace the contents of whole file from "+
nnoremap <Leader>dp :%delete\|0put+<CR>gg

" Switch with alternate file
nnoremap <BS> <C-^>

" Fugitive git conflict resolution
nnoremap <Leader>df :Gvdiffsplit!<CR>
nnoremap <Leader>dh :diffget //2<CR>
nnoremap <Leader>dl :diffget //3<CR>
