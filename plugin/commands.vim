vim9script

augroup general | au!
    au Filetype * setl formatoptions=qjlron

    # goto last known position of the buffer
    au BufReadPost * {
        if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            exe 'normal! g`"'
        endif
    }

    # create non-existent directory before buffer save
    au BufWritePre * {
        if &modifiable && !isdirectory(expand("%:p:h"))
            mkdir(expand("%:p:h"), "p")
        endif
    }

    # save last session on exit if there is a buffer with name
    au VimLeavePre * {
        if reduce(getbufinfo({'buflisted': 1}), (a, v) => a || !empty(v.name), false)
            :exe $'mksession! {$MYVIMDIR}.data/sessions/LAST'
        endif
    }
augroup end

# Commands

# update packages
import autoload "pack.vim"
command! PackUpdate pack.Update()

# Wipe all hidden buffers
def WipeHiddenBuffers()
    var buffers = filter(getbufinfo(), (_, v) => empty(v.windows))
    if !empty(buffers)
        execute 'confirm bwipeout' join(mapnew(buffers, (_, v) => v.bufnr))
    endif
enddef
command! WipeHiddenBuffers WipeHiddenBuffers()

# literal search
command! -nargs=1 Search @/ = $'\V{escape(<q-args>, '\')}' | normal! n

# fix trailing spaces
command! FixTrailingSpaces {
    var v = winsaveview()
    keepj silent! :%s/\r\+$//g
    keepj silent! :%s/\v(\s+$)//g
    winrestview(v)
    echom 'Remove trailing spaces and ^Ms.'
}

import autoload "text.vim"
command! -range FixSpaces text.FixSpaces(<line1>, <line2>)

import autoload "share.vim"
command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)

command! CD lcd %:p:h
command! MD call mkdir(expand("%:p:h"), "p")

# syntax group names under cursor
command! Inspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

import autoload 'dist/json.vim'
# Echo formatted vim objects, e.g. :Echo getbufinfo()
command! -nargs=1 -complete=expression Echo redir @"> | echo json.Format(<args>) | redir END
# Add formatted vim objects to the current buffer, e.g. :EchoHere getbufinfo()
command! -nargs=1 -complete=expression EchoHere append(line('.'), json.Format(<args>)->split("\n"))

# write to a privileged file
if executable('sudo')
    command! W w !sudo tee "%" >/dev/null
endif

def Grep(args: string = "")
    var output = []
    if exists("b:grep_jobid") && job_status(b:grep_jobid) == 'run'
        echo "There is a grep job running."
        return
    endif
    setqflist([], ' ', {title: $"{&grepprg} {args}"})
    b:grep_jobid = job_start($"{&grepprg} {args} .", {
        cwd: getcwd(),
        out_cb: (_, msg) => {
            setqflist([], 'a', {lines: [msg]})
        },
        err_cb: (_, msg) => {
            setqflist([], 'a', {lines: [msg]})
        },
        exit_cb: (_, _) => {
            unlet b:grep_jobid
            echo "Grep is finished!"
            cwindow
        }
    })
enddef
command! -nargs=1 Grep Grep(<f-args>)

def MakeComplete(_, _, _): string
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef

def Make(args: string = "")
    var output = []
    if exists("b:make_jobid") && job_status(b:make_jobid) == 'run'
        echo "There is a make job running."
        return
    endif
    b:make_jobid = job_start($"{&makeprg} {args}", {
        cwd: getcwd(),
        out_cb: (_, msg) => output->add(msg),
        err_cb: (_, msg) => output->add(msg),
        exit_cb: (_, _) => {
            unlet b:make_jobid
            setqflist([], ' ', {title: $"{&makeprg} {args}", lines: output})
            echo "Make is finished!"
            cwindow
        }
    })
enddef
command! -nargs=* -complete=custom,MakeComplete Make Make(<f-args>)

command -nargs=1 -complete=custom,BufferComplete Buffer Buffer(<f-args>, false, <q-mods>)
command -nargs=1 -complete=custom,BufferComplete SBuffer Buffer(<f-args>, true, <q-mods>)
def Buffer(buf_info: string, split: bool = false, mods: string = "")
    var bufnr = buf_info->matchstr('^\s*\d\+')
    if empty(bufnr)
        return
    endif
    var guess_mods = ""
    if !empty(mods)
        guess_mods = mods
    elseif split && winwidth(winnr()) * 0.3 > winheight(winnr())
        guess_mods = "vert "
    endif
    exe $"{guess_mods} {split ? "s" : ""}buffer {bufnr}"
enddef
def BufferComplete(_, _, _): string
    var buffer_list = getbufinfo({'buflisted': 1})
        ->sort((i, j) => i.lastused > j.lastused ? -1 : i.lastused == j.lastused ? 0 : 1)
        ->mapnew((_, v) => printf($"%{bufnr("$")->len()}s %s %s", v.bufnr, v.changed ? "+" : " ", bufname(v.bufnr) ?? "[No Name]"))
    if buffer_list->len() > 1
        [buffer_list[0], buffer_list[1]] = [buffer_list[1], buffer_list[0]]
    endif
    return buffer_list->join("\n")
enddef

command -nargs=1 -complete=custom,ColorschemeComplete Colorscheme colorscheme <args>
def ColorschemeComplete(_, _, _): string
    var cur_colorscheme = get(g:, "colors_name", "default")
    var colors = [cur_colorscheme] + getcompletion('', 'color')->filter((_, v) => v != cur_colorscheme)
    return colors->join("\n")
enddef

command -nargs=1 -complete=custom,HelpComplete Help :help <args>
def HelpComplete(_, _, _): string
    var help_tags = globpath(&rtp, "doc/tags", 1, 1)
        ->mapnew((_, v) => readfile(v)->mapnew((_, line) => line->split("\t")[0]))
        ->flattennew()
    return help_tags->join("\n")
enddef

import autoload 'unicode.vim'
command! -nargs=1 -complete=custom,UnicodeComplete Unicode unicode.Copy(<f-args>)
def UnicodeComplete(_, _, _): string
    return unicode.Subset()
        ->mapnew((_, v) => $"{printf("%5S", printf("%04X", v.value))}  {printf("%3S", (nr2char(v.value, true) =~ '\p' ? nr2char(v.value, true) : " "))}    {v.name}")
        ->join("\n")
enddef
