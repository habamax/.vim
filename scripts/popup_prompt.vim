vim9script



# Show popup list, execute callback with a single parameter.
export def FilterMenu(items: list<string>, title: string, Callback: func(any))
    var prompt = ""
    var filtered_items = items
    var edit_id = popup_create($"{title}: │", {
        hidden: true,
        padding: [0, 1, 0, 1],
        mapping: 0,
    })
    var main_id = popup_create(items, {
        line: 10,
        col: 10,
        pos: 'topleft',
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
                popup_close(edit_id)
            elseif key == "\<cr>"
                popup_close(id, getcurpos(id)[1])
                popup_close(edit_id)
            elseif key == "\<tab>" || key == "\<C-n>"
                win_execute(id, "normal! j")
            elseif key == "\<S-tab>" || key == "\<C-p>"
                win_execute(id, "normal! k")
            elseif key == "\<C-U>"
                prompt = ""
                filtered_items = items
                popup_settext(id, filtered_items)
                popup_settext(edit_id, $"{title}: {prompt}")
            elseif key != "\<cursorhold>" && key =~ '\p'
                prompt ..= key
                filtered_items = items->matchfuzzy(prompt)
                popup_settext(id, filtered_items)
                popup_settext(edit_id, $"{title}: {prompt}")
            endif
            return true
        },
        callback: (id, result) => {
                if result > 0
                    Callback(filtered_items[result - 1])
                endif
            }
        })

        win_execute(main_id, "setl nu")

        var main_win = popup_getpos(main_id)
        popup_move(edit_id, {line: (main_win.line - 1), col: main_win.col})
        popup_setoptions(edit_id, {minwidth: main_win.core_width})
        popup_show(edit_id)
enddef

FilterMenu(["Однажды в студеную",
            "Зимнюю пору",
            "hello",
            "hello world",
            "world is on fire"], "Buffers", (res) => {
        echo res
    })

