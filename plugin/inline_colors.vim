vim9script

var color_char = "●"
# var color_char = "█"
# var color_char = "■"

var xterm256colors = {
    '#000000': '16', '#870000':  '88', '#d70000': '160',
    '#00005f': '17', '#87005f':  '89', '#d7005f': '161',
    '#000087': '18', '#870087':  '90', '#d70087': '162',
    '#0000af': '19', '#8700af':  '91', '#d700af': '163',
    '#0000d7': '20', '#8700d7':  '92', '#d700d7': '164',
    '#0000ff': '21', '#8700ff':  '93', '#d700ff': '165',
    '#005f00': '22', '#875f00':  '94', '#d75f00': '166',
    '#005f5f': '23', '#875f5f':  '95', '#d75f5f': '167',
    '#005f87': '24', '#875f87':  '96', '#d75f87': '168',
    '#005faf': '25', '#875faf':  '97', '#d75faf': '169',
    '#005fd7': '26', '#875fd7':  '98', '#d75fd7': '170',
    '#005fff': '27', '#875fff':  '99', '#d75fff': '171',
    '#008700': '28', '#878700': '100', '#d78700': '172',
    '#00875f': '29', '#87875f': '101', '#d7875f': '173',
    '#008787': '30', '#878787': '102', '#d78787': '174',
    '#0087af': '31', '#8787af': '103', '#d787af': '175',
    '#0087d7': '32', '#8787d7': '104', '#d787d7': '176',
    '#0087ff': '33', '#8787ff': '105', '#d787ff': '177',
    '#00af00': '34', '#87af00': '106', '#d7af00': '178',
    '#00af5f': '35', '#87af5f': '107', '#d7af5f': '179',
    '#00af87': '36', '#87af87': '108', '#d7af87': '180',
    '#00afaf': '37', '#87afaf': '109', '#d7afaf': '181',
    '#00afd7': '38', '#87afd7': '110', '#d7afd7': '182',
    '#00afff': '39', '#87afff': '111', '#d7afff': '183',
    '#00d700': '40', '#87d700': '112', '#d7d700': '184',
    '#00d75f': '41', '#87d75f': '113', '#d7d75f': '185',
    '#00d787': '42', '#87d787': '114', '#d7d787': '186',
    '#00d7af': '43', '#87d7af': '115', '#d7d7af': '187',
    '#00d7d7': '44', '#87d7d7': '116', '#d7d7d7': '188',
    '#00d7ff': '45', '#87d7ff': '117', '#d7d7ff': '189',
    '#00ff00': '46', '#87ff00': '118', '#d7ff00': '190',
    '#00ff5f': '47', '#87ff5f': '119', '#d7ff5f': '191',
    '#00ff87': '48', '#87ff87': '120', '#d7ff87': '192',
    '#00ffaf': '49', '#87ffaf': '121', '#d7ffaf': '193',
    '#00ffd7': '50', '#87ffd7': '122', '#d7ffd7': '194',
    '#00ffff': '51', '#87ffff': '123', '#d7ffff': '195',
    '#5f0000': '52', '#af0000': '124', '#ff0000': '196',
    '#5f005f': '53', '#af005f': '125', '#ff005f': '197',
    '#5f0087': '54', '#af0087': '126', '#ff0087': '198',
    '#5f00af': '55', '#af00af': '127', '#ff00af': '199',
    '#5f00d7': '56', '#af00d7': '128', '#ff00d7': '200',
    '#5f00ff': '57', '#af00ff': '129', '#ff00ff': '201',
    '#5f5f00': '58', '#af5f00': '130', '#ff5f00': '202',
    '#5f5f5f': '59', '#af5f5f': '131', '#ff5f5f': '203',
    '#5f5f87': '60', '#af5f87': '132', '#ff5f87': '204',
    '#5f5faf': '61', '#af5faf': '133', '#ff5faf': '205',
    '#5f5fd7': '62', '#af5fd7': '134', '#ff5fd7': '206',
    '#5f5fff': '63', '#af5fff': '135', '#ff5fff': '207',
    '#5f8700': '64', '#af8700': '136', '#ff8700': '208',
    '#5f875f': '65', '#af875f': '137', '#ff875f': '209',
    '#5f8787': '66', '#af8787': '138', '#ff8787': '210',
    '#5f87af': '67', '#af87af': '139', '#ff87af': '211',
    '#5f87d7': '68', '#af87d7': '140', '#ff87d7': '212',
    '#5f87ff': '69', '#af87ff': '141', '#ff87ff': '213',
    '#5faf00': '70', '#afaf00': '142', '#ffaf00': '214',
    '#5faf5f': '71', '#afaf5f': '143', '#ffaf5f': '215',
    '#5faf87': '72', '#afaf87': '144', '#ffaf87': '216',
    '#5fafaf': '73', '#afafaf': '145', '#ffafaf': '217',
    '#5fafd7': '74', '#afafd7': '146', '#ffafd7': '218',
    '#5fafff': '75', '#afafff': '147', '#ffafff': '219',
    '#5fd700': '76', '#afd700': '148', '#ffd700': '220',
    '#5fd75f': '77', '#afd75f': '149', '#ffd75f': '221',
    '#5fd787': '78', '#afd787': '150', '#ffd787': '222',
    '#5fd7af': '79', '#afd7af': '151', '#ffd7af': '223',
    '#5fd7d7': '80', '#afd7d7': '152', '#ffd7d7': '224',
    '#5fd7ff': '81', '#afd7ff': '153', '#ffd7ff': '225',
    '#5fff00': '82', '#afff00': '154', '#ffff00': '226',
    '#5fff5f': '83', '#afff5f': '155', '#ffff5f': '227',
    '#5fff87': '84', '#afff87': '156', '#ffff87': '228',
    '#5fffaf': '85', '#afffaf': '157', '#ffffaf': '229',
    '#5fffd7': '86', '#afffd7': '158', '#ffffd7': '230',
    '#5fffff': '87', '#afffff': '159', '#ffffff': '231',
                      '#080808': '232', '#808080': '244',
                      '#121212': '233', '#8a8a8a': '245',
                      '#1c1c1c': '234', '#949494': '246',
                      '#262626': '235', '#9e9e9e': '247',
                      '#303030': '236', '#a8a8a8': '248',
                      '#3a3a3a': '237', '#b2b2b2': '249',
                      '#444444': '238', '#bcbcbc': '250',
                      '#4e4e4e': '239', '#c6c6c6': '251',
                      '#585858': '240', '#d0d0d0': '252',
                      '#626262': '241', '#dadada': '253',
                      '#6c6c6c': '242', '#e4e4e4': '254',
                      '#767676': '243', '#eeeeee': '255'
    }

def WindowLines(winid: number): list<number>
    var winfo = getwininfo(winid)[0]
    return [winfo.topline, winfo.botline]
enddef

def InlineColors(winid: number, lines: list<number> = [line('.'), line('.')]): void
    if lines[0] > lines[1]
        return
    endif
    if lines[0] < 1 || lines[1] > line('$', winid)
        return
    endif
    var bufnr = winbufnr(winid)
    var inline_colors = getbufvar(bufnr, 'inline_colors', {})
    if get(g:, "inline_color_disable", false) && !empty(inline_colors)
        prop_remove({types: inline_colors->keys(), all: true, bufnr: bufnr})
        setbufvar(bufnr, 'inline_colors', {})
        return
    elseif get(g:, "inline_color_disable", false)
        return
    endif

    if !empty(inline_colors)
        prop_remove({types: inline_colors->keys(), all: true, bufnr: bufnr}, lines[0], lines[1])
    endif

    var rx_color = '#\%(\x\{3}\|\x\{6}\)\>'

    for linenr in range(lines[0], lines[1])
        if empty(getbufline(bufnr, linenr))
            continue
        endif
        var line = getbufline(bufnr, linenr)[0]
        var [hex, starts, ends] = matchstrpos(line, rx_color, 0)
        while starts != -1
            var col_tag = "inline_color_" .. hex[1 : ]
            if len(hex) == 4
                hex = $"#{hex[1]}{hex[1]}{hex[2]}{hex[2]}{hex[3]}{hex[3]}"
            endif
            var ctermfg = get(xterm256colors, hex->tolower(), "")
            if has("gui_running") || &termguicolors || !empty(ctermfg)
                var hl = hlget(col_tag)
                if empty(hl) || hl[0]->has_key("cleared")
                    hlset([{name: col_tag, guifg: hex, ctermfg: ctermfg}])
                endif
                if prop_type_get(col_tag) == {}
                    prop_type_add(col_tag, {highlight: col_tag})
                endif
                prop_add(linenr, starts + 1, {text: color_char, type: col_tag, bufnr: bufnr})
                inline_colors[col_tag] = 1
            endif
            [hex, starts, ends] = matchstrpos(line, rx_color, ends + 1)
        endwhile
    endfor
    setbufvar(bufnr, 'inline_colors', inline_colors)
enddef

def InlineColorsInWindows()
    var windows = getwininfo()
    for w in windows
        InlineColors(w.winid, WindowLines(w.winid))
    endfor
enddef

augroup InlineColors | au!
    au WinScrolled * InlineColors(win_getid(), WindowLines(win_getid()))
    au BufRead * InlineColorsInWindows()
    au WinEnter * InlineColorsInWindows()
    au OptionSet background InlineColorsInWindows()
    au OptionSet termguicolors InlineColorsInWindows()
    au Colorscheme * InlineColorsInWindows()
    au TextChanged * InlineColors(win_getid(), [line("'[", win_getid()), line("']", win_getid())])
    au InsertLeave * InlineColors(win_getid(), [line("'[", win_getid()), line("']", win_getid())])
augroup END
