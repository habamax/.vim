if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" Keymap внутренняя раскладка + langmap
if has('osx')
    set keymap=russian-jcukenmac
    set langmap=йцукенгшщзхъ;qwertyuiop[]
    set langmap+=фывапролджэё;asdfghjkl\\;'\\\
    set langmap+=ячсмитьбю;zxcvbnm\\,.
    set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
    set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\|
    set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
    set langmap+=№#
else
    set keymap=russian-jcukenwin
    set langmap=йцукенгшщзхъ;qwertyuiop[]
    set langmap+=фывапролджэё;asdfghjkl\\;'\\\
    set langmap+=ячсмитьбю;zxcvbnm\\,.
    set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
    set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\~
    set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
    set langmap+=№#
    " breaks english .
    " set langmap+=./
endif
set iminsert=0
set imsearch=-1
