if exists("g:loaded_elixir_mix_test") || v:version < 700
	finish
endif
let g:loaded_elixir_mix_test = 1

fun! s:project_root()
	return fnamemodify(findfile("mix.exs", expand("%:p:h").";"), ":p:h")
endfu

fun! s:run_tests()
	let project_root = s:project_root()
	let current_buf = bufwinnr("%")

	"" I don't think I like preview window...
	" let test_buf = fnamemodify(project_root, ':t')." -- mix test output"
	" exe 'pedit '.test_buf
	" let bufnr = bufwinnr('^'.test_buf.'$')
	" exe bufnr."wincmd w"
	" setl buftype=nofile
	" setl bufhidden=delete
	" setl noswapfile
	" nnoremap <buffer> q <C-w>c

	let test_buf = fnamemodify(project_root, ':t')." -- mix test output"
	let bufnr = bufwinnr('^'.test_buf.'$')
	if bufnr == -1
		exe 'new '. test_buf
		setl buftype=nofile
		setl bufhidden=hide
		setl noswapfile

		" to be able to `gf` filenames like (mostly for Windows):
		"        lib/day5.ex:15: Day5 (module)
		setl isfname-=:

		nnoremap <buffer> q <C-w>c
		nnoremap <buffer> <CR> gF
		command! -buffer MixTestNext :call <sid>next_test('down')
		command! -buffer MixTestPrev :call <sid>next_test('up')
		nnoremap <buffer> <C-n> :MixTestNext<CR>
		nnoremap <buffer> <C-p> :MixTestPrev<CR>

		let b:mix_project_root = project_root
	else
		exe bufnr."wincmd w"
	endif

	" colorize it
	syn clear

	" Test heading
	syntax cluster MixTestTitleParts contains=MixTestTitleFront,MixTestTitleTail
	syntax match MixTestTitleFront /\v^\s+\d+\)\s((test|doctest)\s)?/ contains=MixTestTitleNum,MixTestTitleType containedin=@MixTestTitleParts
	syntax match MixTestTitle /\v^\s+\d+\)\s+.*$/ contains=@MixTestTitleParts
	syntax match MixTestTitleNum /\v\s+\d+\)\s*/ contained containedin=MixTestTitleFront
	syntax match MixTestTitleType /\v(test|doctest)/ contained containedin=MixTestTitleFront
	syntax match MixTestTitleTail /\v\s+\([^()]{-}\)$/ contained containedin=MixTestTitle
	syntax match MixTestTitleTail /\v\(\d+\)\s\([^()]{-}\)$/ contained containedin=MixTestTitle
	hi link MixTestTitle Title
	hi link MixTestTitleNum Statement
	hi link MixTestTitleType Type
	hi link MixTestTitleTail Comment

	syntax match MixTestAttr /\v^\s*\zs(code|left|right|stacktrace):/
	syntax match MixTestDoctestFailed /\v^\s*\zsDoctest failed/
	syntax match MixTestTestFailed /\v^\s*\zsAssertion with .* failed/
	syntax match MixTestFinished /\v^Finished in \d+\.\d+ seconds$/
	syntax match MixTestResults /\v^\d+ doctests, \d+ tests, \d+ failures$/
	syntax match MixTestRandomized /\v^Randomized with seed \d+$/
	syntax match MixTestComment /\v^# .*$/
	hi link MixTestAttr Special
	hi link MixTestDoctestFailed ErrorMsg
	hi link MixTestTestFailed ErrorMsg
	hi link MixTestResults Title
	hi link MixTestFinished Comment
	hi link MixTestRandomized Comment
	hi link MixTestComment Comment

	" make it async
	exe 'lcd '. project_root
	silent %!mix test

	call s:add_help()

	" scroll to bottom
	normal G

	" get back to the buffer we started tests from
	" exe current_buf."wincmd w"
endfu

fun! s:next_test(direction)
	if a:direction == 'down'
		let flags = 'W'
	else
		let flags = 'Wb'
	endif
	call search('\v^\s+\d+\)\s+(test|doctest)', flags)
endfu

fun! s:add_help()
	call append(0, "# ----")
	call append(1, "# <C-n> - jump to next test")
	call append(2, "# <C-p> - jump to previous test")
	call append(3, "# <CR>  - open file under cursor at specified line `lib/hello.ex:5`")
	call append(4, "# q     - close this window")
	call append(5, "# ----")
endfu

augroup MIX_TEST
	au!
	au BufRead,BufNewFile *.ex,*.exs call s:define_commands()
	au BufEnter *mix\ test\ output call s:set_project_root()
augroup end

fun! s:define_commands()
	command! -buffer MixTestRun :call <sid>run_tests()
endfu

fun! s:set_project_root ()
	if exists('b:mix_project_root')
		exe 'lcd '.b:mix_project_root
	endif
endfu

" put into .vim/after/ftplugin/elixir.vim
" nmap <leader>tt <Plug>(MixTestRun) 
nnoremap <Plug>(MixTestRun) :MixTestRun<CR>
