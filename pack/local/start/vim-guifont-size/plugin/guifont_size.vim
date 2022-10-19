"" change-font-size.vim - Change GUI vim font size
"" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("g:loaded_guifont_size") || !has("gui_running")
    finish
endif

let g:loaded_guifont_size = 1


nnoremap <silent> <Plug>(GUIFontSizeInc) :call guifont_size#Change('inc')<CR>
nnoremap <silent> <Plug>(GUIFontSizeDec) :call guifont_size#Change('dec')<CR>
nnoremap <silent> <Plug>(GUIFontSizeRestore) :call guifont_size#Change('restore')<CR>
