""" Trying propmt buffers and matchfuzzy

let s:state = {}

command! -nargs=? Prompt call Prompt(<q-args>)

func! Prompt(...) abort
    let s:state = {}
    if len(a:000) == 1
        " TODO: proper check
        let s:state.type = a:1
    else
        let s:state.type = 'files'
    endif
    let s:state.laststatus = &laststatus
    let s:state.showmode = &showmode
    let s:state.ruler = &ruler
    let s:state.init_buf = {"bufnr": bufnr(), "winid": winnr()->win_getid()}
    let s:state.result_buf = s:create_result_buf()
    let s:state.prompt_buf = s:create_prompt_buf()
    call s:on_update()
    startinsert!
endfunc


func! s:create_prompt_buf() abort
    call s:prepare_buffer('prompt')
    call s:add_prompt_mappings()
    call s:add_prompt_autocommands()

    return {"bufnr": bufnr(), "winid": winnr()->win_getid()}
endfunc


func! s:create_result_buf() abort
    call s:prepare_buffer('result')
    return {"bufnr": bufnr(), "winid": winnr()->win_getid()}
endfunc


func! s:prepare_buffer(type)
    if a:type == "prompt"
        noautocmd keepalt botright 1new
        setlocal buftype=prompt
        setlocal nocursorline
    elseif a:type == 'result'
        noautocmd keepalt botright 10new
        setlocal buftype=nofile
        setlocal cursorline
        setlocal noruler
        setlocal laststatus=0
        setlocal noshowmode
    endif
    setlocal bufhidden=unload
    setlocal noundofile
    setlocal nospell
    setlocal nobuflisted
    setlocal nocursorcolumn
    setlocal nowrap
    setlocal nonumber norelativenumber
    setlocal nolist
    setlocal noswapfile
    setlocal tw=0
    setlocal winfixheight
    abc <buffer>
endfunc


func! s:close() abort
    call win_execute(s:state.result_buf.winid, "quit!", 1)
    call win_execute(s:state.prompt_buf.winid, "quit!", 1)
    call win_gotoid(s:state.init_buf.winid)

    let &laststatus = s:state.laststatus
    let &showmode = s:state.showmode
    let &ruler = s:state.ruler
endfunc

func! s:on_cancel() abort
    call s:close()
endfunc


func! s:on_select() abort
    let current_res = s:get_current_result()
    call s:close()
    " exe "colorscheme " .. res_line
    exe "e " .. current_res
endfunc


func! s:on_update() abort
    call win_execute(s:state.result_buf.winid, "%delete_", 1)
    " Have to remove prompt from the line. I wonder if regular buffer would be
    " better here?
    let input = s:get_prompt_value()

    let items = map(readdirex(expand("%:p:h"), {d -> d.type == 'dir'}), {k,v -> v.type == "dir" ? v.name..'/' : v.name}) 
                \+ map(readdirex(expand("%:p:h"), {d -> d.type != 'dir'}), {k,v -> v.type == "dir" ? v.name..'/' : v.name})
    if input !~ '^\s*$'
        let items = matchfuzzy(items, input)
    endif
    call setbufline(s:state.result_buf.bufnr, 1, items)
endfunc


func! s:on_next_maybe() abort
    let current_res = s:get_current_result()
    if current_res =~ '/$'
        exe 'lcd '..expand("%:p:h")..'/'..current_res
        normal! cc
        call s:on_update()
    else
        call win_execute(s:state.result_buf.winid, 'normal! j', 1)
    endif
    startinsert!
endfunc


func! s:on_backspace() abort
    if empty(s:get_prompt_value())
        exe 'lcd '..expand("%:p:h:h")
        call s:on_update()
    else
        normal! x
    endif
    startinsert!
endfunc


func! s:on_prev_maybe() abort
    call win_execute(s:state.result_buf.winid, 'normal! k', 1)
    startinsert!
endfunc


func! s:get_current_result() abort
    let res_linenr = line('.', s:state.result_buf.winid)
    return getbufline(s:state.result_buf.bufnr, res_linenr)[0]
endfunc


func! s:get_prompt_value() abort
    return strcharpart(s:state.prompt_buf.bufnr->getbufline(1)[0], strchars(s:state.prompt_buf.bufnr->prompt_getprompt()))
endfunc


func! s:add_prompt_mappings() abort
    inoremap <silent><buffer> <CR> <ESC>:call <SID>on_select()<CR>
    inoremap <silent><buffer> <ESC> <ESC>:call <SID>on_cancel()<CR>
    inoremap <silent><buffer> <TAB> <ESC>:call <SID>on_next_maybe()<CR>
    inoremap <silent><buffer> <S-TAB> <ESC>:call <SID>on_prev_maybe()<CR>
    inoremap <silent><buffer> <BS> <ESC>:call <SID>on_backspace()<CR>
endfunc


func! s:add_prompt_autocommands() abort
    augroup prompt | au!
        au TextChangedI <buffer> call s:on_update()
    augroup END
endfunc
