
fun! s:project_root()
	return fnamemodify(findfile("mix.exs", expand("%:p:h").";"), ":p:h")
endfu

fun! s:run_tests()
	let project_root = s:project_root()
	let current_buf = bufwinnr("%")

	let test_buf = "mix test output"
	let bufnr = bufwinnr('^?'.test_buf.'?$')
	if bufnr == -1
		exe 'new '. '['.test_buf.']'
		setl buftype=nofile
		setl bufhidden=delete
		setl noswapfile
		set ft=mixtest
	else
		exe bufnr."wincmd w"
	endif

	" colorize it
	syn clear
	syntax match MixTestDots /\v^\.+$/
	syntax match MixTestAttr /\v^\s*\zs(code|left|right|stacktrace):/
	syntax match MixTestDoctestFailed /\v^\s*\zsDoctest failed/
	syntax match MixTestTitle /\v^\s+\d+\) .*$/
	syntax match MixTestFinished /\v^Finished in \d+\.\d+ seconds$/
	hi link MixTestDots Title
	hi link MixTestAttr Comment
	hi link MixTestDoctestFailed ErrorMsg
	hi link MixTestTitle Title
	hi link MixTestFinished Keyword

	" make it async
	exe 'lcd '. project_root
	silent %!mix test

	" get back to the buffer we started tests from
	exe current_buf."wincmd w"
endfu

command! -buffer MixRunTests :call <sid>run_tests()

" run tests
nnoremap <buffer> <leader>tt :MixRunTests<CR>

