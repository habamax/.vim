vim9script


# Show popup list, execute callback with a single parameter.
export def FilterMenu(title: string, items: list<string>, Callback: func(any))
    var prompt = ""
    var filtered_items = items
    var hint = ">>> type to filter <<<"
    var winid = popup_create(items, {
        title: $"{title}: {hint}",
        pos: 'center',
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
            elseif key == "\<cr>" && filtered_items->len() > 0
                popup_close(id, getcurpos(id)[1])
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
                        filtered_items = items->matchfuzzy(prompt)
                    endif
                elseif key =~ '\p'
                    prompt ..= key
                    filtered_items = items->matchfuzzy(prompt)
                endif
                popup_settext(id, filtered_items)
                popup_setoptions(id, {title: $"{title}: {prompt ?? hint}"})
            endif
            return true
        },
        callback: (id, result) => {
                if result > 0
                    Callback(filtered_items[result - 1])
                endif
            }
        })

    win_execute(winid, "setl nu")

enddef

FilterMenu("Buffers", getbufinfo({'buflisted': 1})->mapnew((_, v) => v.name ?? '[No Name]'), (res) => {
    exe $":b {res}"
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
#             "world is on fire"], (res) => {
#         echo res
#     })

