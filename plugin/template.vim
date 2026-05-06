vim9script

var templates_cache: list<dict<any>> = []
augroup CmdCompleteResetTemplate
    au!
    au CmdlineEnter : templates_cache = []
augroup END

def TemplateComplete(arg: string, _, _): list<dict<any>>
    var path = $"{$MYVIMDIR}templates/"
    var ft = getbufvar(bufnr(), '&filetype')
    var ft_path = path .. ft

    if empty(templates_cache)
        if !empty(ft) && isdirectory(ft_path)
            templates_cache = mapnew(readdirex(ft_path, (e) => e.type == 'file'), (_, v) => {
                return {
                    word: $"{ft}/{v.name}",
                    abbr: v.name,
                    kind: ft,
                    info: readfile($"{ft_path}/{v.name}")->join("\n")}
            })
        endif
        if isdirectory(path)
            extend(templates_cache, mapnew(readdirex(path, (e) => e.type == 'file'), (_, v) => {
                return {word: $"{v.name}", info: readfile($"{path}/{v.name}")->join("\n")}
            }))
        endif
    endif

    if empty(arg)
        return templates_cache
    else
        return templates_cache->matchfuzzy(arg, {key: "word"})
    endif
enddef

def InsertTemplate(template: string)
    if &l:readonly
        echo "Buffer is read-only!"
        return
    endif
    var template_path = $"{$MYVIMDIR}templates/{template}"
    if !filereadable(template_path)
        echo $"Can't read {template_path}"
        return
    endif
    append(line('.'), readfile($"{template_path}")->mapnew((_, v) => {
        return v->substitute('!!\(.\{-}\)!!', '\=eval(submatch(1))', 'g')
    }))
    if getline('.') =~ '^\s*$'
        del _
    else
        normal! j^
    endif
enddef
command! -nargs=1 -complete=customlist,TemplateComplete InsertTemplate InsertTemplate(<f-args>)
