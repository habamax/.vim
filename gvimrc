""" Mac {{{1
if has("gui_macvim")
	set macmeta
	let macvim_skip_colorscheme = 1
endif

""" Fonts {{{1
"
" Однажды, в студеную зимнюю пору,
" Я из лесу вышел; был сильный мороз.
" Гляжу, поднимается медленно в гору
" Лошадка, везущая хворосту воз.
"
" И, шествуюя важно, в спокойствии чинном,
" Лошадку ведет под уздцы мужичок
" В больших сапогах, в полушубке овчинном,
" В больших рукавицах... а сам с ноготок!
"
" З3Э -- буква З, цифра 3, буква Э
" 1Il0OQB8 =-+:
"
set linespace=0
" Random font, because why not? :)
let s:fonts = ["Iosevka\\ Habamax\\ Extended:h14", "JetBrains\\ Mono:h13"]
exe "set gfn=".s:fonts[rand()%len(s:fonts)]

" set gfn=Iosevka\ Habamax\ Extended:h14
" set gfn=JetBrains\ Mono:h13
" set gfn=Iosevka\ Habamax:h14
" set gfn=Iosevka:h14
" set gfn=Hack:h14
" set gfn=Consolas:h14
" set gfn=Cascadia\ Code:h14
" set gfn=Fira\ Mono:h14
" set gfn=PT\ Mono:h14

set columns=400
set lines=400
