" Use minpac to utilize standard vim package stuff + git
" First of all minpac should be installed (windows):
" cd /d %USERPROFILE%
" git clone https://github.com/k-takata/minpac.git vimfiles\pack\minpac\opt\minpac
packadd minpac

if !exists('*minpac#init')
	finish
endif


call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

command! PackUpdate packadd minpac | runtime plugins.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | runtime plugins.vim | call minpac#clean()
command! PackStatus packadd minpac | runtime plugins.vim | call minpac#status()

" Tim Pope is a beast. You better use his stuff ... {{{1
call minpac#add('tpope/vim-surround')
" surround with q
let g:surround_113 = "«\r»"

" XML and HTML stuff
call minpac#add('tpope/vim-ragtag')
let g:ragtag_global_maps = 1

call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-speeddating')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-fugitive')
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gl :Glog<CR>

call minpac#add('tmhedberg/matchit')

call minpac#add('benekastah/neomake')
if exists(":Neomake") == 2
	autocmd! BufWritePost * Neomake
	let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
	let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }
endif

" Git-gutter {{{1
call minpac#add('airblade/vim-gitgutter')
" async doesn't work for my windows box
if has("win32")
	let g:gitgutter_async = 1
endif

" Airline {{{1
call minpac#add('vim-airline/vim-airline')
let g:airline#extensions#keymap#enabled = '0'
call minpac#add('vim-airline/vim-airline-themes')

" CtrlP {{{1
call minpac#add('ctrlpvim/ctrlp.vim')
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

" Completor {{{1
" Python should be installed. PATH should be set up to python37.dll
call minpac#add('maralla/completor.vim')

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
	elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
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
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()

" Asciidoctor {{{1
" There will be asciidoctor plugin here
let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'

" Misc {{{1
call minpac#add('jiangmiao/auto-pairs')

" use gsip to sort linewise
" use gsib to sort in a parenthesis
call minpac#add('christoomey/vim-sort-motion')

" use <leader>ttip to titlecase a paragraph
call minpac#add('christoomey/vim-titlecase')
let g:titlecase_map_keys = 0
nmap <leader>tt <Plug>Titlecase
vmap <leader>tt <Plug>Titlecase
nmap <leader>tT <Plug>TitlecaseLine

" Plug 'junegunn/rainbow_parentheses.vim'
" nnoremap <leader>xp :RainbowParentheses!!<CR>

call minpac#add('mhinz/vim-grepper')

call minpac#add('junegunn/vim-easy-align')
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Text objects {{{1
call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-textobj-entire')
call minpac#add('kana/vim-textobj-indent')

" colors {{{1
call minpac#add('dracula/vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('tyrannicaltoucan/vim-deep-space')
call minpac#add('cocopon/iceberg.vim')
call minpac#add('owickstrom/vim-colors-paramount')

" let there will be vim-plug for a while
finish


