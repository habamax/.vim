vim9script

# Returns winnr of created popup window
export def ShowAtCursor(text: any): number
    var winnr = popup_atcursor(CleanCR(text), {
            padding: [0, 1, 0, 1],
            border: [],
            borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
            pos: "botleft",
            filter: "PopupFilter",
            filtermode: 'n',
            mapping: 0
          })
    return winnr
enddef


def PopupFilter(winid: number, key: string): bool
    if key == "\<Space>"
        win_execute(winid, "normal! \<C-d>\<C-d>")
        return true
    endif
    if key == "j"
        win_execute(winid, "normal! \<C-d>")
        return true
    endif
    if key == "k"
        win_execute(winid, "normal! \<C-u>")
        return true
    endif
    if key == "\<ESC>"
        popup_close(winid)
        return true
    endif
    return true
enddef


def CleanCR(text: any): any
    if type(text) == v:t_string
        return trim(text, "\<CR>", 2)
    elseif type(text) == v:t_list
        return text->mapnew((_, v) => trim(v, "\<CR>", 2))
    endif
    return text
enddef



# Popup menu with fuzzy filtering
# Example usage 1:
# FilterMenu("Echo Text",
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
# FilterMenu("Buffers",
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
export def FilterMenu(title: string, items: list<any>, Callback: func(any, string))
    if len(items) < 1 | return | endif
    if empty(prop_type_get('FilterMenuMatch'))
        hi def link FilterMenuMatch Constant
        prop_type_add('FilterMenuMatch', {highlight: "FilterMenuMatch", override: true, priority: 1000, combine: true})
    endif
    var prompt = ""
    var hint = ">>> type to filter <<<"
    var items_dict: list<dict<any>>
    if items[0]->type() != v:t_dict
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
                    return {col: v.text->byteidx(c) + 1, length: 1, type: 'FilterMenuMatch'}
                })}
            })
        else
            return itemsAny[0]->mapnew((_, v) => {
                return {text: v.text}
            })
        endif
    enddef
    var winid = popup_create(Printify(filtered_items, []), {
        title: $" {title}: {hint} ",
        pos: 'center',
        border: [],
        borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
        drag: 0,
        wrap: 1,
        minwidth: (&columns * 0.6)->float2nr(),
        maxheight: (&lines * 0.8)->float2nr(),
        cursorline: false,
        padding: [0, 1, 0, 1],
        mapping: 0,
        filter: (id, key) => {
            if key == "\<esc>"
                popup_close(id, -1)
            elseif ["\<cr>", "\<C-j>", "\<C-v>", "\<C-t>"]->index(key) > -1
                    && filtered_items[0]->len() > 0
                popup_close(id, {idx: getcurpos(id)[1], key: key})
            elseif key == "\<tab>" || key == "\<C-n>"
                win_execute(id, "normal! j")
            elseif key == "\<S-tab>" || key == "\<C-p>"
                win_execute(id, "normal! k")
            elseif key != "\<cursorhold>" && key != "\<ignore>"
                if key == "\<C-U>" && !empty(prompt)
                    prompt = ""
                    filtered_items = [items_dict]
                elseif (key == "\<C-h>" || key == "\<bs>")
                    if empty(prompt) | return true | endif
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
                popup_settext(id, Printify(filtered_items, []))
                popup_setoptions(id, {title: $" {title}: {prompt ?? hint} "})
            endif
            return true
        },
        callback: (id, result) => {
                if result->type() == v:t_number
                    if result > 0
                        Callback(filtered_items[0][result - 1], "")
                    endif
                else
                    Callback(filtered_items[0][result.idx - 1], result.key)
                endif
            }
        })

    win_execute(winid, "setl nu cursorline cursorlineopt=both")
enddef
