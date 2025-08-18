vim9script

var templates_cache: list<string> = []
export def CompleteReset()
    templates_cache = []
enddef

def TemplateComplete(_, _, _): string
    var path = $"{$MYVIMDIR}templates/"
    var ft = getbufvar(bufnr(), '&filetype')
    var ft_path = path .. ft

    if empty(templates_cache)
        if !empty(ft) && isdirectory(ft_path)
            templates_cache = mapnew(readdirex(ft_path, (e) => e.type == 'file'), (_, v) => $"{ft}/{v.name}")
        endif
        if isdirectory(path)
            extend(templates_cache, mapnew(readdirex(path, (e) => e.type == 'file'), (_, v) => v.name))
        endif
    endif

    return templates_cache->join("\n")
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
command! -nargs=1 -complete=custom,TemplateComplete InsertTemplate InsertTemplate(<f-args>)
