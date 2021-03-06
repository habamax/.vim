" Check after/plugin/settings.vim for settings that depends on plugin existence
" Plugin settings


"
" netrw
"
func! s:netrw_e() abort
    exe 'silent e ' .. expand("%:p:h")
    call search('\<'..expand("#:t")..'\>')
endfunc
nnoremap <silent> - :call <SID>netrw_e()<CR>
let g:netrw_banner = 0


"
" vim-gutentags
"
if executable("ctags")
    silent! packadd vim-gutentags
endif


"
" Git
"
if executable("git")
    silent! packadd vim-fugitive
    silent! packadd vim-flog
endif


"
" vim-asciidoctor
"
" use ruby bundler:
"     sudo gem install bundler
" goto docs directory and:
"     bundle install
let g:asciidoctor_executable = 'bundle exec asciidoctor'
let g:asciidoctor_pdf_executable = "bundle exec asciidoctor-pdf"

let g:asciidoctor_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_extensions = copy(g:asciidoctor_extensions)
let g:asciidoctor_pdf_themes_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes'
let g:asciidoctor_pdf_fonts_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes/fonts;GEM_FONTS_DIR'

" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json', 'xml']
" let g:asciidoctor_css = 'asciidoctor-next.min.css'
" let g:asciidoctor_css_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes'

let g:asciidoctor_pandoc_other_params = '--toc'
let g:asciidoctor_pandoc_data_dir = expand($DOCS ?? '~/docs') .. '/.pandoc'

let g:asciidoctor_syntax_conceal = 1
" let g:asciidoctor_folding = 1
" let g:asciidoctor_fold_options = 1


"
" vim-swap
"
let g:swap_no_default_key_mappings = 1


"
" vim-rooter
"
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.hg', '.svn', 'Makefile', 'go.mod', 'mix.exs']

let g:rooter_silent_chdir = 1


"
" vim-markdown
"
let g:markdown_fenced_languages = ['python', 'go']


"
" vim-dispatch
"
let g:dispatch_no_maps = 1


"
" vim-closetag
"
let g:closetag_filetypes = 'html,xhtml,xml'


"
" elixir
"
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1


"
" YCM
"
" call timer_start(2000, {-> lsp#setup()})


"
" Colorizer
"
let g:colorizer_auto_filetype='css,html,colortemplate'
let g:colorizer_disable_bufleave = 1


"
" vim-godot
"
let g:godot_ext_hl = v:false


"
" lens
"
let g:lens_disabled_filetypes = ['fugitiveblame', 'fern', 'selectprompt', 'selectresults']
