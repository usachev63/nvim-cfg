" <Space> is the leader key
nnoremap <Space> <NOR>
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" "%%" is now essentially "%:h/"
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" & works as ":&&" and not as ":s"
nnoremap & :&&<CR>
xnoremap & :&&<CR>

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
nnoremap <Leader>e :Explore<CR>
