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
" И, шествуя важно, в спокойствии чинном,
" Лошадку ведет под уздцы мужичок
" В больших сапогах, в полушубке овчинном,
" В больших рукавицах... а сам с ноготок!
"
" З3Э -- буква З, цифра 3, буква Э
" 1Il0OQB8 =-+:

set linespace=0

"" Iosevka (customized extended) is preferred
set guifont=Iosevka\ Habamax:h14
            \,JetBrains\ Mono\ NL:h14
            \,Consolas:h14
            \,Liberation\ Mono:h14

"" There are a lot of awesome fonts...
"" My favorite 3 after Iosevka
" set gfn=JetBrains\ Mono\ NL:h14
" set gfn=Consolas:h14
" set gfn=Liberation\ Mono:h14

set columns=999
set lines=999
