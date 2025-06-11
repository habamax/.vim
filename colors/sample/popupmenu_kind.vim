func s:CompleteFunc( findstart, base )
    if a:findstart
        return 0
    endif
    return {
          \ 'words': [
          \ { 'word': 'Complete me now', 'menu': 'Something to complete', 'kind': 'W', },
          \ { 'word': 'Not me! Not me!', 'menu': 'Please, not again!', 'kind': 'f', },
          \ { 'word': 'Right, use me then!', 'menu': 'At your command', 'kind': 'd', },
          \]}
endfunc

tabnew
setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
setlocal completeopt=menu
setlocal completefunc=s:CompleteFunc

call feedkeys('i')
