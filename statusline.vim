func! StatusGitBranch()
	if exists('*fugitive#head')
		return fugitive#head()
	endif
	return ''
endfunc
func! StatusFiletype()
	return &filetype
endfunc
func! StatusWindowNr()
	if winnr('$') > 1
		return '{'.winnr().'}'
	else
		return ''
	endif
endfunc

set laststatus=2
" set ruler " for default statusline"
set statusline=%{StatusWindowNr()} 
set statusline+=%([\%R%M]\ %)
set statusline+=%<%f
set statusline+=%(\ %y%)
set statusline+=%=
set statusline+=%([git:%{StatusGitBranch()}]%)
set statusline+=%4(%p%%%)
