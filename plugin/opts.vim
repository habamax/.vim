vim9script
# Check after/plugin/ifloaded.vim for settings that depends on plugin existence
# Plugin settings

# turn off netrw
g:loaded_netrw = 1
g:loaded_netrwPlugin = 1

# popup
g:popup_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
g:popup_borderchars_t = ['─', '│', '─', '│', '├', '┤', '╯', '╰']
# g:popup_prompt = '🔍 '
# g:popup_prompt = '🔎 '

g:hlyank_hlgroup = "Pmenu"
g:hlyank_duration = 250

packadd comment
packadd nohlsearch
packadd hlyank
packadd matchit
packadd editorconfig

# Git
if executable("git")
    silent! packadd vim-fugitive
endif

if executable("ctags")
    silent! packadd vim-gutentags
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

# lens
g:lens_disabled_filetypes = ['fugitiveblame', 'selectprompt', 'selectresults']

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
    sh: ['sh'],
    sql: ['sql'],
    python: ['python'],
    json: ['json'],
    javascript: ['js'],
    perl: ['perl'],
    odin: ['odin'],
}

# godot, assuming it is installed as flatpak
if !executable('godot') && executable('flatpak')
    g:godot_executable = "flatpak run org.godotengine.Godot"
endif

# tex
g:tex_flavor = "latex"
g:tex_no_error = 1
g:tex_fast = "pbv"

# vim-sandwich, no default mappings
g:sandwich_no_default_key_mappings = 1
g:operator_sandwich_no_default_key_mappings = 1
g:textobj_sandwich_no_default_key_mappings = 1
