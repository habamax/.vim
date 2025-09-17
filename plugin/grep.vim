vim9script

if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('ugrep')
    set grepprg=ugrep\ -RInk\ -j\ -u\ --tabs=1\ --ignore-files
    set grepformat=%f:%l:%c:%m,%f+%l+%c+%m,%-G%f\\\|%l\\\|%c\\\|%m
endif

def Grep(args: string): string
    return system($"{&grepprg} {expandcmd(args)}")
enddef

command -nargs=1 -bar Grep {
    cgetexpr Grep(<q-args>)
    setqflist([], 'a', {title: $"{&grepprg} {<q-args>}"})
}

command -nargs=1 -bar LGrep {
    lgetexpr Grep(<q-args>)
    setloclist(winnr(), [], 'a', {title: $"{&grepprg} {<q-args>}"})
}

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

command! -nargs=1 Rg :term rg <args>
command! -nargs=1 Ug :term ug <args>
cnoreabbrev <expr> rg  (getcmdtype() ==# ':' && getcmdline() ==# 'rg')  ? 'Rg'  : 'rg'
cnoreabbrev <expr> ug  (getcmdtype() ==# ':' && getcmdline() ==# 'ug')  ? 'Ug'  : 'ug'


augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr belowright cwindow
    autocmd QuickFixCmdPost lgetexpr belowright lwindow
augroup END
