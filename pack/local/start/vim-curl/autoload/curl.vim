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
    var jq = ''
    var auth = false
    for item in params
        if item =~ '^--url\s\+.*$'
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

export def Execute(line1: number, line2: number, clipboard: bool = false)
    var firstline = line1
    var lastline = line2
    # getting input
    if firstline == lastline
        firstline = search('^\(\s*$\)\|\%^', 'cbnW')
        lastline = search('^\(\s*$\)\|\%$', 'cnW')
    endif
    # remove comments and empty lines, trim non-empty.
    var input = getline(firstline, lastline)
        ->filter((_, v) => v !~ '^#.*$' && v !~ '^\s*$')
        ->mapnew((_, v) => trim(v))
    if empty(input)
        echom 'Nothing to cURL'
        return
    endif

    input = MergeCommonParams(input, CommonParams())

    # extract --jq
    var jq_idx = input->index('--jq')
    var use_jq = jq_idx > -1
    if use_jq
        remove(input, jq_idx)
    endif

    input = Escape(input)

    var cmd = $"curl --silent {input->join()}"
    if use_jq && executable("jq")
        cmd ..= ' | jq'
    endif
    if clipboard
        setreg("+", cmd)
    endif
    Terminal(cmd, BotRight())
enddef

def Escape(input: list<string>): list<string>
    var data_idx = -1
    var url_idx = -1
    var url_query_idx = -1
    var idx = 0
    for val in input
        if val =~ '^--url-query\s*.*$'
            # if --url-query is not "quoted", do quote it
            var url_query = input[idx]->split('--url-query\s*')[0]
            if url_query !~ '^\s*".*"\s*$'
                input[idx] = $'--url-query "{url_query}"'
            endif
        endif
        if val =~ '^--url\s\+.*$'
            # if --url is not "quoted", do quote it
            var url = input[idx]->split('--url\s*')[0]
            if url !~ '^\s*".*"\s*$'
                input[idx] = $'--url "{url}"'
            endif
        endif
        if val =~ '^--data\s*.*$'
            data_idx = idx
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


def Terminal(cmd: string, mods: string)
    var cwd = getcwd()
    var term_name = $'!{cmd}'
    var termbuf = term_list()->filter((_, v) => term_getstatus(v) != 'running')
    var bufnr = !empty(termbuf) ? termbuf[0] : -1
    defer () => {
        if bufnr != -1
            exe "bw!" bufnr
        endif
    }()
    if !win_gotoid(bufwinid(bufnr)) && bufnr != -1
        exe $"{mods} sbuffer {bufnr}"
    elseif bufnr == -1
        var counter = 1
        while !empty(term_list()->filter((_, v) => bufname(v) == term_name))
            term_name = term_name->substitute('\( (\d\+)\)\?$', $' ({counter})', '')
            counter += 1
        endwhile
        exe $"{mods} split"
    endif

    var fullcmd = [&shell, &shellcmdflag, cmd]
    term_start(!has("win32") ? fullcmd : fullcmd->join(), {
        term_name: term_name,
        curwin: true,
        cwd: cwd,
    })
enddef

def BotRight(): string
    var res = "botright "
    if &columns * 0.6 < winwidth(winnr()) && &columns > 99
        res = "vertical " .. res
    endif
    return res
enddef
