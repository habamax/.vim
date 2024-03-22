vim9script

# Zoom window: save and restore window layout
# Usage:
# Put following nnoremap into your .vimrc:
# import autoload 'zoom.vim'
# nnoremap <silent> <C-w>o <scriptcmd>zoom.Toggle()<CR>
#
# <C-w>o zoom window (there should be only 1 window)
# <C-w>o restores previous windows

# add bufnr to leaf
def AddBufToLayout(layout: list<any>)
  if layout[0] ==# 'leaf'
      # replace win_id with buffer number
      layout[1] = winbufnr(layout[1])
  else
      for child_layout in layout[1]
          AddBufToLayout(child_layout)
      endfor
  endif
enddef

def LayoutSave()
  t:zoom_winrestcmd = winrestcmd()
  t:zoom_layout = winlayout()
  t:zoom_cursor = [winnr(), getcurpos()]
  AddBufToLayout(t:zoom_layout)
enddef

def ApplyLayout(layout: list<any>)
  if layout[0] ==# 'leaf'
      # load buffer for leaf
      if bufexists(layout[1])
          exe $'b {layout[1]}'
          # help buffer needs special attention
          # otherwise it will be showing
          if &ft == 'help'
              set ft=help
              setlocal nobuflisted
              setlocal nomodifiable
              setlocal nonumber norelativenumber
              setlocal nofoldenable foldmethod=manual
              setlocal nolist nodiff nospell
              setlocal tabstop=8
              setlocal noarabic norightleft nobinary
              setlocal nocursorbind noscrollbind
          endif
      endif
  else
      # split cols or rows, split n-1 times
      var split_method = layout[0] ==# 'col' ? 'rightbelow split' : 'rightbelow vsplit'
      var wins = [win_getid()]
      for child_layout in layout[1][1 : ]
          exe split_method
          wins += [win_getid()]
      endfor

      # recursive into child windows
      for index in range(len(wins))
          win_gotoid(wins[index])
          ApplyLayout(layout[1][index])
      endfor
  endif
enddef

def LayoutRestore()
  if empty(get(t:, "zoom_layout", []))
      return
  endif

  # Close other windows
  silent wincmd o

  # recursively restore buffers
  ApplyLayout(get(t:, "zoom_layout"))

  # resize
  exe t:zoom_winrestcmd

  # goto saved window
  exe $":{t:zoom_cursor[0]}wincmd w"

  # set cursor
  setpos('.', t:zoom_cursor[1])
enddef

export def Toggle()
  if winnr('$') == 1 && get(t:, "zoom_zoomed", false)
      LayoutRestore()
      t:zoom_zoomed = false
  else
      t:zoom_zoomed = true
      LayoutSave()
      silent wincmd o
  endif
enddef
