" <Space> is the leader key
nnoremap <Space> <NOR>
let mapleader = "\<Space>"

" "%%" is now essentially "%:h/"
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" & works as ":&&" and not as ":s"
nnoremap & :&&<CR>
xnoremap & :&&<CR>
