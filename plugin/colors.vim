vim9script

if !has('gui_running')
    set termguicolors
endif

g:colors = ["habamax", "xamabah"]

def Habamax()
    if !has("gui_running")
        hi Normal guibg=NONE ctermbg=NONE
    endif
    if has("gui_running") || &termguicolors
        hi DiffAdd guibg=#002f00 guifg=NONE gui=NONE cterm=NONE
        hi DiffChange guibg=#1f2f3f guifg=NONE gui=NONE cterm=NONE
        hi DiffDelete guibg=#3f1f00 guifg=#585858 gui=NONE cterm=NONE
    else
        hi DiffAdd cterm=reverse
        hi DiffChange cterm=reverse
        hi DiffDelete cterm=reverse
    endif
enddef

def Xamabah()
    if !(has("gui_running") || &termguicolors)
        return
    endif
    var colors = [
        {
            normal: "#d7d5d0",
            colorLine: "#e4e2dd",
            pmenu: "#eeece7",
            pmenusel: "#fffdf8",
            nontext: "#9e9c97",
        },
        {
            normal: "#d7d0d7",
            colorLine: "#e4dde4",
            pmenu: "#eee7ee",
            pmenusel: "#fff8ff",
            nontext: "#9e979e",
        },
        {
            normal: "#d0d5d7",
            colorLine: "#dde2e4",
            pmenu: "#e7ecee",
            pmenusel: "#f8fdff",
            nontext: "#979c9e",
        },
        {
            normal: "#d7d0d0",
            colorLine: "#e4dddd",
            pmenu: "#eee7e7",
            pmenusel: "#fff8f8",
            nontext: "#9e9797",
        },
    ]
    var idx = strftime("%w")->str2nr()
    if idx < 2 || idx > 5
        return
    endif
    idx -= 2
    # var idx = rand(srand()) % (len(colors) + 1)
    # if idx == len(colors)
    #     return
    # endif
    var c = colors[idx]
    exe "hi Normal guibg=" .. c.normal
    exe "hi CursorLine guibg=" .. c.colorLine
    exe "hi CursorColumn guibg=" .. c.colorLine
    exe "hi Pmenu guibg=" .. c.pmenu
    exe "hi PmenuSel guibg=" .. c.pmenusel
    exe "hi PmenuKind guibg=" .. c.pmenu
    exe "hi PmenuKindSel guibg=" .. c.pmenusel
    exe "hi PmenuExtra guibg=" .. c.pmenu
    exe "hi PmenuExtraSel guibg=" .. c.pmenusel
    exe "hi PmenuMatch guibg=" .. c.pmenu
    exe "hi PmenuMatchSel guibg=" .. c.pmenusel
    exe "hi Folded guibg=" .. c.colorLine
    exe "hi ColorColumn guibg=" .. c.colorLine
    exe "hi LineNr guifg=" .. c.nontext
    exe "hi NonText guifg=" .. c.nontext
    exe "hi FoldColumn guifg=" .. c.nontext
    exe "hi SpecialKey guifg=" .. c.nontext
enddef

def WindowsTerminalTheme(): string
    var settings_file = "/mnt/c/Users/maxim.kim/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    var theme = system($"jq '.profiles.defaults.colorScheme' {settings_file}")
    return theme->trim()->trim('"')
enddef

def ChangeWindowsTerminalTheme(colorscheme: string)
    if !(colorscheme == "habamax" || colorscheme == "xamabah")
        echoerr "Only works for habamax and xamabah"
        return
    endif
    if !exists("$WSLENV")
        return
    endif
    var settings_file = "/mnt/c/Users/maxim.kim/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    var tmp_settings = tempname()
    var jq = "jq '"
    jq ..= $'.profiles.defaults.colorScheme="{colorscheme}"'
    if colorscheme == 'xamabah'
        var bg = hlget("normal")[0].guibg
        jq ..= " | "
        jq ..= $'(.schemes[] | select(.name=="xamabah") | .background)="{bg}"'
    endif
    jq ..= "'"
    system($'{jq} "{settings_file}" > "{tmp_settings}"')
    system($'mv "{tmp_settings}" "{settings_file}"')
enddef

augroup colors | au!
    au Colorscheme * hi link lspDiagSignErrorText Removed
    au Colorscheme * hi link lspDiagVirtualTextError Removed
    au Colorscheme * hi link lspDiagSignWarningText Changed
    au Colorscheme * hi link lspDiagVirtualTextWarning Changed
    au Colorscheme habamax Habamax()
    au Colorscheme xamabah Xamabah()
    au Colorscheme habamax,xamabah hi VertSplit guibg=NONE ctermfg=NONE
    au Colorscheme habamax,xamabah ChangeWindowsTerminalTheme(expand("<amatch>"))
augroup END

if has("win32") && has("gui_running")
    exe "silent! colorscheme" g:colors[1]
elseif exists("$WSLENV")
    exe "silent! colorscheme" WindowsTerminalTheme()
else
    exe "silent! colorscheme" g:colors[0]
endif

# finish

# helper commands and mappings to work with vim/colorschemes
command! ColoCheck ru colors/tools/check_colors.vim
command! ColoMisc  tabnew | ru colors/tools/sample_misc.vim
command! ColoMess  ru colors/tools/sample_messages.vim
command! -nargs=1 -complete=color Colo exe "ru legacy_colors/" .. <q-args> .. ".vim"
command! ColoDiff  tabnew | ru colors/tools/sample_diff.vim
command! ColoQF    tabnew | ru colors/tools/sample_quickfix.vim
command! ColoTerm  tabnew | ru colors/tools/sample_terminal.vim
command! ColoWin   tabnew | ru colors/tools/sample_windows.vim
command! ColoPopu  tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu.vim
command! ColoPopuKind  tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_popupmenu_kind.vim
command! ColoSpell tabnew |
      \ exe "lcd " .. fnamemodify($MYVIMRC, ":p:h") .. "/pack/bundle/start/colorschemes" |
      \ ru colors/tools/sample_spell.vim
