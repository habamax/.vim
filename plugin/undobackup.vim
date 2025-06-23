vim9script

&directory = $'{$MYVIMDIR}.data/swap/'
&backupdir = $'{$MYVIMDIR}.data/backup//'
&undodir = $'{$MYVIMDIR}.data/undo//'
if !isdirectory(&undodir)   | mkdir(&undodir, "p")   | endif
if !isdirectory(&backupdir) | mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | mkdir(&directory, "p") | endif

set backup
set undofile
