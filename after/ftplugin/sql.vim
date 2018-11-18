" Install sqlparse first
" `pip install --upgrade sqlparse`
" Now you can gggqG to reformat current sql buffer
setlocal formatprg=sqlformat\ -s\ -a\ --keywords\ upper\ --wrap_after\ 120\ -
" setlocal formatprg=sqlformat\ -r\ -a\ --keywords\ upper\ -

" setlocal commentstring=--\ %s
let &l:commentstring = "-- %s"
