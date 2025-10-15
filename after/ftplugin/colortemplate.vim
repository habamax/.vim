vim9script

b:undo_ftplugin ..= ' | setl complete<'

setl omnifunc=s:HighlightCompletor

# TODO: complete
# - highlight groups as the first word or a link after ->
# - colortemplete keywords
# - /256/16/8/0 after highlight group or as a first thing on the line
# - reverse/bold/italic/underline as the fourth part of the highlight definition
# - none/omit as a second or third part of highlight definition
# - color names (would require scanning of the buffer)
# - Include: for files
# - Environments: for gui/256/16/8/0

def HighlightCompletor(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\k\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif

    var items = getcompletion('', 'highlight')
        ->mapnew((_, v) => ({word: v, kind: 'H', dup: 0}))
        ->matchfuzzy(base, {key: "word"})

    return items->empty() ? v:none : items
enddef

def Run()
    update
    Colortemplate!
    ColortemplateShow
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<CR>
