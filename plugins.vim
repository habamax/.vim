source <sfile>:h/minpac_list.vim

" Plugin settings

" delimitmate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
let delimitMate_matchpairs = "(:),[:],{:}"

" fugitive
nnoremap <leader>gs :Gstatus<CR>
" nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>
" nnoremap <leader>gl :Glog<CR>

" Neomake
if exists(":Neomake") == 2
	autocmd! BufWritePost * Neomake
	let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
	let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }
endif

" UltiSnips and Completor {{{
if has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<C-j>'
	let g:UltiSnipsJumpForwardTrigger = '<C-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

	let g:UltiSnipsSnippetsDir=fnamemodify($MYVIMRC, ":p:h")."/snips"
	let g:UltiSnipsSnippetDirectories=["snips", "UltiSnips"]
	packadd ultisnips
	packadd vim-snippets
	packadd completor.vim
endif
"}}}

" LeaderF or CtrlP {{{
if has('python') || has('python3')
	let g:Lf_StlSeparator = { 'left': '', 'right': '' }
	let g:Lf_ShortcutF = '<leader>ff'
	let g:Lf_Shortcutb = '<leader>b'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_WorkingDirectoryMode = 'Af'
	let g:Lf_FollowLinks = 1
	let g:Lf_CommandMap = {'<ESC>': ['<C-Space>', '<ESC>']}
	let g:Lf_NormalMap = {
			\ "File":   [["u", ':LeaderfFile ..<CR>']]
			\}
	cabbrev lf LeaderfFile
	nnoremap <leader>fh :LeaderfHelp<CR>
	nnoremap <leader>fm :LeaderfMru<CR>
	nnoremap <leader>fs :LeaderfSelf<CR>
	nnoremap <leader>fc :LeaderfColorscheme<CR>
	nnoremap <leader>/ :LeaderfLine<CR>
	nnoremap <leader>fdd :LeaderfFile ~/docs<CR>
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
"}}}

" Completor {{{
" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.
" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
	" If completor is already open the `tab` cycles through suggested completions.
	if pumvisible()
		return "\<C-N>"
		" If completor is not open and we are in the middle of typing a word then
		" `tab` opens completor menu.
	elseif col('.')>1 && strpart( getline('.'), col('.')-3, 2 ) =~ '\%(->\)\|\%(.\w\)\|\%(.\.\)'
		return "\<C-R>=completor#do('complete')\<CR>"
	else
		" If we aren't typing a word and we press `tab` simply do the normal `tab`
		" action.
		return "\<Tab>"
	endif
endfunction


" " Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()
if has('win32')
	let g:completor_python_binary = expand("~/scoop/apps/python/current/python.exe")
endif
"}}}

" Asciidoctor {{{
" There will be asciidoctor plugin here
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'
let g:asciidoctor_pdf_executable = "ruby C:/Users/maksim.kim/projects/habamax-asciidoctor-pdf/bin/asciidoctor-pdf"
" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = "gm convert clipboard: "

let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fold_blocks = 1

fun! AsciidoctorMappings()
	nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
	nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
	nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
	nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
	nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
	nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
	nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
endfun
augroup asciidoctor
	au!
	au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END
" }}}

" I need a separate plugin for list manipulation...
fun! ListToggleCheckBox()
	let rx_bullets = '^\(\s*[-*]\+\s*\)'
	let rx_empty_checkbox = '\(\s*\[ \?\]\+\s*\)'
	let rx_marked_checkbox = '\(\s*\[[Xx]\]\+\s*\)'
	let line = getline('.')
	if line =~ rx_bullets && line !~ rx_bullets.rx_empty_checkbox.'\|'.rx_marked_checkbox
		exe ':s/'.rx_bullets.'/\1\[ \] /'
	elseif line =~ rx_bullets.rx_empty_checkbox
		exe ':s/'.rx_bullets.rx_empty_checkbox.'/\1\[x\] /'
	elseif line =~ rx_bullets.rx_marked_checkbox
		exe ':s/'.rx_bullets.rx_marked_checkbox.'/\1\[ \] /'
	endif
endfun

command! ListToggleCheckBox :call ListToggleCheckBox()

nnoremap <leader>x :ListToggleCheckBox<CR>

" checking the water
fun! AsciidoctorPasteImage()
	let fname = "C:/Users/maksim.kim/docs/images/test_image.png"
	" exe ":!gm convert clipboard: ".fname
	let job = job_start(g:asciidoctor_img_paste_command.fname)
	exe "normal iimage::".fnamemodify(fname, ":t")."[]\<ESC>"
endfun
"}}}

" use <leader>ttip to titlecase a paragraph
let g:titlecase_map_keys = 0
nmap <leader>tc <Plug>Titlecase
vmap <leader>tc <Plug>Titlecase
nmap <leader>tcc <Plug>TitlecaseLine

" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-sexp
let g:sexp_enable_insert_mode_mappings = 0


" ariline
" let g:airline_theme = "github"
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#tabline#enabled = 1

" NERDTree
" let g:NERDTreeDirArrowExpandable = '▶'
" let g:NERDTreeDirArrowCollapsible = '▼'
nnoremap <leader>ft :NERDTreeToggle<CR>
