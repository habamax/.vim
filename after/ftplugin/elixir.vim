
fun! s:project_root()
	let path = fnamemodify(findfile("mix.exs", expand("%:p:h").";"), ":p:h")
	exe 'lcd '. path
endfu

fun! s:run_tests()
	call s:project_root()

	let current_buf = bufwinnr("%")

	let test_buf = "mix test output"
	let bufnr = bufwinnr('^?'.test_buf.'?$')
	if bufnr == -1
		exe 'new '. '['.test_buf.']'
		setl buftype=nofile
		setl bufhidden=delete
		setl noswapfile
	else
		exe bufnr."wincmd w"
	endif

	" make it async
	%!mix test

	" get back to the buffer we started tests from
	exe current_buf."wincmd w"
endfu

command! -buffer MixRunTests :call <sid>run_tests()

" run tests
nnoremap <buffer> <leader>tt :MixRunTests<CR>

