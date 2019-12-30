""" Plugin settings

""" Git packages {{{1
if executable("git")
	silent! packadd vim-fugitive
	silent! packadd vim-flog
endif

""" UltiSnips {{{1
if has('nvim') || has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	let g:UltiSnipsListSnippets = '<c-tab>'

	silent! packadd ultisnips
endif

""" Fuzzy finder {{{1
" Try to load LeaderF first
if has('nvim') || has('python') || has('python3')
	if exists("*popup_create") || exists("*nvim_open_win")
		let g:Lf_WindowPosition = 'popup'
		let g:Lf_PreviewInPopup = 1
	endif
	let g:Lf_StlSeparator = { 'left': '', 'right': '' }
	let g:Lf_WindowHeight = 0.30
	let g:Lf_ShowHidden = 1
	let g:Lf_FollowLinks = 1
    let g:Lf_PreviewResult = { 'BufTag': 0 }
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]', '*.tmp','*.ttf']
            \}
    let g:Lf_MruWildIgnore = copy(g:Lf_WildIgnore)
	let g:Lf_UseVersionControlTool = 1
	" This is set by default
	" nnoremap <leader>f :LeaderfFile<CR>
	" nnoremap <leader>b :LeaderfBuffer<CR>
	nnoremap <leader>а :LeaderfFile<CR>
	nnoremap <leader>и :LeaderfBuffer<CR>
	nnoremap <leader>/ :LeaderfLine<CR>
	nnoremap <leader>; :LeaderfHistoryCmd<CR>
	nnoremap <leader>T :LeaderfBufTagAll<CR>
	nnoremap <leader>[ :LeaderfFunction<CR>
	nnoremap <leader>{ :LeaderfFunctionAll<CR>
	nnoremap <leader>h :LeaderfHelp<CR>
	nnoremap <leader>m :LeaderfMru<CR>
	nmap <leader>ь <leader>m
	nnoremap <leader>c :LeaderfColorscheme<CR>
	silent! packadd LeaderF

	command Docs :LeaderfFile ~/docs
endif

" Use ctrlp as backup fuzzy finder (no dependencies)
if !exists('g:leaderf_loaded')
	nnoremap <leader>f :CtrlPMixed<CR>
	nnoremap <leader>b :CtrlPBuffer<CR>
	nnoremap <leader>m :CtrlPMRUFiles<CR>

	let g:ctrlp_key_loop = 1
	if executable('rg')
		let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
		let g:ctrlp_use_caching = 1
	elseif has("win32") || has("win64")
		let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
	endif

	silent! packadd ctrlp.vim
endif

" Clap is good... but windows and vim is a second class citizen.
" if !exists('g:leaderf_loaded')
" 	nnoremap <leader>f :Clap files<CR>
" 	nnoremap <leader>b :Clap buffers<CR>
" 	nnoremap <leader>m :Clap history<CR>
" 	nnoremap <leader>; :Clap hist:<CR>
" 	nnoremap <leader>c :Clap colors<CR>
" 	silent! packadd vim-clap
" endif

""" Asciidoctor {{{1
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

let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json']

let g:asciidoctor_syntax_conceal = 1
let g:asciidoctor_folding = 0

func! AsciidoctorBufferSetup()
	nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
	nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
	nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
	nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
	nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
	nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
	nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
	nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
	compiler asciidoctor2pdf
endfunc
augroup asciidoctor | au!
	au BufEnter *.adoc,*.asciidoc call AsciidoctorBufferSetup()
augroup END

""" List Manipulation {{{1
let g:list_man_default_mappings = 1

""" EasyAlign {{{1
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" vim-swap settings {{{1
let g:swap_no_default_key_mappings = 1

""" text objects
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap g. <Plug>(swap-interactive)

""" Goyo && Limelight {{{1
nnoremap yog :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""" vim-skipit {{{1
imap <A-.> <Plug>(SkipItForward)
imap <A-,> <Plug>(SkipItBack)

""" Undotree {{{1
nnoremap <leader>u :UndotreeToggle<CR>

""" vim-rooter {{{1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.git/', 'mix.exs']
let g:rooter_silent_chdir = 1

""" elixir {{{1
" elixir related settings from different plugins
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1

""" tpope's Markdown {{{1
let g:markdown_folding = 0
let g:markdown_fenced_languages = ['dart', 'python', 'ruby']

""" Lisp {{{1
let g:lisp_rainbow = 1

""" Vim-obsession {{{1
command! -nargs=1 -complete=customlist,LoadObsessionComplete SA :Obsession ~/.vimdata/sessions/<args>

command! -nargs=1 -complete=customlist,LoadObsessionComplete LO :so ~/.vimdata/sessions/<args>

func! LoadObsessionComplete(A, L, P)
	let fullpaths = split(globpath("~/.vimdata/sessions/", a:A."*"), "\n")
	return map(fullpaths, {k,v -> fnamemodify(v, ":t")})
endfunc


""" Supertab {{{1
let g:SuperTabDefaultCompletionType = "context"

""" vim-yoink "kill ring" for vim
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

""" Netrw {{{1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:netrw_liststyle = 0
let g:netrw_banner = 0

""" Dirvish {{{1
" directory first
let g:dirvish_mode = ':sort ,^.*[\/],'

if has('gui_running')
	augroup dirvish_config | autocmd!
		autocmd FileType dirvish call dirvish#add_icon_fn({p -> p[-1:]=~'/\|\\'?'📂':'📄'})
	augroup END
endif


""" Vim dadbod {{{1
let g:dadbods = []

" g:dadbods should be populated with
" call add(g:dadbods, = #{
" 		\name: "My Database",
" 		\url: "postgresql://user:password@url/dbname"
" 		\})

runtime mydadbods.vim

command! -nargs=1 -complete=customlist,DBSComplete DBSelect :let b:db = g:dadbods[matchstr("<args>", '^(\zs\d\+\ze)')].url


func! DBSComplete(A, L, P)
	let dadbods = map(copy(g:dadbods), {i, v -> '('.i.') '.v['name']})
	call filter(dadbods, {_, v -> v =~ '.*' . a:A . '.*'})
	return dadbods
endfunc

"" operator mapping

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)


""" vim dispatch {{{1
let g:dispatch_no_maps = 1
nnoremap m<CR> :Make!<CR>

" "" vim lsc {{{1
" " for python
" " pip install 'python-language-server[all]'
" let g:lsc_auto_map = v:true
" let g:lsc_server_commands = { 
" 			\'python': {
" 			\    'command': 'pyls',
" 			\    'log_level': -1,
" 			\    'suppress_stderr': v:true
" 			\},
" 			\'ruby': {
" 			\    'command': '127.0.0.1:7658',
" 			\    'log_level': -1,
" 			\    'suppress_stderr': v:false
" 			\},
" 			\'dart': {
" 			\    'command': 'C:/Users/maksim.kim/scoop/apps/dart/current/bin/dart C:/Users/maksim.kim/scoop/apps/dart/current/bin/snapshots/analysis_server.dart.snapshot --lsp --instrumentation-log-file=C:/Users/maksim.kim/dart.log'
" 			\},
" \}
" let g:lsc_dart_enable_log = v:true

" augroup lsc_preview | au!

""" vim-lsp {{{1
let g:lsp_auto_enable = 1
let g:lsp_signs_enabled = 0
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vimlsp.log')

augroup lsp_preview | au!
	autocmd CompleteDone * silent! pclose
	if !has('nvim')
		autocmd User lsp_float_opened
			\ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(),
			\ {
			\ 'border': [1, 1, 1, 1],
			\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
			\ 'padding': [0, 0, 0, 0]
			\ })
	end
augroup end

" if executable('dart')
" 	let s:dart_lsp_path = fnamemodify(resolve(exepath('dart')), ':h')
" 	au User lsp_setup call lsp#register_server({
" 				\ 'name': 'dart',
" 				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'dart '.s:dart_lsp_path.'/snapshots/analysis_server.dart.snapshot --lsp']},
" 				\ 'initialization_options': {"diagnostics": "true"},
" 				\ 'whitelist': ['dart'],
" 				\ })
" endif

func! SetLSPMappings()
	nnoremap <buffer> gd :LspDefinition<CR>
	nnoremap <buffer> K :LspHover<CR>
	nnoremap <buffer> <C-Space> :LspSignatureHelp<CR>
	nnoremap <buffer> <leader>lf :LspDocumentFormat<CR>
	nnoremap <buffer> <leader>la :LspCodeAction<CR>
	nnoremap <buffer> <leader>ls :LspDocumentSymbol<CR>
endfunc
augroup lsp_mappings | au!
	au FileType python call SetLSPMappings()
	au FileType ruby call SetLSPMappings()
	au FileType dart call SetLSPMappings()
augroup END


" """ vim-CtrlXA
" " integrate with tpope's speeddating 
" nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
" nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)


""" vim-matchup
let g:loaded_matchit = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}

""" Firenvim {{{1
if has('nvim')
	au BufEnter github.com_*.txt set filetype=markdown
	let g:firenvim_config = {
				\ 'localSettings': {
				\ '.*': {
				\ 'selector': '',
				\ 'priority': 0,
				\ }
				\ }
				\ }
endif

""" Visual Multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<leader>n'
let g:VM_maps['Find Subword Under'] = '<leader>n'
let g:VM_maps["Select Cursor Down"] = '<M-j>'
let g:VM_maps["Select Cursor Up"]   = '<M-j>'

""" Outline {{{1
nnoremap <leader>l :DoOutline<CR>


""" My pythoned stuff
runtime habapython.vim

