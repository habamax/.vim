" --url https://ya.ru
" --silent
" --show-error

" --url https://butr.avast.com/rest/api/2/issue/DOC-1734
" --user rdm:heslo123
" --silent
" --show-error

"--url https://localhost:8889/portal/check_dp
"--user username:password
"--silent
"--show-error
"--header "Content-Type: application/json"
"--data
"{
"    "email": "general@hello.ru",
"    "country_code":  "RU",
"    "city": "Moscow"
"}

let s:state = {}

func! curl#do() range
    " getting input
    if a:firstline == a:lastline
        let firstline = search('^\(\s*$\)\|\%^', 'bnW')
        let lastline = search('^\(\s*$\)\|\%$', 'nW')
    else
        let firstline = a:firstline
        let lastline = a:lastline
    endif
    let input = filter(getline(firstline, lastline), {v -> v !~ '^#.*$'})
    if empty(input)
        echom 'Nothing to cURL'
        return
    endif

    let input = s:escape_data(input)

    if !s:state->has_key("result_buf")
        vertical new [CURL RESULT]
        let s:state.result_buf = bufnr()
    elseif bufwinnr(s:state.result_buf) == -1
        exe "vertical sbuffer "..s:state.result_buf
    else
        exe bufwinnr(s:state.result_buf).."wincmd w"
    endif
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal noundofile
    setlocal nospell
    setlocal nowrap

    call deletebufline(bufnr(), 1, '$')
    call setline(1, systemlist("curl --config -", input)) 

    " detect filetype and format accordingly
    if getline(1) =~ '^<...'
        set ft=html
    elseif getline(1) =~ '^[\[{]'
        set ft=json
    endif
    if exists("#User#CurlOutput")
        doautocmd User CurlOutput
    endif
endfunc


func! s:escape_data(input) abort
    " find --data (should be last parameter of the curl)
    " do nothing if not found -- return the same unmodified input
    let data_idx = -1
    let idx = 0
    for val in a:input
        if val =~ '^--data\s*.*$'
            let data_idx = idx
            break
        endif
        let idx += 1
    endfor

    if data_idx == -1
        return a:input
    endif

    " if --data has "quoted" data do nothing, return unmodified input
    if a:input[data_idx] =~ '--data\s\+".*'
        return a:input
    endif

    let params = a:input[0 : data_idx - 1]
    let data = a:input[data_idx : -1]

    call map(data, {_, v -> escape(v, "\"'")})
    let data[0] = '--data "' .. substitute(data[0], '--data\s*', '', '')
    let data[-1] = data[-1] .. '"'

    return params + [join(data)]
endfunc
