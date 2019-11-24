" source <sfile>:h/minpac_list.vim
runtime minpac_list.vim

" Plugin settings

" Git packages {{{1
if executable("git")
	silent! packadd vim-fugitive
	silent! packadd vim-flog
endif

" UltiSnips {{{1
if has('python') || has('python3')
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	let g:UltiSnipsListSnippets = '<c-tab>'

	packadd ultisnips
endif

" LeaderF or Others {{{1
if has('python') || has('python3')
	if exists("*popup_create") || exists("*nvim_open_win")
		let g:Lf_WindowPosition = 'popup'
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
	let g:Lf_UseVersionControlTool = 0
	" This is set by default
	" nnoremap <leader>f :LeaderfFile<CR>
	" nnoremap <leader>b :LeaderfBuffer<CR>
	nnoremap <leader>а :LeaderfFile<CR>
	nnoremap <leader>и :LeaderfBuffer<CR>
	nnoremap <leader>/ :LeaderfLine<CR>
	nnoremap <leader>; :LeaderfHistoryCmd<CR>
	nnoremap <leader>T :LeaderfBufTagAll<CR>
	nnoremap <leader>h :LeaderfHelp<CR>
	nnoremap <leader>m :LeaderfMru<CR>
	nmap <leader>ь <leader>m
	nnoremap <leader>c :LeaderfColorscheme<CR>
	silent! packadd LeaderFd
endif

if !exists('g:leaderf_loaded')
	nnoremap <leader>f :CtrlPMixed<CR>
	nnoremap <leader>b :CtrlPBuffer<CR>
	silent! packadd ctrlp.vim
endif

" if !exists('g:leaderf_loaded')
" 	nnoremap <leader>f :Clap files<CR>
" 	nnoremap <leader>b :Clap buffers<CR>
" 	nnoremap <leader>m :Clap history<CR>
" 	nnoremap <leader>; :Clap hist:<CR>
" 	nnoremap <leader>c :Clap colors<CR>
" 	silent! packadd vim-clap
" endif

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

let g:asciidoctor_folding = 0
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql']

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

func! LoadObsessionComplete(A, L, P)
	let fullpaths = split(globpath("~/.vimdata/sessions/", a:A."*"), "\n")
	return map(fullpaths, {k,v -> fnamemodify(v, ":t")})
endfunc


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


"" vim-lsp {{{1
let g:lsp_signs_enabled = 0
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

augroup lsp_preview | au!
	autocmd CompleteDone * silent! pclose
augroup end

if executable('pyls')
	" pip install 'python-language-server[all]'
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

if executable('dart')
	let s:dart_lsp_path = fnamemodify(resolve(exepath('dart')), ':h')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'dart',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dart '.s:dart_lsp_path.'/snapshots/analysis_server.dart.snapshot --lsp']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['dart'],
        \ })
endif

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


"" vim-CtrlXA
" integrate with tpope's speeddating 
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)



"" Outline {{{1
nnoremap <leader>l :DoOutline<CR>

