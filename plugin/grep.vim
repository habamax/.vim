vim9script

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
endif

command -nargs=1 -bar Grep {
    var cmd = $"{&grepprg} {expandcmd(<q-args>)}"
    cgetexpr system(cmd)
    setqflist([], 'a', {title: cmd})
}

command -nargs=1 -bar LGrep {
    var cmd = $"{&grepprg} {expandcmd(<q-args>)}"
    lgetexpr system(cmd)
    setloclist(winnr(), [], 'a', {title: cmd})
}

command! -nargs=1 -complete=file Rg :term rg <args>
command! -nargs=1 -complete=file Ug :term ug <args>

if has("win32")
    command! Todo :LGrep "\\(TODO:\\|FIXME:\\|NOTE:\\|BUG:\\|HACK:\\|XXX:\\)"
else
    command! Todo :LGrep '\(TODO:\|FIXME:\|NOTE:\|BUG:\|HACK:\|XXX:\)'
endif

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr belowright cwindow
    autocmd QuickFixCmdPost lgetexpr belowright lwindow
augroup END
