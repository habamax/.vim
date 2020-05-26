" Name: Gruvmin (gruvbox simplified GUI colorscheme)
" Desc: Retro groove colorscheme originally designed by morhetz <morhetz@gmail.com>
" Author: Maxim Kim <habamax@gmail.com>

hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'gruvmin'

if &background ==# 'dark'
    if has('nvim')
        let g:terminal_color_0 = '#282828'
        let g:terminal_color_1 = '#cc241d'
        let g:terminal_color_2 = '#98971a'
        let g:terminal_color_3 = '#d79921'
        let g:terminal_color_4 = '#458588'
        let g:terminal_color_5 = '#b16286'
        let g:terminal_color_6 = '#689d6a'
        let g:terminal_color_7 = '#a89984'
        let g:terminal_color_8 = '#928374'
        let g:terminal_color_9 = '#fb4934'
        let g:terminal_color_10 = '#b8bb26'
        let g:terminal_color_11 = '#fabd2f'
        let g:terminal_color_12 = '#83a598'
        let g:terminal_color_13 = '#d3869b'
        let g:terminal_color_14 = '#8ec07c'
        let g:terminal_color_15 = '#ebdbb2'
    else
        let g:terminal_ansi_colors = [
                    \ '#282828', '#cc241d', '#98971a', '#d79921',
                    \ '#458588', '#b16286', '#689d6a', '#a89984',
                    \ '#928374', '#fb4934', '#b8bb26', '#fabd2f',
                    \ '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']
    endif
    if get(g:, 'gruvhab_transparent', 0) && !has('gui_running')
        hi Normal guifg=#ebdbb2 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    else
        hi Normal guifg=#ebdbb2 guibg=#282828 guisp=NONE gui=NONE cterm=NONE
    endif
    hi CursorLineNr guifg=#fabd2f guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi FoldColumn guifg=#928374 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi SignColumn guifg=#ebdbb2 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi VertSplit guifg=#504945 guibg=#504945 guisp=NONE gui=NONE cterm=NONE
    hi ColorColumn guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi Comment guifg=#928374 guibg=NONE guisp=NONE gui=italic cterm=italic
    hi CursorLine guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi Error guifg=#fb4934 guibg=#282828 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hi ErrorMsg guifg=#282828 guibg=#fb4934 guisp=NONE gui=bold cterm=bold
    hi Folded guifg=#928374 guibg=#3c3836 guisp=NONE gui=italic cterm=italic
    hi LineNr guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi MatchParen guifg=NONE guibg=#665c54 guisp=NONE gui=bold,underline cterm=bold,underline
    hi NonText guifg=#504945 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Pmenu guifg=#ebdbb2 guibg=#504945 guisp=NONE gui=NONE cterm=NONE
    hi PmenuSbar guifg=NONE guibg=#504945 guisp=NONE gui=NONE cterm=NONE
    hi PmenuSel guifg=#504945 guibg=#83a598 guisp=NONE gui=bold cterm=bold
    hi PmenuThumb guifg=NONE guibg=#7c6f64 guisp=NONE gui=NONE cterm=NONE
    hi SpecialKey guifg=#928374 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi StatusLine guifg=#ebdbb2 guibg=#504945 guisp=NONE gui=bold cterm=bold
    hi StatusLineNC guifg=#a89984 guibg=#504945 guisp=NONE gui=NONE cterm=NONE
    hi TabLine guifg=#7c6f64 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi TabLineFill guifg=#7c6f64 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi TabLineSel guifg=#b8bb26 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    hi ToolbarButton guifg=#fbf1c7 guibg=#665c54 guisp=NONE gui=bold cterm=bold
    hi ToolbarLine guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE
    hi Visual guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE
    hi WildMenu guifg=#83a598 guibg=#504945 guisp=NONE gui=bold cterm=bold
    hi Conceal guifg=#83a598 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
    hi DiffAdd guifg=#b8bb26 guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi DiffChange guifg=#8ec07c guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi DiffDelete guifg=#fb4934 guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi DiffText guifg=#fabd2f guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi Directory guifg=#b8bb26 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi EndOfBuffer guifg=#504945 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi IncSearch guifg=#fe8019 guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi ModeMsg guifg=#fabd2f guibg=NONE guisp=NONE gui=bold cterm=bold
    hi MoreMsg guifg=#fabd2f guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Question guifg=#fe8019 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Search guifg=#fabd2f guibg=#282828 guisp=NONE gui=reverse cterm=reverse
    hi SpellBad guifg=#fb4934 guibg=NONE guisp=#fb4934 gui=italic,undercurl cterm=italic,undercurl
    hi SpellCap guifg=#83a598 guibg=NONE guisp=#83a598 gui=italic,undercurl cterm=italic,undercurl
    hi SpellLocal guifg=#8ec07c guibg=NONE guisp=#8ec07c gui=italic,undercurl cterm=italic,undercurl
    hi SpellRare guifg=#d3869b guibg=NONE guisp=#d3869b gui=italic,undercurl cterm=italic,undercurl
    hi Title guifg=#b8bb26 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi WarningMsg guifg=#fb4934 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Boolean guifg=#d3869b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Character guifg=#d3869b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Conditional guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Constant guifg=#d3869b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Define guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Debug guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Delimiter guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Error guifg=#fb4934 guibg=#282828 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hi Exception guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Float guifg=#d3869b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Function guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Identifier guifg=#83a598 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Ignore guifg=fg guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Include guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Keyword guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Label guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Macro guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Number guifg=#d3869b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Operator guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi PreCondit guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi PreProc guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Repeat guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialChar guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialComment guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Statement guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi StorageClass guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Special guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi String guifg=#b8bb26 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Structure guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Todo guifg=fg guibg=#282828 guisp=NONE gui=bold,italic cterm=bold,italic
    hi Type guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Typedef guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Underlined guifg=#83a598 guibg=NONE guisp=NONE gui=underline cterm=underline
    hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
    if has('nvim')
        hi! link TermCursor Cursor
        hi TermCursorNC guifg=#3c3836 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    endif
else
    " Light background
    if has('nvim')
        let g:terminal_color_0 = '#fbf1c7'
        let g:terminal_color_1 = '#cc241d'
        let g:terminal_color_2 = '#98971a'
        let g:terminal_color_3 = '#d79921'
        let g:terminal_color_4 = '#458588'
        let g:terminal_color_5 = '#b16286'
        let g:terminal_color_6 = '#689d6a'
        let g:terminal_color_7 = '#7c6f64'
        let g:terminal_color_8 = '#928374'
        let g:terminal_color_9 = '#9d0006'
        let g:terminal_color_10 = '#79740e'
        let g:terminal_color_11 = '#b57614'
        let g:terminal_color_12 = '#076678'
        let g:terminal_color_13 = '#8f3f71'
        let g:terminal_color_14 = '#427b58'
        let g:terminal_color_15 = '#3c3836'
    else
        let g:terminal_ansi_colors = [
                    \ '#fbf1c7', '#cc241d', '#98971a', '#d79921',
                    \ '#458588', '#b16286', '#689d6a', '#7c6f64',
                    \ '#928374', '#9d0006', '#79740e', '#b57614',
                    \ '#076678', '#8f3f71', '#427b58', '#3c3836']
    endif
    if get(g:, 'gruvhab_transparent', 0) && !has('gui_running')
        hi Normal guifg=#3c3836 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    else
        hi Normal guifg=#3c3836 guibg=#fbf1c7 guisp=NONE gui=NONE cterm=NONE
    endif
    hi CursorLineNr guifg=#b57614 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi FoldColumn guifg=#928374 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi SignColumn guifg=#3c3836 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi VertSplit guifg=#d5c4a1 guibg=#d5c4a1 guisp=NONE gui=NONE cterm=NONE
    hi ColorColumn guifg=NONE guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi Comment guifg=#928374 guibg=NONE guisp=NONE gui=italic cterm=italic
    hi CursorLine guifg=NONE guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi Error guifg=#9d0006 guibg=#fbf1c7 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hi ErrorMsg guifg=#fbf1c7 guibg=#9d0006 guisp=NONE gui=bold cterm=bold
    hi Folded guifg=#928374 guibg=#ebdbb2 guisp=NONE gui=italic cterm=italic
    hi LineNr guifg=#a89984 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi MatchParen guifg=NONE guibg=#bdae93 guisp=NONE gui=bold,underline cterm=bold,underline
    hi NonText guifg=#d5c4a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Pmenu guifg=#3c3836 guibg=#d5c4a1 guisp=NONE gui=NONE cterm=NONE
    hi PmenuSbar guifg=NONE guibg=#d5c4a1 guisp=NONE gui=NONE cterm=NONE
    hi PmenuSel guifg=#d5c4a1 guibg=#076678 guisp=NONE gui=bold cterm=bold
    hi PmenuThumb guifg=NONE guibg=#a89984 guisp=NONE gui=NONE cterm=NONE
    hi SpecialKey guifg=#928374 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi StatusLine guifg=#3c3836 guibg=#d5c4a1 guisp=NONE gui=bold cterm=bold
    hi StatusLineNC guifg=#7c6f64 guibg=#d5c4a1 guisp=NONE gui=NONE cterm=NONE
    hi TabLine guifg=#a89984 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi TabLineFill guifg=#a89984 guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi TabLineSel guifg=#79740e guibg=#ebdbb2 guisp=NONE gui=NONE cterm=NONE
    hi ToolbarButton guifg=#282828 guibg=#bdae93 guisp=NONE gui=bold cterm=bold
    hi ToolbarLine guifg=NONE guibg=#bdae93 guisp=NONE gui=NONE cterm=NONE
    hi Visual guifg=NONE guibg=#bdae93 guisp=NONE gui=NONE cterm=NONE
    hi WildMenu guifg=#076678 guibg=#d5c4a1 guisp=NONE gui=bold cterm=bold
    hi Conceal guifg=#076678 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
    hi DiffAdd guifg=#79740e guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi DiffChange guifg=#427b58 guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi DiffDelete guifg=#9d0006 guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi DiffText guifg=#b57614 guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi Directory guifg=#79740e guibg=NONE guisp=NONE gui=bold cterm=bold
    hi EndOfBuffer guifg=#d5c4a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi IncSearch guifg=#af3a03 guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi ModeMsg guifg=#b57614 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi MoreMsg guifg=#b57614 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Question guifg=#af3a03 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Search guifg=#b57614 guibg=#fbf1c7 guisp=NONE gui=reverse cterm=reverse
    hi SpellBad guifg=#9d0006 guibg=NONE guisp=#9d0006 gui=italic,undercurl cterm=italic,undercurl
    hi SpellCap guifg=#076678 guibg=NONE guisp=#076678 gui=italic,undercurl cterm=italic,undercurl
    hi SpellLocal guifg=#427b58 guibg=NONE guisp=#427b58 gui=italic,undercurl cterm=italic,undercurl
    hi SpellRare guifg=#8f3f71 guibg=NONE guisp=#8f3f71 gui=italic,undercurl cterm=italic,undercurl
    hi Title guifg=#79740e guibg=NONE guisp=NONE gui=bold cterm=bold
    hi WarningMsg guifg=#9d0006 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Boolean guifg=#8f3f71 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Character guifg=#8f3f71 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Conditional guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Constant guifg=#8f3f71 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Define guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Debug guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Delimiter guifg=#af3a03 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Error guifg=#9d0006 guibg=#fbf1c7 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hi Exception guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Float guifg=#8f3f71 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Function guifg=#79740e guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Identifier guifg=#076678 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Ignore guifg=fg guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Include guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Keyword guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Label guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Macro guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Number guifg=#8f3f71 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Operator guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi PreCondit guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi PreProc guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Repeat guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialChar guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialComment guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Statement guifg=#9d0006 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi StorageClass guifg=#af3a03 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Special guifg=#af3a03 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi String guifg=#79740e guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Structure guifg=#427b58 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Todo guifg=fg guibg=#fbf1c7 guisp=NONE gui=bold,italic cterm=bold,italic
    hi Type guifg=#b57614 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Typedef guifg=#b57614 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Underlined guifg=#076678 guibg=NONE guisp=NONE gui=underline cterm=underline
    hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
    if has('nvim')
        hi! link TermCursor Cursor
        hi TermCursorNC guifg=#ebdbb2 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE
    endif
endif



hi! link CursorColumn CursorLine
hi! link QuickFixLine Search
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link VisualNOS Visual
hi! link Tag Special
hi! link lCursor Cursor
hi! link iCursor Cursor
hi! link vCursor Cursor
