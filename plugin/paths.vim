" path, tune it per filetype
set path=.,,src/**


" Swap & Backup & Undo
let &directory = expand('~/.vimdata/swap//')
let &backupdir = expand('~/.vimdata/backup//')
let &undodir = expand('~/.vimdata/undo//')
if !isdirectory(&undodir)   | call mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif

set backup
set undofile
