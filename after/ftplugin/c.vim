vim9script

if exists(":CocInfo") == 2
    nnoremap <silent><buffer> K <scriptcmd>call CocActionAsync('definitionHover')<CR>
    nnoremap <silent><buffer> gd <cmd>call CocAction('jumpDefinition')<CR>
endif
