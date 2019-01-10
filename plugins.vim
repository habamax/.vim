" source <sfile>:h/minpac_list.vim
runtime minpac_list.vim

" Plugin settings

" Git packages {{{1
if executable("git")
	nnoremap <leader>gs :Gstatus<CR>

	packadd vim-fugitive
endif

" UltiSnips {{{1
if has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

	packadd ultisnips
	
endif

" Let me have fzf just in case... {{{1
if executable('fzf')
	" nnoremap <leader>ff :Files<CR>
	" nnoremap <leader>fh :History<CR>
	" nnoremap <leader>b :Buffers<CR>
	" nnoremap <leader>fc :Colors<CR>
	" nnoremap <leader>fdd :Files ~/docs<CR>
	" nnoremap <leader>fdv :exe ':Files '.fnamemodify($MYVIMRC, ':p:h')<CR>
	" [Buffers] Jump to the existing window if possible
	let g:fzf_buffers_jump = 1

	packadd fzf
	packadd fzf.vim

endif

" LeaderF or CtrlP {{{1
if has('python') || has('python3')
	let g:Lf_StlSeparator = { 'left': '', 'right': '' }
	let g:Lf_ShortcutF = '<leader>ff'
	let g:Lf_Shortcutb = '<leader>b'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_ShowHidden = 1
	let g:Lf_FollowLinks = 1
	let g:Lf_CommandMap = {'<ESC>': ['<C-Space>', '<ESC>']}
	let g:Lf_NormalMap = {"File":   [["u", ':LeaderfFile ..<CR>']]}
    let g:Lf_PreviewResult = {'Colorscheme': 1}
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]', '*.tmp']
            \}
    let g:Lf_MruWildIgnore = copy(g:Lf_WildIgnore)
	cabbrev lf LeaderfFile
	nnoremap <leader>f/ :Leaderf rg<CR>
	nnoremap <leader>/ :LeaderfLineAll<CR>
	nnoremap <leader>h :LeaderfHelp<CR>
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
	nnoremap <leader>b :CtrlPBuffer<CR>
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

" vim-rest-console {{{1
let g:vrc_auto_format_response_enabled = 1
let b:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 1
let g:vrc_curl_opts = {
			\ '-sS': '',
			\ '-i': '',
			\ '--connect-timeout': 10,
			\}

" ALE configuration {{{1

let g:ale_fixers = {}
" use with vim rooter...
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fixers.html = ['prettier']
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']

let g:ale_javascript_prettier_options = '--use-tabs'

let g:ale_elixir_elixir_ls_release = "C:/prg/elixir-ls"
" let g:ale_completion_enabled = 1

nmap <leader>af <Plug>(ale_fix)
nmap <leader>ad :ALEGoToDefinition<CR>
nmap <leader>ah :ALEHover<CR>

" Undotree {{{1
nnoremap <leader>u :UndotreeToggle<CR>

" vim-rooter {{{1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.git/', 'mix.exs']
let g:rooter_silent_chdir = 1

" elixir-mix-test {{{1
let g:elixir_mix_test_position = "bottom"

" mucomplete {{{1
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.vim = ['path', 'ulti', 'cmd', 'keyn']
let g:mucomplete#chains.default = ['path', 'ulti', 'keyn', 'dict', 'uspl']

let g:mucomplete#ultisnips#match_at_start = 1
let g:mucomplete#cycle_with_trigger = 1
imap <C-n> <plug>(MUcompleteFwd)
imap <C-p> <plug>(MUcompleteBwd)
