vim9script
# Check after/plugin/opts.vim for settings that depends on plugin existence
# Plugin settings

# annoing for huge-line json like files, turn it off
g:loaded_matchparen = 1

# turn off netrw
g:loaded_netrw = 1
g:loaded_netrwPlugin = 1

packadd cfilter

# Git
if executable("git")
    silent! packadd vim-fugitive
    silent! packadd gv.vim
endif


# vim-asciidoctor
# use ruby bundler:
#     sudo gem install bundler
# goto docs directory and:
#     bundle install
g:asciidoctor_executable = 'bundle exec asciidoctor'
g:asciidoctor_pdf_executable = "bundle exec asciidoctor-pdf"

g:asciidoctor_extensions = ['asciidoctor-diagram']
g:asciidoctor_pdf_extensions = copy(g:asciidoctor_extensions)
g:asciidoctor_pdf_themes_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes'
g:asciidoctor_pdf_fonts_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes/fonts;GEM_FONTS_DIR'

# for OSX `pngpaste` could be used.
g:asciidoctor_img_paste_command = 'gm convert clipboard: %s%s'
g:asciidoctor_img_paste_pattern = 'img_%s_%s.png'

g:asciidoctor_fenced_languages = ['python', 'vim', 'sql', 'json', 'xml']
# g:asciidoctor_css = 'asciidoctor-next.min.css'
# g:asciidoctor_css_path = expand($DOCS ?? '~/docs') .. '/.asciidoctor-themes'

g:asciidoctor_pandoc_other_params = '--toc'
g:asciidoctor_pandoc_data_dir = expand($DOCS ?? '~/docs') .. '/.pandoc'

g:asciidoctor_syntax_conceal = 0
# g:asciidoctor_folding = 1
# g:asciidoctor_foldtitle_as_h1 = 0
# g:asciidoctor_fold_options = 1


# vim-swap
g:swap_no_default_key_mappings = 1


# vim-rooter
g:rooter_change_directory_for_non_project_files = ''
g:rooter_patterns = ['.git', '.hg', '.svn',
        'Makefile', 'go.mod', 'mix.exs', 'package.json']

g:rooter_silent_chdir = 1


# vim-markdown
g:markdown_fenced_languages = ['python', 'go']


# vim-closetag
g:closetag_filetypes = 'html,xhtml,xml'


# elixir
g:elixir_mix_test_position = "bottom"
g:mix_format_on_save = 1


# Colorizer
g:colorizer_auto_filetype = 'css,html,colortemplate'
g:colorizer_disable_bufleave = 1


# vim-godot
g:godot_ext_hl = v:false


# lens
g:lens_disabled_filetypes = ['fugitiveblame', 'selectprompt', 'selectresults']


# vimtex
g:vimtex_compiler_latexrun_engines = {'_': 'lualatex'}
g:vimtex_compiler_latexmk_engines = {'_': '-lualatex'}
g:vimtex_compiler_latexmk = {
    build_dir: () => expand("%:t:r"),
    options: [
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    ],
}
g:vimtex_syntax_packages = {'minted': {'load': 1}}
g:vimtex_toc_config = {
    show_help: 0,
    layer_keys: {content: 'C',
          label: 'B',
          todo: 'T',
          include: 'I'
    }
}


# vim-rst
g:rst2html_opts = "--input-encoding=utf8"
               .. " --smart-quotes=yes"
               .. " --strip-comments"
               .. " --syntax-highlight=short"
               .. " --template=" .. expand($DOCS ?? '~/docs') .. "/.docutils/habamax.txt"
               .. " --stylesheet-path=minimal.css,responsive.css,"
               .. expand($DOCS ?? '~/docs') .. "/.docutils/habamax.css,"
               .. expand($DOCS ?? '~/docs') .. "/.docutils/pygment.css"

g:rst_syntax_code_list = {
    vim: ['vim'],
    sql: ['sql'],
    python: ['python'],
    json: ['json'],
    javascript: ['js'],
    elixir: ['elixir'],
}


# vim-sandwich, mimic vim-surround mappings
g:sandwich_no_default_key_mappings = 1
g:operator_sandwich_no_default_key_mappings = 1
g:textobj_sandwich_no_default_key_mappings = 1
nmap ys <Plug>(sandwich-add)
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> yss <Plug>(sandwich-add)<SID>line
nmap ds <Plug>(sandwich-delete)
nmap dss <Plug>(sandwich-delete-auto)
nmap cs <Plug>(sandwich-replace)
nmap css <Plug>(sandwich-replace-auto)
xmap S <Plug>(sandwich-add)


# ALE
g:ale_virtualtext_cursor = 1
