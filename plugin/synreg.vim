vim9script
finish

def SynInclude(syn: string, start: number, end: number)
    unlet b:current_syntax
    exe 'syn include @SyntaxInclude_' .. syn .. ' syntax/' .. syn .. '.vim'
    exe 'syn region SyntaxCodeBlock_' .. syn
          \ .. ' start=#\%' .. start .. 'l#'
          \ .. ' end=#\%' .. end .. 'l#'
          \ .. ' keepend'
          \ .. ' contains=@NoSpell,@SyntaxInclude_' .. syn
enddef

xnoremap <space>s :<C-u>call <SID>SynInclude('sql', line("'<"), line("'>"))<CR>
