vim9script
# Check after/plugin/if_loaded.vim for settings that depend on plugin existence
# Plugin settings

# turn off netrw
g:loaded_netrw = 1
g:loaded_netrwPlugin = 1

# popup
g:popup_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
g:popup_borderchars_t = ['─', '│', '─', '│', '├', '┤', '╯', '╰']

g:hlyank_hlgroup = "Visual"
g:hlyank_duration = 200
g:hlput_hlgroup = "Visual"
g:hlput_duration = 200
g:hlput_enable = true

packadd comment
packadd nohlsearch
packadd hlyank
packadd matchit
packadd editorconfig

# vim-closetag
g:closetag_filetypes = 'html,xhtml,xml'

# vim-markdown
g:markdown_fenced_languages = ['python', 'sql', 'json', 'vim', 'xml']

# typst
g:typst_embedded_languages = ['python', 'sql']

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

g:surround_pairs = {
    'd': ('[', ']'),
    'D': {pair: ('[ ', ' ]'), newline: 1},
    'v': {pair: ('<', '>'), newline: -1},
    'V': {pair: ('< ', ' >'), newline: 1},
    'g': {pair: ('"', '"'), newline: -1},
    'G': {pair: ('"""', '"""'), newline: 1},
    'q': {pair: ('‘', '’'), newline: -1},
    'Q': {pair: ('“', '”'), newline: -1},
    'w': {pair: ('‹', '›'), newline: -1},
    'W': {pair: ('«', '»'), newline: -1},
    'r': {pair: ('`', '`'), newline: -1},
    'R': {pair: ('```', '```'), newline: 1},
    'u': {pair: ('_', '_'), newline: -1},
    'U': {pair: ('__', '__'), newline: -1},
    'i': {pair: ('*', '*'), newline: -1},
    'I': {pair: ('**', '**'), newline: -1},
    'y': {pair: ('~', '~'), newline: -1},
    'Y': {pair: ('~~', '~~'), newline: -1},
    'p': {pair: ('|', '|'), newline: -1},
    'P': {pair: ('| ', ' |'), newline: -1},
    'e': {pair: ('$', '$'), newline: -1},
    'E': {pair: ('$ ', ' $'), newline: -1},
}
