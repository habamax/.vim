vim9script

var popup_borderchars = get(g:, "popup_borderchars", ['─', '│', '─', '│', '┌', '┐', '┘', '└'])
var popup_borderchars_t = get(g:, "popup_borderchars_t", ['─', '│', '─', '│', '├', '┤', '┘', '└'])
var popup_borderhighlight = get(g:, "popup_borderhighlight", ['Normal'])
var popup_highlight = get(g:, "popup_highlight", 'Normal')
var popup_match_highlight = get(g:, "popup_match_highlight", "Constant")
var popup_key_highlight = get(g:, "popup_key_highlight", "Constant")
var popup_key_sep_highlight = get(g:, "popup_key_sep_highlight", "Comment")
var popup_cursor = get(g:, "popup_cursor", '▏')
var popup_prompt = get(g:, "popup_prompt", '> ')
var popup_number = get(g:, "popup_number", false)


# Helper popup to create command popup windows.
# Usage:
# import autoload 'popup.vim'
# export def Qf()
#     var commands = [
#         {text: "Quickfix"},
#         {text: "Next", key: "j", cmd: "cnext"},
#         {text: "Prev", key: "k", cmd: "cprev"},
#         {text: "Location"},
#         {text: "Next", key: ".", cmd: "lnext"},
#         {text: "Prev", key: ",", cmd: "lprev"},
#     ]
#     popup.Commands(commands)
# enddef
export def Commands(commands: list<dict<any>>, pos_botright: bool = true): number
    if empty(commands)
        return -1
    endif

    if empty(prop_type_get('PopupCommandKey'))
        exe $"hi def link PopupCommandKey {popup_key_highlight}"
        prop_type_add('PopupCommandKey', {highlight: "PopupCommandKey", override: true, priority: 1000, combine: true})
    endif
    if empty(prop_type_get('PopupCommandKeySep'))
        exe $"hi def link PopupCommandKeySep {popup_key_sep_highlight}"
        prop_type_add('PopupCommandKeySep', {highlight: "PopupCommandKeySep", override: true, priority: 1000, combine: true})
    endif
    if empty(prop_type_get('PopupCommandKeyTitle'))
        hi def link PopupCommandKeyTitle Title
        prop_type_add('PopupCommandKeyTitle', {highlight: "PopupCommandKeyTitle", override: true, priority: 1000, combine: true})
    endif
    commands->foreach((_, v) => {
        if v->has_key("key")
            v.text = $"  {keytrans(v.key)} → {v.text}"
            v.props = [{col: 3, length: len(keytrans(v.key)), type: "PopupCommandKey"},
                       {col: 4 + len(keytrans(v.key)), length: 1, type: "PopupCommandKeySep"}]
        else
            v.props = [{col: 1, length: len(v.text), type: "PopupCommandKeyTitle"}]
        endif
    })
    var winid = popup_create(commands, {
        pos: 'botright',
        col: pos_botright ? &columns : 'cursor',
        line: pos_botright ? &lines : 'cursor-1',
        padding: [0, 1, 0, 1],
        border: [1, 1, 1, 1],
        mapping: 0,
        tabpage: -1,
        borderchars: popup_borderchars,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        filter: (winid, key) => {
            if key == "\<cursorhold>" || key == "\<ignore>"
                return true
            endif
            var cmd_idx = commands->indexof((_, v) => get(v, "key", "") == key)
            if cmd_idx != -1
                try
                    if type(commands[cmd_idx].cmd) == v:t_string
                        exe commands[cmd_idx].cmd
                    elseif type(commands[cmd_idx].cmd) == v:t_func
                        commands[cmd_idx].cmd()
                    endif
                    if get(commands[cmd_idx], "close", false)
                        popup_close(winid)
                    endif
                catch
                endtry
                return true
            else
                popup_close(winid)
            endif
            return true
        }
    })
    return winid
enddef

# Shows popup window at cursor position
export def ShowAtCursor(text: any, Setup: func(number) = null_function): number
    var new_text = text
    if text->type() == v:t_string
        new_text = text->trim("\<CR>")
    else
        new_text = text->mapnew((_, v) => v->trim("\<CR>"))
    endif
    var winid = popup_create(new_text, {
        padding: [0, 1, 0, 1],
        border: [],
        borderchars: popup_borderchars,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        pos: screencol() > &columns / 1.7 ? "botright" : "botleft",
        line: 'cursor-1',
        col: 'cursor',
        moved: 'WORD',
        mapping: 0,
        filter: (winid, key) => {
            if key == "\<Space>"
                win_execute(winid, "normal! \<C-d>\<C-d>")
                return true
            elseif key == "j"
                win_execute(winid, "normal! \<C-d>")
                return true
            elseif key == "k"
                win_execute(winid, "normal! \<C-u>")
                return true
            elseif key == "g"
                win_execute(winid, "normal! gg")
                return true
            elseif key == "G"
                win_execute(winid, "normal! G")
                return true
            endif
            if key == "\<ESC>"
                popup_close(winid)
                return true
            endif
            return true
        }
    })
    if Setup != null_function
        Setup(winid)
    endif
    return winid
enddef

# Popup menu with fuzzy filtering
# Example usage 1:
# import autoload 'popup.vim'
# popup.Select("Echo Text",
#            ["He was aware there were numerous wonders of this world including the",
#             "unexplained creations of humankind that showed the wonder of our",
#             "ingenuity. There are huge heads on Easter Island. There are the",
#             "Egyptian pyramids. There's Stonehenge. But he now stood in front of a",
#             "newly discovered monument that simply didn't make any sense and he",
#             "wondered how he was ever going to be able to explain it.",
#             "The wave crashed and hit the sandcastle head-on. The sandcastle began",
#             "to melt under the waves force and as the wave receded, half the",
#             "sandcastle was gone. The next wave hit, not quite as strong, but still",
#             "managed to cover the remains of the sandcastle and take more of it",
#             "away. The third wave, a big one, crashed over the sandcastle completely",
#             "covering and engulfing it. When it receded, there was no trace the",
#             "sandcastle ever existed and hours of hard work disappeared forever." ],
#            (res, key) => {
#               echo res
#            })
# Example usage 2:
# popup.Select("Buffers",
#         getbufinfo({'buflisted': 1})->mapnew((_, v) => {
#                 return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
#             }),
#         (res, key) => {
#             if key == "\<c-t>"
#                 exe $":tab sb {res.bufnr}"
#             elseif key == "\<c-j>"
#                 exe $":sb {res.bufnr}"
#             elseif key == "\<c-v>"
#                 exe $":vert sb {res.bufnr}"
#             else
#                 exe $":b {res.bufnr}"
#             endif
#         })
export def Select(title: string, items: list<any>, Callback: func(any, string), Setup: func(number) = null_function, close_on_bs: bool = false)
    if empty(prop_type_get('PopupSelectMatch'))
        exe $"hi def link PopupSelectMatch {popup_match_highlight}"
        prop_type_add('PopupSelectMatch', {highlight: "PopupSelectMatch", override: true, priority: 1000, combine: true})
    endif
    var prompt_text = ""
    var items_dict: list<dict<any>>
    var items_count = items->len()
    if items_count > 0 && items[0]->type() != v:t_dict
        items_dict = items->mapnew((_, v) => {
            return {text: v}
        })
    else
        items_dict = items
    endif

    var filtered_items: list<any> = [items_dict]
    var maxwidth = (&columns * 0.9)->float2nr()
    var minwidth = max([min([70, maxwidth]), (&columns * 0.6)->float2nr()])
    var maxheight = &lines - 9
    var minheight = min([maxheight, max([items->len(), 10])])
    var pos_top = ((&lines - minheight) / 2) - 1
    var scrollbar_before_update = 0

    def Format(itemsAny: list<any>, props: list<any>): list<any>
        if itemsAny[0]->len() == 0 | return [] | endif

        var max_visible_pretext_len = 0
        var max_visible_posttext_len = 0
        var max_visible_text_len = 0
        var i = 0
        while i < maxheight * 3 && i < itemsAny[0]->len()
            if max_visible_text_len < len(itemsAny[0][i].text)
                max_visible_text_len = len(itemsAny[0][i].text)
            endif
            var pretext = get(itemsAny[0][i], "pretext", "")
            if max_visible_pretext_len < strwidth(pretext)
                max_visible_pretext_len = strwidth(pretext)
            endif
            var posttext = get(itemsAny[0][i], "posttext", "")
            if max_visible_posttext_len < strwidth(posttext)
                max_visible_posttext_len = strwidth(posttext)
            endif
            i += 1
        endwhile

        if max_visible_text_len + max_visible_pretext_len + max_visible_posttext_len >= maxwidth
            max_visible_text_len = maxwidth - max_visible_pretext_len - max_visible_posttext_len
        endif

        if itemsAny->len() > 1
            return itemsAny[0]->mapnew((idx, v) => {
                var pretext = get(v, "pretext", "")
                var posttext = get(v, "posttext", "")
                var text = pretext
                if strwidth(pretext) < max_visible_pretext_len
                    text ..= repeat(" ", max_visible_pretext_len - strwidth(pretext))
                endif
                text ..= v.text
                if !empty(posttext)
                    if strwidth(v.text) < max_visible_text_len
                        text ..= repeat(" ", max_visible_text_len - strwidth(v.text))
                    endif
                    text ..= posttext
                endif
                return {text: text, props: itemsAny[1][idx]->mapnew((_, c) => {
                    return {col: strlen(pretext) + v.text->byteidx(c) + 1, length: 1, type: 'PopupSelectMatch'}
                })}
            })
        else
            return itemsAny[0]->mapnew((_, v) => {
                var pretext = get(v, "pretext", "")
                var posttext = get(v, "posttext", "")
                var text = pretext
                if strwidth(pretext) < max_visible_pretext_len
                    text ..= repeat(" ", max_visible_pretext_len - strwidth(pretext))
                endif
                text ..= v.text
                if !empty(posttext)
                    if strwidth(v.text) < max_visible_text_len
                        text ..= repeat(" ", max_visible_text_len - strwidth(v.text))
                    endif
                    text ..= posttext
                endif

                return {text: text}
            })
        endif
    enddef

    def AlignPopups(pwinid: number, winid: number)
        var width = popup_getpos(winid).core_width + (scrollbar_before_update - popup_getpos(winid).scrollbar)
        popup_move(winid, {
            minwidth: width
        })

        width = popup_getpos(winid).core_width + popup_getpos(winid).scrollbar
        var padding = (popup_number ? 0 : 1)
        popup_move(pwinid, {
            minwidth: width + padding,
            maxwidth: width + padding
        })
        scrollbar_before_update = popup_getpos(winid).scrollbar
    enddef

    def UpdatePopups(pwinid: number, winid: number)
        var count_f = printf("%1$*2$.*3$d",
            items_count > 0 ? filtered_items[0]->len() : 0,
            0,
            items_count->string()->len())
        var count = $"{count_f}/{items_count}"
        if filtered_items[0]->empty()
            win_execute(winid, $"if &l:cul | setl {popup_number ? "nonu" : ""} nocul | endif")
        else
            win_execute(winid, $"if !&l:cul | setl {popup_number ? "nu" : ""} cul | endif")
        endif
        popup_setoptions(pwinid, {title: $" {title} ({count}) "})
        popup_settext(pwinid, $"{popup_prompt}{prompt_text}{popup_cursor}")
        scrollbar_before_update = popup_getpos(winid).scrollbar
        popup_settext(winid, Format(filtered_items, []))
    enddef

    # hide cursor
    set t_ve=
    var gui_cursor = hlget("Cursor")
    hlset([{name: 'Cursor', cleared: true}])

    def RestoreCursor()
        set t_ve&
        if hlget("Cursor")[0]->get('cleared', false)
            hlset(gui_cursor)
        endif
    enddef

    var ignore_input = ["\<cursorhold>", "\<ignore>", "\<Nul>",
          \ "\<LeftMouse>", "\<LeftRelease>", "\<LeftDrag>", $"\<2-LeftMouse>",
          \ "\<RightMouse>", "\<RightRelease>", "\<RightDrag>", "\<2-RightMouse>",
          \ "\<MiddleMouse>", "\<MiddleRelease>", "\<MiddleDrag>", "\<2-MiddleMouse>",
          \ "\<MiddleMouse>", "\<MiddleRelease>", "\<MiddleDrag>", "\<2-MiddleMouse>",
          \ "\<X1Mouse>", "\<X1Release>", "\<X1Drag>", "\<X2Mouse>", "\<X2Release>", "\<X2Drag>",
          \ "\<ScrollWheelLeft", "\<ScrollWheelRight>"
    ]
    # this sequence of bytes are generated when left/right mouse is pressed and
    # mouse wheel is rolled
    var ignore_input_wtf = [128, 253, 100]

    var popts = {
        minwidth: minwidth,
        maxwidth: maxwidth,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        drag: 0,
        wrap: 1,
        scrollbar: true,
        cursorline: false,
        padding: [0, 0, 0, 0],
        mapping: 0,
    }
    var pwinid = popup_create([$"> {popup_cursor}"],
        popts->copy()->extend({
            border: [1, 1, 0, 1],
            borderchars: popup_borderchars,
            line: pos_top,
            maxheight: 1,
            minheight: 1,
        })
    )
    var winid = popup_create(Format(filtered_items, []), popts->copy()->extend({
        border: [1, 1, 1, 1],
        borderchars: popup_borderchars_t,
        line: pos_top + 2,
        padding: [0, 0, 0, (popup_number ? 0 : 1)],
        minheight: minheight,
        maxheight: maxheight,
        filter: (id, key) => {
            if key == "\<esc>"
                popup_close(id, -1)
                popup_close(pwinid)
                RestoreCursor()
            elseif ["\<cr>", "\<C-j>", "\<C-v>", "\<C-t>", "\<C-o>"]->index(key) > -1
                    && !filtered_items[0]->empty() && items_count > 0
                popup_close(id, {idx: getcurpos(id)[1], key: key})
                popup_close(pwinid)
                RestoreCursor()
            elseif ["\<Right>", "\<PageDown>"]->index(key) > -1
                win_execute(id, 'normal! ' .. maxheight .. "\<C-d>")
                AlignPopups(pwinid, id)
            elseif ["\<Left>", "\<PageUp>"]->index(key) > -1
                win_execute(id, 'normal! ' .. maxheight .. "\<C-u>")
                AlignPopups(pwinid, id)
            elseif key == "\<Home>"
                win_execute(id, "normal! gg")
                AlignPopups(pwinid, id)
            elseif key == "\<End>"
                win_execute(id, "normal! G")
                AlignPopups(pwinid, id)
            elseif ["\<tab>", "\<C-n>", "\<Down>", "\<ScrollWheelDown>"]->index(key) > -1
                var ln = getcurpos(id)[1]
                win_execute(id, "normal! j")
                if ln == getcurpos(id)[1]
                    win_execute(id, "normal! gg")
                endif
                AlignPopups(pwinid, id)
            elseif ["\<S-Tab>", "\<C-p>", "\<Up>", "\<ScrollWheelUp>"]->index(key) > -1
                var ln = getcurpos(id)[1]
                win_execute(id, "normal! k")
                if ln == getcurpos(id)[1]
                    win_execute(id, "normal! G")
                endif
                AlignPopups(pwinid, id)
            # Ignoring fancy events and double clicks, which are 6 char long: `<80><fc> <80><fd>.`
            elseif ignore_input->index(key) == -1 && strcharlen(key) != 6 && str2list(key) != ignore_input_wtf
                if key == "\<C-u>"
                    prompt_text = ""
                    filtered_items = [items_dict]
                elseif key == "\<C-w>"
                    prompt_text = matchstr(prompt_text, '\v^.{-}\ze(([[:punct:][:space:]]+)|([[:lower:][:upper:][:digit:]]+\s*))$')
                    if empty(prompt_text)
                        filtered_items = [items_dict]
                    else
                        filtered_items = items_dict->matchfuzzypos(prompt_text, {key: "text", camelcase: false})
                    endif
                elseif (key == "\<C-h>" || key == "\<BS>")
                    if empty(prompt_text) && close_on_bs
                        popup_close(id, {idx: getcurpos(id)[1], key: key})
                        popup_close(pwinid)
                        RestoreCursor()
                        return true
                    endif
                    prompt_text = prompt_text->strcharpart(0, prompt_text->strchars() - 1)
                    if empty(prompt_text)
                        filtered_items = [items_dict]
                    else
                        filtered_items = items_dict->matchfuzzypos(prompt_text, {key: "text", camelcase: false})
                    endif
                elseif key =~ '\p'
                    prompt_text ..= key
                    filtered_items = items_dict->matchfuzzypos(prompt_text, {key: "text", camelcase: false})
                endif
                UpdatePopups(pwinid, id)
                AlignPopups(pwinid, id)
            endif
            return true
        },
        callback: (id, result) => {
            popup_close(pwinid)
            RestoreCursor()
            if result->type() == v:t_number
                if result > 0
                    Callback(filtered_items[0][result - 1], "")
                endif
            else
                Callback(filtered_items[0][result.idx - 1], result.key)
            endif
        }
    }))

    win_execute(winid, "setl cursorlineopt=both")
    UpdatePopups(pwinid, winid)
    AlignPopups(pwinid, winid)

    if Setup != null_function
        Setup(winid)
    endif
enddef

# Output shell command in a popup window.
export def Sh(command: string): tuple<number, job>
    var job_command: any
    if has("win32")
        job_command = command
    else
        job_command = [&shell, &shellcmdflag, escape(command, '\')]
    endif

    var winid = popup_create("Running ...", {
        title: $" {command} ",
        pos: 'botright',
        col: &columns,
        line: &lines,
        padding: [0, 1, 0, 1],
        border: [1, 1, 1, 1],
        mapping: 0,
        tabpage: -1,
        borderchars: popup_borderchars,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        filter: (winid, key) => {
            if key == "\<cursorhold>" || key == "\<ignore>"
                return true
            endif
            if key == "\<Space>"
                win_execute(winid, "normal! \<C-d>\<C-d>")
                return true
            elseif key == "j"
                win_execute(winid, "normal! \<C-d>")
                return true
            elseif key == "k"
                win_execute(winid, "normal! \<C-u>")
                return true
            elseif key == "g"
                win_execute(winid, "normal! gg")
                return true
            elseif key == "G"
                win_execute(winid, "normal! G")
                return true
            endif
            if key == "\<ESC>"
                popup_close(winid)
                return true
            endif
            return true
        }
    })

    var bufnr = getwininfo(winid)[0].bufnr
    var clean_buf = true

    var jobid = job_start(job_command, {
        out_msg: 0,
        out_io: 'buffer',
        out_cb: (ch, msg) => {
            if clean_buf
                silent deletebufline(bufnr, 1, '$')  # clear buffer
                clean_buf = false
            endif
        },
        out_buf: bufnr,
        err_msg: 0,
        err_io: 'buffer',
        err_buf: bufnr,
    })

    return (winid, jobid)
enddef
