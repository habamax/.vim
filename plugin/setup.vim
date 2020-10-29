""" Check after/plugin/setup.vim for settings that depends on plugin existence
""" Plugin settings


"" netrw
func! s:netrw_e() abort
    exe 'silent e ' .. expand("%:p:h")
    call search('\<'..expand("#:t")..'\>')
endfunc
nnoremap <silent> - :call <SID>netrw_e()<CR>
let g:netrw_banner = 0


"" vim-gutentags
if executable("ctags")
    silent! packadd vim-gutentags
endif


"" Git
if executable("git")
    silent! packadd vim-fugitive
    silent! packadd vim-flog
endif


"" vim-asciidoctor
" let g:asciidoctor_executable = 'bundle exec asciidoctor'
" let g:asciidoctor_pdf_executable = "bundle exec asciidoctor-pdf"

" use upstream asciidoctor-pdf
let g:asciidoctor_pdf_executable = printf("ruby %s/projects/asciidoctor-pdf/bin/asciidoctor-pdf",
            \ empty($DOCSHOME)?expand('~'):expand($DOCSHOME))

let g:asciidoctor_extensions = ['asciidoctor-diagram']
let g:asciidoctor_pdf_extensions = copy(g:asciidoctor_extensions)
let g:asciidoctor_pdf_themes_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes'
let g:asciidoctor_pdf_fonts_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes/fonts;GEM_FONTS_DIR'

" for OSX `pngpaste` could be used.
let g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
let g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

let g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json', 'xml']
let g:asciidoctor_css = 'asciidoctor-next.min.css'
let g:asciidoctor_css_path = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.asciidoctor-themes'

let g:asciidoctor_pandoc_other_params = '--toc'
let g:asciidoctor_pandoc_data_dir = (empty($DOCSHOME)?expand('~'):expand($DOCSHOME)) . '/docs/.pandoc'

let g:asciidoctor_syntax_conceal = 1
" let g:asciidoctor_folding = 1
" let g:asciidoctor_fold_options = 1


"" vim-swap
let g:swap_no_default_key_mappings = 1


"" vim-rooter
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', '.hg', '.svn', 'Makefile', 'go.mod', 'mix.exs']

let g:rooter_silent_chdir = 1


"" vim-markdown
let g:markdown_folding = 0
let g:markdown_fenced_languages = ['python', 'go']


"" vim-dispatch
let g:dispatch_no_maps = 1
" tmux in alacritty wsl debian makes vim "bad" sized in the end
" vim doesn't resize back after tmux pane is closed.
" let g:dispatch_no_tmux_make = 1


"" vim-closetag
let g:closetag_filetypes = 'html,xhtml,xml'


"" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(LiveEasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"" vim-rest-console
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



""" elixir
let g:elixir_mix_test_position = "bottom"
let g:mix_format_on_save = 1



""" outline
augroup do_outline | au!
    au BufRead,BufNewFile *.adoc,*.md nnoremap <buffer> <space><space>l :DoOutline<CR>
augroup end


""" YCM, Coc or mucomplete
call timer_start(2000, {-> lsp#setup('ycm')})


""" Colorizer
let g:colorizer_auto_filetype='css,html,colortemplate'
let g:colorizer_disable_bufleave = 1


""" Fern
nnoremap <silent> <F8> :Fern . -drawer -toggle -reveal=%<CR>
nnoremap <silent> <F9> :FernDo :<CR>


""" vim-godot
let g:godot_ext_hl = v:false


""" listopad
let g:listopad_auto_archive = 1
xmap <space>x  <Plug>(ListopadToggleCheckboxOp)
nmap <space>x  <Plug>(ListopadToggleCheckboxOp)
omap <space>x  <Plug>(ListopadToggleCheckboxOp)
nmap <space>xx <Plug>(ListopadToggleCheckboxLineOp)


""" evalvim
xmap <space>v <Plug>(EvalVim)
nmap <space>v <Plug>(EvalVim)
omap <space>v <Plug>(EvalVim)
nmap <space>vv <Plug>(EvalVimLine)


""" lens
let g:lens_disabled_filetypes = ['fugitiveblame', 'fern', 'selectprompt', 'selectresults']
