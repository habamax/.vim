vim9script

var popup_borderchars     = get(g:, "popup_borderchars", ['─', '│', '─', '│', '┌', '┐', '┘', '└'])
var popup_borderchars_t   = get(g:, "popup_borderchars_t", ['─', '│', '─', '│', '├', '┤', '┘', '└'])
var popup_borderhighlight = get(g:, "popup_borderhighlight", [])
var popup_highlight       = get(g:, "popup_highlight", '')
var popup_cursor          = get(g:, "popup_cursor", '█')


# Helper popup to navigate quickfix/location lists.
# Usage:
# import autoload 'popup.vim'
# nnoremap <space>q <scriptcmd>popup.QfNavigate()<CR>
export def QfNavigate()
    var commands = [
        {key: "j", cmd: "cnext"},
        {key: "k", cmd: "cprev"},
        {key: "J", cmd: "clast"},
        {key: "K", cmd: "cfirst"},
        {text: "----------"},
        {key: ".", cmd: "lnext"},
        {key: ",", cmd: "lprev"},
        {key: ">", cmd: "llast"},
        {key: "<", cmd: "lfirst"},
    ]->foreach((_, v) => {
        if !v->has_key("text")
            v.text = $"{v.key} - {v.cmd}"
        endif
    })
    var winid = popup_create(commands, {
        pos: 'botright',
        col: &columns,
        line: &lines,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        scrollbar: false,
        cursorline: false,
        padding: [0, 1, 0, 1],
        mapping: 0,
        border: [1, 1, 1, 1],
        borderchars: popup_borderchars,
        filter: (winid, key) => {
            if key == "\<cursorhold>"
                return true
            endif
            var cmd_idx = commands->indexof((_, v) => get(v, "key", "") == key)
            if cmd_idx != -1
                try
                    exe $"redraw|{commands[cmd_idx].cmd}"
                catch
                endtry
            else
                popup_close(winid)
            endif
            return true
        }
    })
enddef

# Shows popup window at cursor position
export def ShowAtCursor(text: any, Setup: func(number) = null_function): number
    var new_text = text
    if text->type() == v:t_string
        new_text = text->trim("\<CR>")
    else
        new_text = text->mapnew((_, v) => v->trim("\<CR>"))
    endif
    var winid = popup_atcursor(new_text, {
        padding: [0, 1, 0, 1],
        border: [],
        borderchars: popup_borderchars,
        borderhighlight: popup_borderhighlight,
        highlight: popup_highlight,
        pos: "botleft",
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
        hi def link PopupSelectMatch Constant
        prop_type_add('PopupSelectMatch', {highlight: "PopupSelectMatch", override: true, priority: 1000, combine: true})
    endif
    var prompt = ""
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
    def Printify(itemsAny: list<any>, props: list<any>): list<any>
        if itemsAny[0]->len() == 0 | return [] | endif
        if itemsAny->len() > 1
            return itemsAny[0]->mapnew((idx, v) => {
                return {text: v.text, props: itemsAny[1][idx]->mapnew((_, c) => {
                    return {col: v.text->byteidx(c) + 1, length: 1, type: 'PopupSelectMatch'}
                })}
            })
        else
            return itemsAny[0]->mapnew((_, v) => {
                return {text: v.text}
            })
        endif
    enddef

    var maxwidth = (&columns * 0.9)->float2nr()
    var minwidth = max([min([70, maxwidth]), (&columns * 0.6)->float2nr()])
    var maxheight = &lines - 9
    var minheight = min([maxheight, max([items->len(), 10])])
    var pos_top = ((&lines - minheight) / 2) - 1
    var scrollbar_before_update = 0

    def AlignPopups(pwinid: number, winid: number)
        var width = popup_getpos(winid).core_width + (scrollbar_before_update - popup_getpos(winid).scrollbar)
        popup_move(winid, {
            minwidth: width,
            maxwidth: width
        })

        width = popup_getpos(winid).core_width + popup_getpos(winid).scrollbar
        popup_move(pwinid, {
            minwidth: width,
            maxwidth: width
        })
    enddef

    def UpdatePopups(pwinid: number, winid: number)
        var count_f = printf("%1$*2$.*3$d",
            items_count > 0 ? filtered_items[0]->len() : 0,
            0,
            items_count->string()->len())
        var count = $"{count_f}/{items_count}"
        if filtered_items[0]->empty()
            win_execute(winid, "if &l:nu | setl nonu nocul | endif")
        else
            win_execute(winid, "if !&l:nu | setl nu cul | endif")
        endif
        popup_setoptions(pwinid, {title: $" {title} ({count}) "})
        popup_settext(pwinid, $"> {prompt}{popup_cursor}")
        scrollbar_before_update = popup_getpos(winid).scrollbar
        popup_settext(winid, Printify(filtered_items, []))
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
    var winid = popup_create(Printify(filtered_items, []), popts->copy()->extend({
        border: [1, 1, 1, 1],
        borderchars: popup_borderchars_t,
        line: pos_top + 2,
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
            elseif key == "\<Right>"
                win_execute(id, 'normal! ' .. "\<C-d>")
            elseif key == "\<Left>"
                win_execute(id, 'normal! ' .. "\<C-u>")
            elseif key == "\<tab>" || key == "\<C-n>" || key == "\<Down>" || key == "\<ScrollWheelDown>"
                var ln = getcurpos(id)[1]
                win_execute(id, "normal! j")
                if ln == getcurpos(id)[1]
                    win_execute(id, "normal! gg")
                endif
            elseif key == "\<S-tab>" || key == "\<C-p>" || key == "\<Up>" || key == "\<ScrollWheelUp>"
                var ln = getcurpos(id)[1]
                win_execute(id, "normal! k")
                if ln == getcurpos(id)[1]
                    win_execute(id, "normal! G")
                endif
            # Ignoring fancy events and double clicks, which are 6 char long: `<80><fc> <80><fd>.`
            elseif ignore_input->index(key) == -1 && strcharlen(key) != 6 && str2list(key) != ignore_input_wtf
                if key == "\<C-U>"
                    prompt = ""
                    filtered_items = [items_dict]
                elseif (key == "\<C-h>" || key == "\<bs>")
                    if empty(prompt) && close_on_bs
                        popup_close(id, {idx: getcurpos(id)[1], key: key})
                        popup_close(pwinid)
                        RestoreCursor()
                        return true
                    endif
                    prompt = prompt->strcharpart(0, prompt->strchars() - 1)
                    if empty(prompt)
                        filtered_items = [items_dict]
                    else
                        filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
                    endif
                elseif key =~ '\p'
                    prompt ..= key
                    filtered_items = items_dict->matchfuzzypos(prompt, {key: "text"})
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
