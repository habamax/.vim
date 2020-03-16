""" Check after/plugin/init.vim for settings that depends on plugin existence
""" Plugin settings

"" Python ext {{{1
if has('nvim')
    let g:python3_host_prog  = 'python'
    let g:loaded_python_provider = 0
    let g:loaded3_python_provider = 0
endif


""" Git {{{1
if executable("git")
    silent! packadd vim-fugitive
    silent! packadd vim-flog
endif

""" Fuzzy finder (Clap, Leaderf and CtrlP) {{{1
" Try LeaderF first
if has('nvim') || has('python') || has('python3')
    " if exists("*popup_create") || exists("*nvim_open_win")
    "   let g:Lf_WindowPosition = 'popup'
    "   let g:Lf_PreviewInPopup = 1
    "   let g:Lf_PopupWidth = 0.75
    "   let g:Lf_PopupHeight = 0.5
    " endif
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    " let g:Lf_StlSeparator = { 'left': '', 'right': '' }
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
    let g:Lf_MruMaxFiles = 500
    " This is set by default
    " nnoremap <leader>f :LeaderfFile<CR>
    " nnoremap <leader>b :LeaderfBuffer<CR>
    nnoremap <leader>а :Leaderf file<CR>
    nnoremap <leader>и :Leaderf buffer<CR>
    nnoremap <leader>/ :Leaderf line<CR>
    nnoremap <leader>; :Leaderf command<CR>
    nnoremap <leader>T :Leaderf tag<CR>
    nnoremap <leader>[ :Leaderf function<CR>
    nnoremap <leader>h :Leaderf help<CR>
    nnoremap <leader>m :Leaderf mru<CR>
    nnoremap <leader>g :Leaderf rg<CR>
    nmap <leader>ь <leader>m
    nnoremap <leader>c :LeaderfColorscheme<CR>
    silent! packadd LeaderF

    command Docs :LeaderfFile ~/docs
endif

" Then try to load vim-clap
if !exists('g:leaderf_loaded') && (has('patch-8.1.2114') || has('nvim-0.4.2'))
    nnoremap <leader>f :Clap files<CR>
    nnoremap <leader>b :Clap buffers<CR>
    nnoremap <leader>/ :Clap blines<CR>
    nnoremap <leader>; :Clap command<CR>
    nnoremap <leader>T :Clap tags<CR>
    nnoremap <leader>h :Clap help<CR>
    nnoremap <leader>m :Clap history<CR>
    nnoremap <leader>c :Clap colors<CR>
    nnoremap <leader>g :Clap grep<CR>

    let g:clap_layout = { 'relative': 'editor' }
    silent! packadd vim-clap
endif

" Use ctrlp as backup fuzzy finder (no dependencies)
if !exists('g:leaderf_loaded') && !exists('g:loaded_clap')
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

""" vim-asciidoctor {{{1
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
" let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript']
" let g:asciidoctor_syntax_indented = 0

let g:asciidoctor_pandoc_other_params = '--toc'
let g:asciidoctor_pandoc_data_dir = '~/docs/.pandoc'

let g:asciidoctor_syntax_conceal = 1
let g:asciidoctor_folding = 0
let g:asciidoctor_fold_options = 0

func! AsciidoctorBufferSetup()
    setl cole=3
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

""" vim-swap {{{1
let g:swap_no_default_key_mappings = 1

""" vim-rooter {{{1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.git/', 'mix.exs']
let g:rooter_silent_chdir = 1

""" vim-markdown {{{1
let g:markdown_folding = 0
let g:markdown_fenced_languages = ['dart', 'python', 'ruby', 'go']

""" vim-obsession {{{1
command! -nargs=1 -complete=customlist,LoadObsessionComplete SA :Obsession ~/.vimdata/sessions/<args>

command! -nargs=1 -complete=customlist,LoadObsessionComplete LO :so ~/.vimdata/sessions/<args>

func! LoadObsessionComplete(A, L, P)
    let fullpaths = split(globpath("~/.vimdata/sessions/", a:A."*"), "\n")
    return map(fullpaths, {k,v -> fnamemodify(v, ":t")})
endfunc


""" vim-dadbod {{{1
let g:dadbods = []

" g:dadbods should be populated with
" call add(g:dadbods, = #{
"       \name: "My Database",
"       \url: "postgresql://user:password@url/dbname"
"       \})

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


""" vim-dispatch {{{1
let g:dispatch_no_maps = 1


""" vim-lsp {{{1
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_semantic_enabled = 1

" prefer microsoft implementation of pyls 
let g:lsp_settings_filetype_python = 'pyls-ms'
" let g:lsp_settings_servers_dir = fnamemodify($MYVIMRC, ":p:h") . "/lsp-servers/"
" if !isdirectory(g:lsp_settings_servers_dir) 
"     call mkdir(g:lsp_settings_servers_dir, "p") 
" endif

" let g:lsp_signs_enabled = 0
" let g:lsp_highlight_references_enabled = 1

" logging for debug
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vimlsp.log')

augroup lsp_preview | au!
    autocmd CompleteDone * silent! pclose
    if !has('nvim')
        autocmd User lsp_float_opened
            \ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(),
            \ {
            \ 'border': [0, 0, 0, 0],
            \ 'padding': [0, 1, 0, 1]
            \ })
    end
augroup end

"" mapping `C-w z` also works
" augroup lsp_preview | au!
"   autocmd CompleteDone * silent! pclose
" augroup end

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
    au FileType html call SetLSPMappings()
    au FileType go call SetLSPMappings()
    autocmd BufWritePre *.go call execute('LspDocumentFormatSync') | call execute('LspCodeActionSync source.organizeImports')
augroup END


""" vim-matchup {{{1
let g:loaded_matchit = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_surround_enabled = 1
let g:matchup_enabled = 1

""" vim-vsnip {{{1
let g:vsnip_snippet_dir = fnamemodify($MYVIMRC, ":p:h") . '/vsnip'

""" vim-closetag {{{1
let g:closetag_filetypes = 'html,xhtml,xml'


""" vim-sandwich {{{1
" nmap s <Nop>
" xmap s <Nop>

""" vim-dirvish {{{1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" directory first
let g:dirvish_mode = ':sort ,^.*[\/],'

"" Clears conceal highlighting which is not good.
" if has('gui_running')
"     augroup dirvish_config | autocmd!
"         autocmd FileType dirvish call dirvish#add_icon_fn({p -> p[-1:]=~'/\|\\'?'📂':'📄'})
"     augroup END
" endif


""" vim-easy-align {{{1
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""" vim-visual-multi {{{1
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<leader>n'
let g:VM_maps['Find Subword Under'] = '<leader>n'
let g:VM_maps["Select Cursor Down"] = '<M-j>'
let g:VM_maps["Select Cursor Up"]   = '<M-j>'

"" vim-rest-console {{{1
let g:vrc_auto_format_response_enabled = 1
let b:vrc_response_default_content_type = 'application/json'
" let g:vrc_show_command = 1
let g:vrc_curl_opts = {
            \ '-sS': '',
            \ '-i': '',
            \ '--connect-timeout': 10,
            \}


"" vim-winlayout {{{1

nmap <F3> <Plug>(WinlayoutBackward)
nmap <F4> <Plug>(WinlayoutForward)


""" firenvim {{{1
if exists('g:started_by_firenvim')
    packadd firenvim
    set gfn=Iosevka\ Habamax:h12
    au BufEnter github.com_*.txt set filetype=markdown
    au BufEnter www.linux.org.ru_*.txt set filetype=markdown
    let g:firenvim_config = {
                \   'localSettings': {
                \       '.*': {
                \           'selector': '',
                \           'priority': 0,
                \       }
                \   }
                \ }
endif


""" elixir {{{1
" elixir related settings from different plugins
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1

""" List Manipulation {{{1
let g:list_man_default_mappings = 1

""" Goyo && Limelight {{{1
nnoremap yog :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""" undotree {{{1
nnoremap <leader>u :UndotreeToggle<CR>


""" outline {{{1
nnoremap <leader>l :DoOutline<CR>
