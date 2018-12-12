
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
	hi link MixTestAttr Special
	hi link MixTestDoctestFailed ErrorMsg
	hi link MixTestTestFailed ErrorMsg
	hi link MixTestResults Title
	hi link MixTestFinished Comment
	hi link MixTestRandomized Comment

	" make it async
	exe 'lcd '. project_root
	silent %!mix test

	" get back to the buffer we started tests from
	exe current_buf."wincmd w"
endfu

command! -buffer MixRunTests :call <sid>run_tests()

" run tests
nnoremap <buffer> <leader>tt :MixRunTests<CR>

