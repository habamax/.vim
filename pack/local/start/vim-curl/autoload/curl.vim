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

    input = Escape(input)

    var cmd = $"curl --silent {input->join()}"
    if executable("jq")
        cmd ..= ' | jq'
    endif
    if exists(":Term") == 2
        exe $"Term {cmd}"
    else
        var fullcmd = [&shell, &shellcmdflag, cmd]
        term_start(!has("win32") ? fullcmd : fullcmd->join(), {
            term_name: $"!{cmd}"
        })
    endif
enddef

def Escape(input: list<string>): list<string>
    var data_idx = -1
    var url_idx = -1
    var idx = 0
    for val in input
        if val =~ '^--url\s*.*$'
            url_idx = idx
        endif
        if val =~ '^--data\s*.*$'
            data_idx = idx
        endif
        idx += 1
    endfor

    if url_idx == -1
        return input
    endif

    # if --url is not "quoted", do quote it
    var url = input[url_idx]->split('--url\s*')[0]
    if url !~ '^\s*".*"\s*$'
        input[url_idx] = $'--url "{url}"'
    endif

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
