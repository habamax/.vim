vim9script

b:undo_ftplugin ..= ' | setl complete<'

const hi_groups = [
    {name: 'ColorColumn', desc: "Used for the columns set with 'colorcolumn'."},
    {name: 'Conceal', desc: "Placeholder characters substituted for concealed text (see 'conceallevel')."},
    {name: 'Cursor', desc: "Character under the cursor."},
    {name: 'lCursor', desc: "Character under the cursor when |language-mapping| is used (see 'guicursor')."},
    {name: 'CursorIM', desc: "Like Cursor, but used when in IME mode. |CursorIM|"},
    {name: 'CursorColumn', desc: "Screen column that the cursor is in when 'cursorcolumn' is set."},
    {name: 'CursorLine', desc: "Screen line that the cursor is in when 'cursorline' is set."},
    {name: 'Directory', desc: "Directory names (and other special names in listings)."},
    {name: 'DiffAdd', desc: "Diff mode: Added line. |diff.txt|"},
    {name: 'DiffChange', desc: "Diff mode: Changed line. |diff.txt|"},
    {name: 'DiffDelete', desc: "Diff mode: Deleted line. |diff.txt|"},
    {name: 'DiffText', desc: "Diff mode: Changed text within a changed line. |diff.txt|"},
    {name: 'DiffTextAdd', desc: "Diff mode: Added text within a changed line.  Linked to |hl-DiffText| by default. |diff.txt|"},
    {name: 'EndOfBuffer', desc: "Filler lines (~) after the last line in the buffer. By default, this is highlighted like |hl-NonText|."},
    {name: 'ErrorMsg', desc: "Error messages on the command line."},
    {name: 'VertSplit', desc: "Column separating vertically split windows."},
    {name: 'Folded', desc: "Line used for closed folds."},
    {name: 'FoldColumn', desc: "'foldcolumn'"},
    {name: 'SignColumn', desc: "Column where |signs| are displayed."},
    {name: 'IncSearch', desc: '''incsearch'' highlighting; also used for the text replaced with ":s///c".'},
    {name: 'LineNr', desc: 'Line number for ":number" and ":#" commands, and when ''number'' or ''relativenumber'' option is set.'},
    {name: 'LineNrAbove', desc: "Line number for when the 'relativenumber' option is set, above the cursor line."},
    {name: 'LineNrBelow', desc: "Line number for when the 'relativenumber' option is set, below the cursor line."},
    {name: 'CursorLineNr', desc: 'Like LineNr when ''cursorline'' is set and ''cursorlineopt'' contains "number" or is "both", for the cursor line.'},
    {name: 'CursorLineFold', desc: "Like FoldColumn when 'cursorline' is set for the cursor line."},
    {name: 'CursorLineSign', desc: "Like SignColumn when 'cursorline' is set for the cursor line."},
    {name: 'MatchParen', desc: "Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|"},
    {name: 'MessageWindow', desc: "Messages popup window used by `:echowindow`.  Linked to |hl-WarningMsg| by default."},
    {name: 'ModeMsg', desc: '''showmode'' message (e.g., "-- INSERT --").'},
    {name: 'MsgArea', desc: "Command-line area, also used for outputting messages, see also 'cmdheight'"},
    {name: 'MoreMsg', desc: "|more-prompt|"},
    {name: 'NonText', desc: '''@'' at the end of the window, "<<<" at the start of the window for ''smoothscroll'', characters from ''showbreak'' and other characters that do not really exist in the text, such as the ">" displayed when a double-wide character doesn''t fit at the end of the line.'},
    {name: 'Normal', desc: "Normal text."},
    {name: 'Pmenu', desc: "Popup menu: Normal item."},
    {name: 'PmenuSel', desc: "Popup menu: Selected item."},
    {name: 'PmenuKind', desc: 'Popup menu: Normal item "kind".'},
    {name: 'PmenuKindSel', desc: 'Popup menu: Selected item "kind".'},
    {name: 'PmenuExtra', desc: 'Popup menu: Normal item "extra text".'},
    {name: 'PmenuExtraSel', desc: 'Popup menu: Selected item "extra text".'},
    {name: 'PmenuSbar', desc: "Popup menu: Scrollbar."},
    {name: 'PmenuThumb', desc: "Popup menu: Thumb of the scrollbar."},
    {name: 'PmenuMatch', desc: "Popup menu: Matched text in normal item. Applied in combination with |hl-Pmenu|."},
    {name: 'PmenuMatchSel', desc: "Popup menu: Matched text in selected item. Applied in combination with |hl-PmenuSel|."},
    {name: 'ComplMatchIns', desc: "Matched text of the currently inserted completion."},
    {name: 'PopupSelected', desc: "Popup window created with |popup_menu()|.  Linked to |hl-PmenuSel| by default."},
    {name: 'PopupNotification', desc: "Popup window created with |popup_notification()|.  Linked to |hl-WarningMsg| by default."},
    {name: 'Question', desc: "|hit-enter| prompt and yes/no questions."},
    {name: 'QuickFixLine', desc: "Current |quickfix| item in the quickfix window."},
    {name: 'Search', desc: "Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out."},
    {name: 'CurSearch', desc: "Current match for the last search pattern (see 'hlsearch'). Note: This is correct after a search, but may get outdated if changes are made or the screen is redrawn."},
    {name: 'SpecialKey', desc: 'Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, ''listchars''. Generally: Text that is displayed differently from what it really is.'},
    {name: 'SpellBad', desc: "Word that is not recognized by the spellchecker. |spell| This will be combined with the highlighting used otherwise."},
    {name: 'SpellCap', desc: "Word that should start with a capital. |spell| This will be combined with the highlighting used otherwise."},
    {name: 'SpellLocal', desc: "Word that is recognized by the spellchecker as one that is used in another region. |spell| This will be combined with the highlighting used otherwise."},
    {name: 'SpellRare', desc: "Word that is recognized by the spellchecker as one that is hardly ever used. |spell| This will be combined with the highlighting used otherwise."},
    {name: 'StatusLine', desc: "Status line of current window."},
    {name: 'StatusLineNC', desc: 'Status lines of not-current windows Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.'},
    {name: 'StatusLineTerm', desc: "Status line of current window, if it is a |terminal| window."},
    {name: 'StatusLineTermNC', desc: "Status lines of not-current windows that is a |terminal| window."},
    {name: 'TabLine', desc: "Tab pages line, not active tab page label."},
    {name: 'TabLineFill', desc: "Tab pages line, where there are no labels."},
    {name: 'TabLineSel', desc: "Tab pages line, active tab page label."},
    {name: 'TabPanel', desc: "TabPanel, not active tab page label."},
    {name: 'TabPanelFill', desc: "TabPanel, where there are no labels."},
    {name: 'TabPanelSel', desc: "TabPanel, active tab page label."},
    {name: 'Terminal', desc: "|terminal| window (see |terminal-size-color|)."},
    {name: 'Title', desc: 'Titles for output from ":set all", ":autocmd" etc.'},
    {name: 'Visual', desc: "Visual mode selection."},
    {name: 'VisualNOS', desc: 'Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui''s |gui-x11| and |xterm-clipboard| supports this.'},
    {name: 'WarningMsg', desc: "Warning messages."},
    {name: 'WildMenu', desc: "Current match in 'wildmenu' completion."},
    {name: 'WildMenu', desc: "Current match in 'wildmenu' completion."},
    {name: 'Constant', desc: "Any constant."},
    {name: 'String', desc: 'A string constant: "this is a string".'},
    {name: 'Character', desc: "A character constant: 'c', '\n'."},
    {name: 'Number', desc: "A number constant: 234, 0xff."},
    {name: 'Boolean', desc: "A boolean constant: TRUE, false."},
    {name: 'Float', desc: "A floating point constant: 2.3e10."},
    {name: 'Identifier', desc: "Any variable name."},
    {name: 'Function', desc: "Function name (also: methods for classes)."},
    {name: 'Statement', desc: "Any statement."},
    {name: 'Conditional', desc: "if, then, else, endif, switch, etc."},
    {name: 'Repeat', desc: "for, do, while, etc."},
    {name: 'Label', desc: "case, default, etc."},
    {name: 'Operator', desc: '"sizeof", "+", "*", etc.'},
    {name: 'Keyword', desc: "Any other keyword"},
    {name: 'Exception', desc: "try, catch, throw"},
    {name: 'PreProc', desc: "Generic Preprocessor"},
    {name: 'Include', desc: "Preprocessor #include"},
    {name: 'Define', desc: "Preprocessor #define"},
    {name: 'Macro', desc: "Same as Define"},
    {name: 'PreCondit', desc: "Preprocessor #if, #else, #endif, etc."},
    {name: 'Type', desc: "int, long, char, etc."},
    {name: 'StorageClass', desc: "static, register, volatile, etc."},
    {name: 'Structure', desc: "struct, union, enum, etc."},
    {name: 'Typedef', desc: "A typedef"},
    {name: 'Special', desc: "Any special symbol."},
    {name: 'SpecialChar', desc: "Special character in a constant."},
    {name: 'Tag', desc: "You can use CTRL-] on this."},
    {name: 'Delimiter', desc: "Character that needs attention."},
    {name: 'SpecialComment', desc: "Special things inside a comment."},
    {name: 'Debug', desc: "Debugging statements."},
    {name: 'Underlined', desc: "Text that stands out, HTML links."},
    {name: 'Bold', desc: "Bold text."},
    {name: 'Italic', desc: "Italic text."},
    {name: 'BoldItalic', desc: "Bold and italic text."},
    {name: 'Ignore', desc: "Left blank, hidden  |hl-Ignore|."},
    {name: 'Error', desc: "Any erroneous construct."},
    {name: 'Todo', desc: "Anything that needs extra attention; mostly the keywords TODO, FIXME and XXX."},
    {name: 'Added', desc: "Added line in a diff."},
    {name: 'Changed', desc: "Changed line in a diff."},
    {name: 'Removed', desc: "Removed line in a diff."},
]

setl complete^=o^7
setl omnifunc=s:HighlightCompletor

def HighlightCompletor(findstart: number, base: string): any
    if findstart > 0
        var prefix = getline('.')->strpart(0, col('.') - 1)->matchstr('\k\+$')
        if prefix->empty()
            return -2
        endif
        return col('.') - prefix->len() - 1
    endif

    var items = hi_groups
        ->mapnew((_, v) => ({word: v.name, kind: 'H', info: v.desc, dup: 0}))
        ->matchfuzzy(base, {key: "word"})

    return items->empty() ? v:none : items
enddef

def Run()
    update
    Colortemplate!
    ColortemplateShow
enddef

nnoremap <buffer> <F5> <scriptcmd>Run()<CR>
