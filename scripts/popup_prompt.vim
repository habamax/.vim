vim9script


# Show popup list, execute callback with a single parameter.
export def FilterMenu(title: string, items: list<any>, Callback: func(any, string))
    var prompt = ""
    var hint = ">>> type to filter <<<"
    var filtered_items: list<any> = items
    def Printify(itemsAny: list<any>): list<string>
        if itemsAny->len() == 0 | return [] | endif
        if itemsAny[0]->type() == v:t_string | return itemsAny | endif
        return itemsAny->mapnew((_, v) => v.name)
    enddef
    var winid = popup_create(Printify(items), {
        title: $" {title}: {hint} ",
        pos: 'center',
        border: [],
        borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
        drag: 0,
        wrap: 0,
        minwidth: (&columns * 0.6)->float2nr(),
        maxheight: (&lines * 0.8)->float2nr(),
        cursorline: 1,
        padding: [0, 1, 0, 1],
        mapping: 0,
        filter: (id, key) => {
            if key == "\<esc>"
                popup_close(id, -1)
            elseif ["\<cr>", "\<C-j>", "\<C-v>", "\<C-t>"]->index(key) > -1
                    && filtered_items->len() > 0
                popup_close(id, {idx: getcurpos(id)[1], key: key})
            elseif key == "\<tab>" || key == "\<C-n>"
                win_execute(id, "normal! j")
            elseif key == "\<S-tab>" || key == "\<C-p>"
                win_execute(id, "normal! k")
            elseif key != "\<cursorhold>"
                if key == "\<C-U>" && !empty(prompt)
                    prompt = ""
                    filtered_items = items
                elseif (key == "\<C-h>" || key == "\<bs>")
                    if empty(prompt) | return true | endif
                    prompt = prompt->strcharpart(0, prompt->strchars() - 1)
                    if empty(prompt)
                        filtered_items = items
                    else
                        filtered_items = items->matchfuzzy(prompt, {key: "name"})
                    endif
                elseif key =~ '\p'
                    prompt ..= key
                    filtered_items = items->matchfuzzy(prompt, {key: "name"})
                endif
                popup_settext(id, Printify(filtered_items))
                popup_setoptions(id, {title: $" {title}: {prompt ?? hint} "})
            endif
            return true
        },
        callback: (id, result) => {
                if result->type() == v:t_number
                    if result > 0
                        Callback(filtered_items[result - 1], "")
                    endif
                else
                    Callback(filtered_items[result.idx - 1], result.key)
                endif
            }
        })

    win_execute(winid, "setl nu")
enddef


FilterMenu("Buffers",
        getbufinfo({'buflisted': 1})->mapnew((_, v) => {
                return {bufnr: v.bufnr, name: (v.name ?? $'[{v.bufnr}: No Name]')}
            }),
        (res, key) => {
            if key == "\<c-t>"
                exe $":tab sb {res.bufnr}"
            elseif key == "\<c-j>"
                exe $":sb {res.bufnr}"
            elseif key == "\<c-v>"
                exe $":vert sb {res.bufnr}"
            else
                exe $":b {res.bufnr}"
            endif
        })

# FilterMenu("Buffers",
#            ["Однажды в студеную",
#             "He was aware there were numerous wonders of this world including the",
#             "unexplained creations of humankind that showed the wonder of our",
#             "ingenuity. There are huge heads on Easter Island. There are the",
#             "Egyptian pyramids. There's Stonehenge. But he now stood in front of a",
#             "newly discovered monument that simply didn't make any sense and he",
#             "wondered how he was ever going to be able to explain it.",
#             "The trees, therefore, must be such old and primitive techniques that",
#             "they thought nothing of them, deeming them so inconsequential that even",
#             "savages like us would know of them and not be suspicious. At that, they",
#             "probably didn't have too much time after they detected us orbiting and",
#             "intending to land. And if that were true, there could be only one place",
#             "where their civilization was hidden.",
#             "The wave crashed and hit the sandcastle head-on. The sandcastle began",
#             "to melt under the waves force and as the wave receded, half the",
#             "sandcastle was gone. The next wave hit, not quite as strong, but still",
#             "managed to cover the remains of the sandcastle and take more of it",
#             "away. The third wave, a big one, crashed over the sandcastle completely",
#             "covering and engulfing it. When it receded, there was no trace the",
#             "sandcastle ever existed and hours of hard work disappeared forever.",
#             "world is on fire"], (res, key) => {
#         echo res
#     })

