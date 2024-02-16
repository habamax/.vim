vim9script

# --url https://ya.ru
# --silent
# --show-error

# --url https://localhost:8889/portal/check_dp
# --user username:password
# --silent
# --show-error
# --header "Content-Type: application/json"
# --data
# {
#     "email": "general@gmail.com",
#     "country_code": "AU",
#     "city": "Melbourne"
# }

var state = {}

# collect all common parameters
# --$url https://base-url.com/rest/2.0
# --$header "Authorization: Basic YWRtaW46cGFzc3dvcmQ="
# --$header "Content-Type: application/json"
def CommonParams(): list<string>
    var result = []
    var nr = 0
    while nr < 100 && nr < line('$')
        nr += 1
        var line = getline(nr)
        if line =~ '^#.*'
            continue
        endif
        if line =~ '^--\$\S.*'
            add(result, line->substitute('^--\$', '--', ''))
        endif
        if line =~ '^\s*$'
            break
        endif
    endwhile
    return result
enddef

def MergeCommonParams(input: list<string>, params: list<string>): list<string>
    var result = []
    var url = ''
    var auth = false
    for item in params
        if item =~ '^--url.*$'
            url = item
        else
            if item =~ '^--header\s.*Authorization:.*'
                auth = true
            endif
            add(result, item)
        endif
    endfor
    for item in input
        if item =~ '^--url\s\+\(http\)\@!.*$' && !empty(url)
            add(result, url .. item->substitute('^--url\s\+', '', ''))
        elseif item =~ '^--header\s.*Authorization:.*' && auth
            continue
        else
            add(result, item)
        endif
    endfor
    return result
enddef

export def Execute(line1: number, line2: number)
    var firstline = line1
    var lastline = line2
    # getting input
    if firstline == lastline
        firstline = search('^\(\s*$\)\|\%^', 'cbnW')
        lastline = search('^\(\s*$\)\|\%$', 'cnW')
    endif
    # remove comments and empty lines
    var input = filter(getline(firstline, lastline), (_, v) => v !~ '^#.*$' && v !~ '^\s*$')
    if empty(input)
        echom 'Nothing to cURL'
        return
    endif

    input = MergeCommonParams(input, CommonParams())

    input = EscapeData(input)

    if !state->has_key("result_buf")
        rightbelow vnew
        silent file `='[cURL output]'`
        setlocal buftype=nofile noswapfile noundofile
        setlocal nospell
        setlocal nowrap
        state.result_buf = bufnr()
    elseif bufwinnr(state.result_buf) == -1
        exe $"rightbelow vertical sbuffer {state.result_buf}"
    else
        exe $":{bufwinnr(state.result_buf)}wincmd w"
    endif

    deletebufline(bufnr(), 1, '$')
    setline(1, systemlist("curl -s --config -", input))

    # detect filetype and format accordingly
    if getline(1) =~ '^<...'
        set ft=html
    elseif getline(1) =~ '^[\[{]'
        set ft=json
    endif
    if exists("#User#CurlOutput")
        doautocmd User CurlOutput
    endif
enddef

def EscapeData(input: list<string>): list<string>
    # find --data (should be last parameter of the curl)
    # do nothing if not found -- return the same unmodified input
    var data_idx = -1
    var idx = 0
    for val in input
        if val =~ '^--data\s*.*$'
            data_idx = idx
            break
        endif
        idx += 1
    endfor

    if data_idx == -1
        return input
    endif

    # if --data has "quoted" data do nothing, return unmodified input
    if input[data_idx] =~ '--data\s\+".*'
        return input
    endif

    var params = input[0 : data_idx - 1]
    var data = input[data_idx : -1]

    data = mapnew(data, (_, v) => escape(v, "\"'"))
    data[0] = '--data "' .. substitute(data[0], '--data\s*', '', '')
    data[-1] = data[-1] .. '"'

    return params + [join(data)]
enddef
