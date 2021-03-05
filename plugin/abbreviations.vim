func! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

cabbr ц w
cabbr й q
cabbr цй wq
cabbr ив bd
cabbr sf Select file

inorea haba@ habamax@gmail.com

inorea хъ []<Left><C-R>=Eatchar('\s')<CR>
inorea ХЪ {}<Left><C-R>=Eatchar('\s')<CR>
inorea ЭЭ ""<Left><C-R>=Eatchar('\s')<CR>
inorea ээ ''<Left><C-R>=Eatchar('\s')<CR>
inorea ёё ``<Left><C-R>=Eatchar('\s')<CR>

inorea <expr> dd strftime("%Y-%m-%d")
inorea <expr> ll text#date_ru()
inorea <expr> дд text#date_ru()
inorea <expr> ddt strftime("%Y-%m-%d %H:%M")
inorea <expr> вв strftime("%Y-%m-%d")
inorea <expr> вве strftime("%Y-%m-%d %H:%M")

inorea -Ю ->
inorea -ю ->
inorea =Ю =>
inorea =ю =>

inorea teh the
inorea tihs this
inorea thsi this
inorea taht that
inorea thta that
inorea waht what
inorea whta what
inorea rigth right
inorea lenght length
inorea knwo know
inorea kwno know
inorea konw know
inorea clena clean

inorea todo: TODO:
inorea ещвщЖ TODO:
inorea fixme: FIXME:
inorea ашчьу FIXME:
inorea xxx: XXX:
inorea чччЖ XXX:

" Most useful for AsciiDoc but also good for others
inorea note: NOTE:
inorea тщеуЖ NOTE:
inorea warn: WARNING:
inorea цфктЖ WARNING:
inorea impo: IMPORTANT:
inorea шьзщЖ IMPORTANT:
inorea tip: TIP:
inorea ешзЖ TIP:
inorea cau: CAUTION:
inorea сфгЖ CAUTION:

inorea wtf WTF
inorea smth something
inorea Smth Something
