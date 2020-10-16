""" Check after/plugin/init.vim for settings that depends on plugin existence
""" Plugin settings

"" Python ext {{{1
if has('nvim')
    let g:python3_host_prog = 'py'
    let g:loaded_python_provider = 0
    let g:loaded3_python_provider = 0
endif


""" netrw {{{1
let g:netrw_banner = 0


""" vim-gutentags {{{1
if executable("ctags")
    silent! packadd vim-gutentags
endif


""" Git {{{1
if executable("git")
    silent! packadd vim-fugitive
    silent! packadd vim-flog
endif


""" vim-asciidoctor {{{1
" let g:asciidoctor_executable = 'bundle exec asciidoctor'

" use asciidoctorj
" let g:asciidoctor_executable = "asciidoctorj"
" let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
let g:asciidoctor_extensions = ['asciidoctor-diagram']

" use upstream asciidoctor-pdf
let g:asciidoctor_pdf_executable = printf("ruby %s/projects/asciidoctor-pdf/bin/asciidoctor-pdf",
            \ empty($DOCSHOME)?expand('~'):expand($DOCSHOME))
" let g:asciidoctor_pdf_executable = "bundle exec asciidoctor-pdf"
" use asciidoctorj -b pdf
" let g:asciidoctor_pdf_executable = "asciidoctorj -b pdf"

" let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram', 'asciidoctor-bibtex']
" let g:asciidoctor_pdf_extensions = ['C:/Users/maksim.kim/projects/asciidoctor-diagram/lib/asciidoctor-diagram.rb']
let g:asciidoctor_pdf_extensions = copy(g:asciidoctor_extensions)
let g:asciidoctor_pdf_themes_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes'
let g:asciidoctor_pdf_fonts_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes/fonts;GEM_FONTS_DIR'

" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json', 'xml']
" let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript']
" let g:asciidoctor_syntax_indented = 0
let g:asciidoctor_css = 'asciidoctor-next.min.css'
let g:asciidoctor_css_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes'

let g:asciidoctor_pandoc_other_params = '--toc'
let g:asciidoctor_pandoc_data_dir = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.pandoc'

let g:asciidoctor_syntax_conceal = 1
" let g:asciidoctor_folding = 1
" let g:asciidoctor_fold_options = 1


""" vim-swap {{{1
let g:swap_no_default_key_mappings = 1


""" vim-rooter {{{1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.hg', '.svn', 'Makefile', 'go.mod', 'mix.exs']

let g:rooter_silent_chdir = 1


""" vim-markdown {{{1
let g:markdown_folding = 0
let g:markdown_fenced_languages = ['python', 'go']


""" vim-dispatch {{{1
let g:dispatch_no_maps = 1
" tmux in alacritty wsl debian makes vim "bad" sized in the end
" vim doesn't resize back after tmux pane is closed.
let g:dispatch_no_tmux_make = 1


""" vim-closetag {{{1
let g:closetag_filetypes = 'html,xhtml,xml'


""" vim-easy-align {{{1
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"" vim-rest-console {{{1
let g:vrc_auto_format_response_enabled = 1
let g:vrc_show_command = 1
let g:vrc_curl_opts = {
            \ '-sS': '',
            \ '-i': '',
            \ '--connect-timeout': 10,
            \}
let g:vrc_set_default_mapping = 0
augroup rest_output | au!
    au BufNew __REST_response__ command! FormatREST call misc#vrc_format_rest_as_json()
augroup END



""" elixir {{{1
" elixir related settings from different plugins
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1


""" listopad {{{1
let g:listopad_default_mappings = 1
let g:listopad_auto_archive = 1


""" undotree {{{1
nnoremap <leader>u :UndotreeToggle<CR>


""" outline {{{1
augroup do_outline | au!
    au BufRead,BufNewFile *.adoc,*.md nnoremap <buffer> <leader><leader>l :DoOutline<CR>
augroup end


""" vim-evalvim {{{1
let g:evalvim_mappings = v:true


""" YCM, Coc or mucomplete {{{1
call timer_start(2000, {-> lsp#setup('ycm')})


""" Colorizer
let g:colorizer_auto_filetype='css,html,colortemplate'
let g:colorizer_disable_bufleave = 1


""" Fern
nnoremap <silent> <F8> :Fern . -drawer -toggle -reveal=%<CR>
nnoremap <silent> <F9> :FernDo :<CR>


""" vim-godot
let g:godot_ext_hl = v:false
