set nocompatible
language messages en_US.UTF-8
set runtimepath^=C:/Users/maksim.kim/vimfiles/pack/minpac/start/vim-clap/
syntax on
filetype plugin indent on
function! s:Profile() abort
   profile start ~/vim_profile.log
   profile func *
   profile file *
   set verbosefile=~/vim_verbose.log
   set verbose=9
endfunction

command! Profile call s:Profile()

command! ProfilePause profile pause | noautocmd wqa!
