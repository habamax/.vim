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
command! -nargs=1 Occur exe $'lvim /\V{escape(<q-args>, '\')}/j %' | belowright lopen

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

def Make(...args: list<string>)
    if exists("g:make_jobid") && job_status(g:make_jobid) == 'run'
        echo "There is a make job running."
        return
    endif
    var makeprg = $"{&l:makeprg ?? &makeprg} {args->join()}"
    var qf_opened = false
    setqflist([], ' ', {title: makeprg})
    g:make_jobid = job_start(makeprg, {
        cwd: getcwd(),
        out_cb: (_, msg) => {
            if !qf_opened
                qf_opened = true
                belowright copen
            endif
            setqflist([], 'a', {lines: [msg]})
        },
        err_cb: (_, msg) => {
            if !qf_opened
                qf_opened = true
                belowright copen
            endif
            setqflist([], 'a', {lines: [msg]})
        },
        close_cb: (_) => {
            echo "Make is finished!"
        }
    })
    if job_status(g:make_jobid) != "run"
        echom $"FAILED: {makeprg} {args}"
    endif

enddef

def MakeComplete(_, _, _): string
    return system("make -npq : 2> /dev/null | awk -v RS= -F: '$1 ~ /^[^#%.]+$/ { print $1 }' | sort -u")
enddef

command! -nargs=* -complete=custom,MakeComplete Make Term make <args>

import autoload 'terminal.vim'
command! -nargs=1 Term terminal.Run(<f-args>)

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
        ->mapnew((_, v) => {
            return printf("%5S", printf("%04X", v.value))
                .. "  "
                .. printf("%3S", (nr2char(v.value, true) =~ '\p' ? nr2char(v.value, true) : " "))
                .. "    " .. v.name
        })->join("\n")
enddef

import autoload 'hlblink.vim'
command BlinkLine hlblink.Line()
