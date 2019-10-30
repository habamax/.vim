" source <sfile>:h/minpac_list.vim
runtime minpac_list.vim

" Plugin settings

" Git packages {{{1
if executable("git")
	try
		nnoremap <leader>gs :Gstatus<CR>

		packadd vim-fugitive
		packadd vim-flog
	catch /./
	endtry
endif

" UltiSnips {{{1
if has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	let g:UltiSnipsListSnippets = '<c-tab>'

	packadd ultisnips
endif

" Let me have fzf just in case... {{{1
if executable('fzf') && 0
	try
		nnoremap <leader>ff :Files<CR>
		nnoremap <leader>fh :History<CR>
		nnoremap <leader>b :Buffers<CR>
		nnoremap <leader>fc :Colors<CR>
		nnoremap <leader>fdd :Files ~/docs<CR>
		nnoremap <leader>fdv :exe ':Files '.fnamemodify($MYVIMRC, ':p:h')<CR>
		" [Buffers] Jump to the existing window if possible
		let g:fzf_buffers_jump = 1

		packadd fzf
		packadd fzf.vim
	catch /./
	endtry
" LeaderF or CtrlP {{{1
elseif has('python') || has('python3')
	let g:Lf_StlSeparator = { 'left': '', 'right': '' }
	let g:Lf_ShortcutF = '<leader>ff'
	let g:Lf_Shortcutb = '<leader>b'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_ShowHidden = 1
	let g:Lf_FollowLinks = 1
	let g:Lf_NormalMap = {"File":   [["u", ':LeaderfFile ..<CR>']]}
    let g:Lf_PreviewResult = { 'BufTag': 0 }
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]', '*.tmp','*.ttf']
            \}
    let g:Lf_MruWildIgnore = copy(g:Lf_WildIgnore)
	let g:Lf_UseVersionControlTool = 0
	nnoremap <leader>f/ :Leaderf rg 
	nnoremap <leader>/ :LeaderfLineAll<CR>
	nnoremap <leader>f; :LeaderfHistoryCmd<CR>
	nnoremap <leader>ftt :LeaderfTag<CR>
	nnoremap <leader>ftb :LeaderfBufTag<CR>
	nnoremap <leader>fh :LeaderfHelp<CR>
	nnoremap <leader>fm :LeaderfMru<CR>
	nnoremap <leader>fs :LeaderfSelf<CR>
	nnoremap <leader>fc :LeaderfColorscheme<CR>
	nnoremap <leader>fdd :LeaderfFile ~/docs<CR>
	" open .vim or .vimfiles or nvim config directory
	nnoremap <leader>fdv :exe ':LeaderfFile '.fnamemodify($MYVIMRC, ':p:h')<CR>
	packadd LeaderF
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
" let g:asciidoctor_executable = 'asciidoctor'

" use asciidoctorj
" let g:asciidoctor_executable = "asciidoctorj"
" let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
let g:asciidoctor_extensions = ['asciidoctor-diagram']

" use upstream asciidoctor-pdf
let g:asciidoctor_pdf_executable = "ruby C:/Users/maksim.kim/projects/asciidoctor-pdf/bin/asciidoctor-pdf"
" use asciidoctorj -b pdf
" let g:asciidoctor_pdf_executable = "asciidoctorj -b pdf"

" let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_themes_path = '~/docs/.asciidoctor-setup'
let g:asciidoctor_pdf_fonts_path = '~/docs/.asciidoctor-setup/fonts'

" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql']

fun! AsciidoctorBufferSetup()
	nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
	nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
	nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
	nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
	nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
	nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
	nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
	nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
	compiler asciidoctor2pdf
endfun
augroup asciidoctor | au!
	au BufEnter *.adoc,*.asciidoc call AsciidoctorBufferSetup()
augroup END

" List Manipulation {{{1
let g:list_man_default_mappings = 1

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

" Undotree {{{1
nnoremap <leader>u :UndotreeToggle<CR>

" vim-rooter {{{1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.git/', 'mix.exs']
let g:rooter_silent_chdir = 1

" elixir {{{1
" elixir related settings from different plugins
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1

"" tpope's Markdown {{{1
let g:markdown_folding = 1

"" Lisp {{{1
let g:lisp_rainbow = 1

"" Vim-obsession {{{1
command! -nargs=1 -complete=customlist,LoadObsessionComplete SA :Obsession ~/.vimdata/sessions/<args>

command! -nargs=1 -complete=customlist,LoadObsessionComplete LO :so ~/.vimdata/sessions/<args>

fun! LoadObsessionComplete(A, L, P)
	let fullpaths = split(globpath("~/.vimdata/sessions/", a:A."*"), "\n")
	return map(fullpaths, {k,v -> fnamemodify(v, ":t")})
endfu


"" Supertab
let g:SuperTabDefaultCompletionType = "context"

"" vim-yoink "kill ring" for vim
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

"" netrw
let g:netrw_liststyle = 0
let g:netrw_banner = 0

"" Vim dadbod {{{1
if !has('nvim')
	let g:dadbods = []

	" g:dadbods should be populated with
	"
	" let db = #{
	" 		\name: "My Database",
	" 		\url: "postgresql://user:password@url/dbname"
	" 		\}

	" call add(g:dadbods, db)

	runtime mydadbods.vim

	command! DBSelect :call popup_menu(map(copy(g:dadbods), {k,v -> v.name}), #{
				\callback: 'DBSelected'
				\})

	func! DBSelected(id, result)
		if a:result != -1
			let b:db = g:dadbods[a:result-1].url
			echomsg 'DB ' . g:dadbods[a:result-1].name . ' is selected.'
		endif
	endfunc

	"" operator mapping

	xnoremap <expr> <Plug>(DBExe)     db#op_exec()
	nnoremap <expr> <Plug>(DBExe)     db#op_exec()
	nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

	xmap <leader>db  <Plug>(DBExe)
	nmap <leader>db  <Plug>(DBExe)
	omap <leader>db  <Plug>(DBExe)
	nmap <leader>dbb <Plug>(DBExeLine)
	noremap <leader>dbs :DBSelect<CR>
endif


"" vim dispatch {{{1
let g:dispatch_no_maps = 1
nnoremap m<CR> :Make!<CR>

"" vim lsc {{{1
" for python
" pip install 'python-language-server[all]'
let g:lsc_auto_map = v:true
let g:lsc_server_commands = { 
			\'python': {
			\    'command': 'pyls',
			\    'log_level': -1,
			\    'suppress_stderr': v:true
			\},
			\'ruby': {
			\    'command': '127.0.0.1:7658',
			\    'log_level': -1,
			\    'suppress_stderr': v:false
			\}
\}

augroup lsc_preview | au!
	autocmd CompleteDone * silent! pclose
augroup end

"" vim-CtrlXA
" integrate with tpope's speeddating 
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
