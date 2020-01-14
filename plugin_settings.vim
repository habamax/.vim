""" Plugin settings

""" Git packages {{{1
if executable("git")
	silent! packadd vim-fugitive
	silent! packadd vim-flog
endif

""" Fuzzy finder {{{1
" Try to load LeaderF first
if has('nvim') || has('python') || has('python3')
	" if exists("*popup_create") || exists("*nvim_open_win")
	" 	let g:Lf_WindowPosition = 'popup'
	" 	let g:Lf_PreviewInPopup = 1
	" endif
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

""" Asciidoctor {{{1
" There will be asciidoctor plugin here
" let g:asciidoctor_executable = 'bundle exec asciidoctor'

" use asciidoctorj
" let g:asciidoctor_executable = "asciidoctorj"
" let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
let g:asciidoctor_extensions = ['asciidoctor-diagram']

" use upstream asciidoctor-pdf
let g:asciidoctor_pdf_executable = "ruby C:/Users/maksim.kim/projects/asciidoctor-pdf/bin/asciidoctor-pdf"
" let g:asciidoctor_pdf_executable = "bundle exec asciidoctor-pdf"
" use asciidoctorj -b pdf
" let g:asciidoctor_pdf_executable = "asciidoctorj -b pdf"

" let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
" let g:asciidoctor_pdf_extensions = ['C:/Users/maksim.kim/projects/asciidoctor-diagram/lib/asciidoctor-diagram.rb']
let g:asciidoctor_pdf_extensions = copy(g:asciidoctor_extensions)
let g:asciidoctor_pdf_themes_path = '~/docs/.asciidoctor-themes'
" let g:asciidoctor_pdf_fonts_path = '~/docs/.asciidoctor-setup/fonts;GEM_FONTS_DIR'

" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json']

let g:asciidoctor_syntax_conceal = 0
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

""" Netrw -> Dirvish {{{1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

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


""" vim-lsp {{{1
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_signs_enabled = 0
" let g:lsp_highlight_references_enabled = 1
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vimlsp.log')

"" mapping `C-w z` also works
" augroup lsp_preview | au!
" 	autocmd CompleteDone * silent! pclose
" augroup end

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
	" au FileType dart call SetLSPMappings()
	au FileType html call SetLSPMappings()
augroup END

"" asyncomplete {{{1
" let g:asyncomplete_auto_completeopt = 0
" let g:asyncomplete_auto_popup = 0
imap <C-Space> <Plug>(asyncomplete_force_refresh)
" inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
imap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR><Plug>DiscretionaryEnd" : "\<CR><Plug>DiscretionaryEnd"

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
			\ 'name': 'file',
			\ 'whitelist': ['*'],
			\ 'priority': 10,
			\ 'completor': function('asyncomplete#sources#file#completor')
			\ }))


""" vim-matchup {{{1
let g:loaded_matchit = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}

""" vim-vsnip {{{1
let g:vsnip_snippet_dir = fnamemodify($MYVIMRC, ":p:h") . '/vsnip'

" imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
" imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

""" vim-closetag
let g:closetag_filetypes = 'html,xhtml,xml'

""" Firenvim {{{1
if exists('g:started_by_firenvim')
	packadd firenvim
	set gfn=Iosevka\ Slab\ Extended:h12
	au BufEnter github.com_*.txt set filetype=markdown
	au BufEnter www.linux.org.ru_*.txt set filetype=markdown
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

"" vim-rest-console {{{
let g:vrc_auto_format_response_enabled = 1
let b:vrc_response_default_content_type = 'application/json'
" let g:vrc_show_command = 1
let g:vrc_curl_opts = {
			\ '-sS': '',
			\ '-i': '',
			\ '--connect-timeout': 10,
			\}


""" Outline {{{1
nnoremap <leader>l :DoOutline<CR>


""" Число прописью {{{1
""" вынести в отдельный плагин

let s:dig1 = ["один", "два", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять" ]
let s:dig1f = ["одна", "две", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять" ]
let s:dig10 = ["десять", "одиннадцать", "двенадцать", "тринадцать", "четырнадцать", "пятнадцать", "шестнадцать", "семнадцать", "восемнандцать", "девятнадцать" ]
let s:dig20 = ["двадцать", "тридцать", "сорок", "пятьдесят", "шестьдесят", "семдесят", "восемьдесят", "девяносто" ]
let s:dig100 = ["сто", "двести", "триста", "четыреста", "пятьсот", "шестьсот", "семьсот", "восемьсот", "девятьсот" ]
let s:levels = [
			\ ["", "", ""],
			\ ["тысяча", "тысячи", "тысяч"],
			\ ["миллион", "миллиона", "миллионов"],
			\ ["миллиард", "миллиарда", "миллиардов"],
			\ ["триллион", "триллиона", "триллионов"]
			\ ]

"" call IntToWordsRU(12342)
"" returns list of lists
"" [["двенадцать","тысяч"], ["триста", "сорок", "два"]]
func! IntToWordsRU(num, ...) abort
	let result = get(a:, 1, [])
	let level = get(a:, 2, 0)

	let level_result = []

	let h = a:num%1000
	let d = h/100
	if d > 0
		call add(level_result, s:dig100[d-1])
	endif

	let n = h%100
	let d = n/10
	let n = n%10

	if d == 1
		call add(level_result, s:dig10[n])
		let n = 0
	endif

	if d > 1
		call add(level_result, s:dig20[d-2])
	endif

	if n != 0
		if level != 1
			call add(level_result, s:dig1[n-1])
		else
			call add(level_result, s:dig1f[n-1])
		endif
	endif

	if level > 0
		if n == 0 || n > 4
			call add(level_result, s:levels[level][2])
		elseif n == 1
			call add(level_result, s:levels[level][0])
		else
			call add(level_result, s:levels[level][1])
		endif
	endif

	call add(result, level_result)

	let next_num = a:num/1000
	if next_num > 0
		return IntToWordsRU(next_num, result, level+1)
	else
		return reverse(result)
	endif

endfunc

func! Ruble(num) abort
	let result = 'рублей'
	let n = a:num%10
	if n == 1
		let result = 'рубль'
	elseif n < 5
		let result = 'рубля'
	endif
	return result
endfunc

func! Flatten(list) abort
	let val = []
	for elem in a:list
		if type(elem) == type([])
			call extend(val, Flatten(elem))
		else
			call add(val, elem)
		endif
		unlet elem
	endfor
	return val	
endfunc

func! ReplaceNum2WordsRU() abort
	" TODO: properly detect numbers.
	let cWORD = expand("<cWORD>")
	let words = join(Flatten(IntToWordsRU(cWORD)))
	call setline('.', substitute(getline('.'), cWORD, words, ""))
endfunc

command! Num2WordsRU call ReplaceNum2WordsRU()

" 349765019283432
" триста сорок девять триллионов семьсот шестьдесят пять миллиардов
" девятнадцать миллионов двести восемдесят три тысячи четыреста тридцать два


" echo join(Flatten(IntToWordsRU("102340202151"))) . ' ' . Ruble("102340202151")

" echo IntToWordsRU("102340201152")
" echo IntToWordsRU("102340203152")
" echo IntToWordsRU("1001152")
" echo IntToWordsRU("1002152")
" echo IntToWordsRU("1003152")
" echo IntToWordsRU("1004152")
" echo IntToWordsRU("1005152")

