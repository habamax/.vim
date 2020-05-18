func! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

inorea haba@ habamax@gmail.com

inorea хъ []<Left><C-R>=Eatchar('\s')<CR>
inorea ХЪ {}<Left><C-R>=Eatchar('\s')<CR>
inorea ЭЭ ""<Left><C-R>=Eatchar('\s')<CR>
inorea ээ ''<Left><C-R>=Eatchar('\s')<CR>
inorea ёё ``<Left><C-R>=Eatchar('\s')<CR>

inorea <expr> dd strftime("%Y-%m-%d")
inorea <expr> ddt strftime("%Y-%m-%d %H:%M")
inorea <expr> вв strftime("%Y-%m-%d")
inorea <expr> вве strftime("%Y-%m-%d %H:%M")

inorea dolorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            \Maecenas feugiat fermentum pretium. Cras eu dolor imperdiet justo mattis
            \pulvinar. Cras nec lectus ligula. Proin elementum luctus elit, a tincidunt quam
            \facilisis non. Nunc quis mauris non turpis finibus luctus. Maecenas ante
            \sapien, sagittis quis accumsan in, feugiat quis sem. Praesent et auctor libero.


inorea ipsum Ut sed lacus id mauris mattis lobortis. Aliquam ut nisl eu neque viverra
            \pretium. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam
            \convallis, purus sit amet rutrum porttitor, enim ante dapibus libero, finibus
            \tempor tortor diam sed urna. Aliquam ullamcorper ligula sit amet consequat
            \faucibus. Donec in nisl tristique, porttitor eros eget, pellentesque orci. Nunc
            \porta dolor et fringilla auctor. Vestibulum ut dapibus eros. Nunc ac cursus
            \nisi, at vulputate dolor. Pellentesque habitant morbi tristique senectus et
            \netus et malesuada fames ac turpis egestas.

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
