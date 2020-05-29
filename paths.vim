"" Swap & Backup & Undo
set path=.,,src/**,lib/**,docs/**

let &directory = expand('~/.vimdata/swap//')

set backup
let &backupdir = expand('~/.vimdata/backup//')

set undofile
let &undodir = expand('~/.vimdata/undo//')

if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

"" WSL vim should look for win home dir
"" $HOMEWIN should be defined
if exists("$HOMEWIN")
    let g:HOME= expand("$HOMEWIN")
else
    let g:HOME= expand('~')
endif
