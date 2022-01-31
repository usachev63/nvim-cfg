" "%%" is now essentially "%:h/"
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

