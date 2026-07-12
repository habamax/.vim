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

    # update Last Change in vim files
    au BufWritePre *.vim {
        if &modifiable
            var view = winsaveview()
            try
                undojoin | exe $':1,{min([10, line('$')])}s/\v^[#"]\s+Last\s+(Change|Update):\s*\zs.*/\=strftime("%Y-%m-%d")/ie'
            catch /E790/
            endtry
            winrestview(view)
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
command! -nargs=? Search {
    if !empty(<q-args>)
        @/ = $'\V{escape(<q-args>, '\')}'
        feedkeys("n")
    endif
}
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

command! -nargs=* -complete=custom,cmdcomplete#Make TMake <mods> Term make <args>
command! -nargs=* -complete=custom,cmdcomplete#Make -bar Make {
    var cmd = $"{expandcmd(&makeprg)} {<q-args>}"
    cgetexpr system(cmd)
    setqflist([], 'a', {title: cmd})
    if !empty(getqflist())
        copen
    else
        cclose
    endif
    echo "Make is finished!"
}

command -nargs=_ -complete=customlist,cmdcomplete#Colorscheme Colorscheme colorscheme <args>

command -nargs=_ -complete=customlist,cmdcomplete#Help Help :help <args>

import autoload 'unicode.vim'
command! -nargs=_ -complete=customlist,cmdcomplete#Unicode Unicode unicode.Copy(<f-args>)

command -nargs=_ -complete=customlist,cmdcomplete#Buffer Buffer :b <args>
command -nargs=_ -complete=customlist,cmdcomplete#Buffer SBuffer {
    var mods = ""
    if winwidth(winnr()) * 0.3 > winheight(winnr())
        mods = "vert "
    endif
    exe $":{mods}sb {<q-args>}"
}

import autoload 'hlblink.vim'
command BlinkLine hlblink.Line()
