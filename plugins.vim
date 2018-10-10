runtime minpac_list.vim
" runtime vimplug_list.vim

" Plugin settings {{{1

let g:ragtag_global_maps = 1

" surround with q
let g:surround_113 = "«\r»"

" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gl :Glog<CR>

" Neomake
if exists(":Neomake") == 2
	autocmd! BufWritePost * Neomake
	let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
	let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }
endif

" " GitGutterasync doesn't work for my windows box
" if has("win32")
" 	let g:gitgutter_async = 1
" endif

" CtrlP{{{
let g:ctrlp_map = ''
nnoremap <leader>ff :CtrlPMixed<CR>
nnoremap <leader>bb :CtrlPBuffer<CR>
let g:ctrlp_key_loop = 1
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
	let g:ctrlp_use_caching = 0
elseif has("win32") || has("win64")
	let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
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


" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 1
inoremap <expr> <Tab> Tab_Or_Complete()
if has('win32')
	let g:completor_python_binary = expand("~/scoop/apps/python/current/python.exe")
endif
"}}}

") Asciidoctor {{{
" There will be asciidoctor plugin here
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'
"}}}

" use <leader>ttip to titlecase a paragraph
let g:titlecase_map_keys = 0
nmap <leader>tt <Plug>Titlecase
vmap <leader>tt <Plug>Titlecase
nmap <leader>tT <Plug>TitlecaseLine

" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-sexp
let g:sexp_enable_insert_mode_mappings = 0
