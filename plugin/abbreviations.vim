inorea ddd <C-r>=strftime("%Y-%m-%d")<CR><C-R>=misc#Eatchar('\s')<CR>
inorea ddt <C-r>=strftime("%Y-%m-%d %H:%M")<CR><C-R>=misc#Eatchar('\s')<CR>

inorea ssf select * from
inorea whe where 1 = 1

def CmdReplace(cmd: string, ucmd: string): string
    return (getcmdtype() ==# ':' && getcmdline() ==# cmd) ? ucmd : cmd
enddef

cnoreabbrev <expr> grep CmdReplace('grep', 'Grep')
cnoreabbrev <expr> lgrep CmdReplace('lgrep', 'LGrep')
cnoreabbrev <expr> rg CmdReplace('rg', 'Rg')
cnoreabbrev <expr> ug CmdReplace('ug', 'Ug')
cnoreabbrev <expr> git CmdReplace('git', 'Git')
cnoreabbrev <expr> Qa CmdReplace('Qa', 'qa')
cnoreabbrev <expr> make CmdReplace('make', 'Make')
cnoreabbrev <expr> todo CmdReplace('todo', 'Todo')
cnoreabbrev <expr> term CmdReplace('term', 'Term')

cabbr ц w
cabbr й q
cabbr цй wq
cabbr ив bd

inorea -Ю ->
inorea -ю ->
inorea =Ю =>
inorea =ю =>

inorea :shrug: ¯\_(ツ)_/¯<C-R>=misc#Eatchar('\s')<CR>
inorea :cool: ( •_•) ( -_-)~⌐■-■ (⌐■_■)><C-R>=misc#Eatchar('\s')<CR>

inorea mxm Maxim Kim
inorea latex LaTeX
inorea adn and
inorea Adn And
inorea teh the
inorea Teh The
inorea tihs this
inorea Tihs This
inorea thsi this
inorea Thsi This
inorea taht that
inorea Taht That
inorea thta that
inorea Thta That
inorea htat that
inorea Htat That
inorea waht what
inorea Waht What
inorea whta what
inorea Whta What
inorea hwat what
inorea Hwat What
inorea wtih with
inorea Wtih With
inorea wthi with
inorea Wthi With
inorea wiht with
inorea Wiht With
inorea rigth right
inorea Rigth Right
inorea lenght length
inorea Lenght Length
inorea weigth weight
inorea Weigth Weight
inorea knwo know
inorea Knwo Know
inorea kwno know
inorea Kwno Know
inorea konw know
inorea Konw Know
inorea clena clean
inorea Clena Clean
inorea maek make
inorea Maek Make

inorea todo: TODO:
inorea ещвщЖ TODO:
inorea fixme: FIXME:
inorea ашчьу FIXME:
inorea xxx: XXX:
inorea чччЖ XXX:
inorea task: TASK:
inorea bug: BUG:

inorea wtf WTF
inorea smth something
inorea Smth Something
