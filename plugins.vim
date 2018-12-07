" source <sfile>:h/minpac_list.vim
runtime minpac_list.vim

" Plugin settings

" Delimitmate {{{1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"

" Fugitive and Git-Gutter {{{1
if executable("git")
	nnoremap <leader>gs :Gstatus<CR>

	packadd vim-fugitive
	packadd vim-gitgutter
endif

" Neomake {{{1
if exists(":Neomake") == 2
	autocmd! BufWritePost * Neomake
	let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
	let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }
endif

" UltiSnips and Completor {{{1
if has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'

	packadd ultisnips

	" convenince command to list all snips available
	command! UltiSnips :call UltiSnips#ListSnippets()

	" Completor should NOT be opened automatically
	" tab to trigger snip → jump to next placeholder → open completion → next
	" completion or plain tab
	" " Completor and ultisnips to reuse TAB key
	" fun! Tab_Or_Complete() "{{{
	" 	call UltiSnips#ExpandSnippet()
	" 	if g:ulti_expand_res == 0
	" 		if pumvisible()
	" 			return "\<C-n>"
	" 		else
	" 			call UltiSnips#JumpForwards()
	" 			if g:ulti_jump_forwards_res == 0
	" 				" If completor is not open and we are in the middle of typing a word then
	" 				" `tab` opens completor menu.
	" 				let inp_str = strpart( getline('.'), col('.')-3, 2 )
	" 				if col('.')>1 && (inp_str =~ '^\w$' || inp_str =~ '\%(->\)\|\%(.\w\)\|\%(\w\.\)\|\%(./\)')
	" 					return "\<C-R>=completor#do('complete')\<CR>"
	" 				else
	" 					return "\<TAB>"
	" 				endif
	" 			endif
	" 		endif
	" 	endif
	" 	return ""
	" endf "}}}

	" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=Tab_Or_Complete()<cr>"

	" " should be together if auto trigger is off
	" let g:completor_complete_options = "menuone,preview"
	" let g:completor_min_chars = 1
	" let g:completor_auto_trigger = 0

" ----------------------------
"
	" Completor SHOULD BE opened automatically
	" Completor and ultisnips to reuse TAB key
	" tab to trigger snip → jump to next placeholder → next completion or
	" insert a plain tab char
	fun! Tab_Or_Complete() "{{{
		call UltiSnips#ExpandSnippet()
		if g:ulti_expand_res == 0
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				if pumvisible()
					return "\<C-n>"
				else
					return "\<TAB>"
				endif
			endif
		endif
		return ""
	endf "}}}

	au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=Tab_Or_Complete()<cr>"

	let g:completor_min_chars = 1
	let g:completor_auto_trigger = 1

" ----------------------------
"
	" if has('win32')
	" 	let g:completor_python_binary = expand("~/scoop/apps/python/current/python.exe")
	" endif

	packadd completor.vim

endif

" LeaderF or CtrlP {{{1
if has('python') || has('python3')
	let g:Lf_StlSeparator = { 'left': '', 'right': '' }
	let g:Lf_ShortcutF = '<leader>ff'
	let g:Lf_Shortcutb = '<leader>b'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_WorkingDirectoryMode = 'Af'
	let g:Lf_FollowLinks = 1
	let g:Lf_RootMarkers = ['.git', '.hg', '.svn', 'mix.exs']
	let g:Lf_CommandMap = {'<ESC>': ['<C-Space>', '<ESC>']}
	let g:Lf_NormalMap = {"File":   [["u", ':LeaderfFile ..<CR>']]}
    let g:Lf_PreviewResult = {'Colorscheme': 1}
	cabbrev lf LeaderfFile
	nnoremap <leader>f/ :Leaderf rg<CR>
	nnoremap <leader>/ :LeaderfLineAll<CR>
	nnoremap <leader>fh :LeaderfHelp<CR>
	nnoremap <leader>fm :LeaderfMru<CR>
	nnoremap <leader>fs :LeaderfSelf<CR>
	nnoremap <leader>fc :LeaderfColorscheme<CR>
	nnoremap <leader>fdd :LeaderfFile ~/docs<CR>
	" open .vim or .vimfiles or nvim config directory
	nnoremap <leader>fdv :exe ':LeaderfFile '.fnamemodify($MYVIMRC, ':p:h')<CR>
	packadd leaderF
else
	let g:ctrlp_map = ''
	nnoremap <leader>ff :CtrlPMixed<CR>
	nnoremap <leader>fp :CtrlPBookmarkDir<CR>
	nnoremap <leader>bb :CtrlPBuffer<CR>
	let g:ctrlp_key_loop = 1
	if executable('rg')
		let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
		let g:ctrlp_use_caching = 0
	elseif has("win32") || has("win64")
		let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
	endif
	packadd ctrlp.vim
endif

" Asciidoctor {{{1
" There will be asciidoctor plugin here
let g:asciidoctor_executable = 'asciidoctor'
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
let g:asciidoctor_css_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_css = 'haba-asciidoctor.css'
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'
let g:asciidoctor_pdf_executable = "ruby C:/Users/maksim.kim/projects/habamax-asciidoctor-pdf/bin/asciidoctor-pdf"
" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript']

fun! AsciidoctorMappings()
	nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
	nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
	nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
	nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
	nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
	nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
	nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
	nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
endfun
augroup asciidoctor
	au!
	au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END

" List Manipulation {{{1
let g:list_man_default_mappings = 1

" TitleCase {{{1
" use <leader>ttip to titlecase a paragraph
let g:titlecase_map_keys = 0
nmap <leader>tc <Plug>Titlecase
vmap <leader>tc <Plug>Titlecase
nmap <leader>tcc <Plug>TitlecaseLine

" EasyAlign {{{1
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-swap settings {{{1
let g:swap_no_default_key_mappings = 1
" text objects
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap g. <Plug>(swap-interactive)

" Goyo && Limelight {{{1
nnoremap yog :Goyo<CR>
autocmd! User GoyoEnter Limelight 
autocmd! User GoyoLeave Limelight!

" vim-skipit {{{1
imap <A-.> <Plug>(SkipItForward)
imap <A-,> <Plug>(SkipItBack)

" vim-gutentags {{{1
if executable("ctags")
	packadd vim-gutentags
endif

" vim-rest-console {{{1
let g:vrc_auto_format_response_enabled = 1
let b:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 1
let g:vrc_curl_opts = {
			\ '-sS': '',
			\ '-i': '',
			\ '--connect-timeout': 10,
			\}

" nerdtree {{{1
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <Leader>fe :NERDTreeToggle<CR>

" vim-mix-format {{{1
autocmd User MixFormatDiff diffthis | wincmd p | diffthis
