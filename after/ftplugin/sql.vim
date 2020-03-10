" Install sqlparse first
" `pip install --upgrade sqlparse`
" Now you can gggqG to reformat current sql buffer
if executable('sqlformat')
    setlocal formatprg=sqlformat\ -s\ -a\ --keywords\ upper\ --wrap_after\ 120\ -
endif

" setlocal commentstring=--\ %s
let &l:commentstring = "-- %s"
