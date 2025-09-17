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

command! -nargs=1 Rg :term rg <args>
command! -nargs=1 Ug :term ug <args>

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr belowright cwindow
    autocmd QuickFixCmdPost lgetexpr belowright lwindow
augroup END
