tabnew
setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
silent vsplit $VIMRUNTIME/README.txt
wincmd w
call feedkeys('i')
