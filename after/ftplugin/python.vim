vim9script

if executable('black')
    &l:formatprg = "black -q - 2>/dev/null"
elseif executable('yapf')
    # pip install yapf
    &l:formatprg = "yapf"
endif

setlocal foldignore=

b:undo_ftplugin ..= ' | setl foldignore< formatprg<'

import autoload 'popup.vim'
def PopupHelp(symbol: string)
    popup.ShowAtCursor(systemlist("python -m pydoc " .. symbol), (winid) => {
        setbufvar(winbufnr(winid), "&ft", "rst")
    })
enddef

def RunPython()
    exe "Sh python" expand("%:p")
    win_gotoid(b:shout_initial_winid)
enddef

nnoremap <buffer> <F4> <scriptcmd>Shut<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F4>"'
nnoremap <buffer> <F5> <cmd>update<cr><scriptcmd>RunPython()<cr>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <F5>"'

if exists("g:loaded_lsp")
    import autoload 'lsp.vim'
    au User LspAttached lsp.SetupFT()
else
    nnoremap <silent><buffer> K <scriptcmd>PopupHelp(expand("<cfile>"))<CR>
    xnoremap <silent><buffer> K y<scriptcmd>PopupHelp(getreg('"'))<CR>
    b:undo_ftplugin ..= ' | exe "nunmap <buffer> K"'
    b:undo_ftplugin ..= ' | exe "xunmap <buffer> K"'
endif

def Things()
    var things = matchbufline(bufnr(),
        '\v(^\s*(def|class)\s+\k+.*$)|(if __name__ \=\= .*)',
        1, '$')->foreach((_, v) => {
            v.text = $"{v.text} ({v.lnum})"
        })
    popup.Select("Py Things", things,
        (res, key) => {
            exe $":{res.lnum}"
            normal! zz
        },
        (winid) => {
            win_execute(winid, "syn match PopupSelectLineNr '(\\d\\+)$'")
            win_execute(winid, "syn match PopupSelectFuncName '\\k\\+\\ze('")
            hi def link PopupSelectLineNr Comment
            hi def link PopupSelectFuncName Function
        })
enddef
nnoremap <buffer> <space>z <scriptcmd>Things()<CR>
b:undo_ftplugin ..= ' | exe "nunmap <buffer> <space>z"'
