" list-man.vim -- Manipulate lists
" Maintainer:   Maxim Kim <habamax@gmail.com>

if exists("g:loaded_list_man") || &cp || v:version < 700
	finish
endif
let g:loaded_list_man = 1

" next regex is for numbered lists too but not sure if it makes sense
" let s:rx_bullets = '^\(\%(\s*[-*.]\+\s*\)\|\%(\s*\d\+\.\s*\)\)'
let s:rx_bullets = '^\(\s*[-*]\+\s*\)'
let s:rx_empty_checkbox = '\(\s*\[ \?\]\+\s*\)'
let s:rx_marked_checkbox = '\(\s*\[[Xx]\]\+\s*\)'

fun! s:toggle_checkbox(line)
	let line = getline(a:line)
	if line =~ s:rx_bullets && line !~ s:rx_bullets.s:rx_empty_checkbox.'\|'.s:rx_marked_checkbox
		exe a:line.'s/'.s:rx_bullets.'/\1\[ \] /'
	elseif line =~ s:rx_bullets.s:rx_empty_checkbox
		exe a:line.'s/'.s:rx_bullets.s:rx_empty_checkbox.'/\1\[x\] /'
	elseif line =~ s:rx_bullets.s:rx_marked_checkbox
		exe a:line.'s/'.s:rx_bullets.s:rx_marked_checkbox.'/\1\[ \] /'
	endif
endfu

fun! s:toggle_checkboxes(line1, line2)
	for line in range(a:line1, a:line2)
		call s:toggle_checkbox(line)
	endfor
endfu

command! -range ListManToggleCheckbox :call <sid>toggle_checkboxes(<line1>,<line2>)
nnoremap <Plug>(ListManToggleCheckbox) :ListManToggleCheckbox<CR>
vnoremap <Plug>(ListManToggleCheckbox) :ListManToggleCheckbox<CR>
xnoremap <Plug>(ListManToggleCheckbox) :ListManToggleCheckbox<CR>

" operator pending...
fu! s:op_toggle_checkboxes(...)
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
		return 'g@'
	endif
	let sel_save = &selection
	let &selection = "inclusive"
	let clipboard_save = &clipboard
	let &clipboard = ""

	if a:1 == 'char'	" Invoked from Visual mode, use gv command.
		silent exe "normal! gvy"
	elseif a:1 == 'line'
		silent exe "normal! '[V']y"
	else
		silent exe "normal! `[v`]y"
	endif

	:'<,'>ListManToggleCheckbox

	let &selection = sel_save
	let &clipboard = clipboard_save
endfu

xnoremap <expr> <Plug>(ListManToggleCheckboxOp) <sid>op_toggle_checkboxes()
nnoremap <expr> <Plug>(ListManToggleCheckboxOp) <sid>op_toggle_checkboxes()
nnoremap <expr> <Plug>(ListManToggleCheckboxLineOp) <sid>op_toggle_checkboxes() . '_'



if exists("g:list_man_default_mappings") && g:list_man_default_mappings == 1
	if !hasmapto('<Plug>(ListManToggleCheckboxOp)') && maparg('<leader>x','n') ==# ''
		xmap <leader>x  <Plug>(ListManToggleCheckboxOp)
		nmap <leader>x  <Plug>(ListManToggleCheckboxOp)
		omap <leader>x  <Plug>(ListManToggleCheckboxOp)
		nmap <leader>xx <Plug>(ListManToggleCheckboxLineOp)
	endif

	" if !hasmapto('<Plug>(ListManToggleCheckbox)') && maparg('<leader>x','n') ==# ''
	" 	xmap <leader>x <Plug>(ListManToggleCheckbox)
	" 	vmap <leader>x <Plug>(ListManToggleCheckbox)
	" 	nmap <leader>x <Plug>(ListManToggleCheckbox)
	" endif
endif
