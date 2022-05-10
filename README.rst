################################################################################
                                 Personal .vim
################################################################################


Personal vim configuration.


Vimscript scratches
===================

Commenting
----------

vim-commentary__ alike comment toggling:

__ https://github.com/tpope/vim-commentary

.. code:: vim

  vim9script

  # Toggle comments
  # Usage:
  #   1. Save in ~/.vim/autoload/comment.vim
  #   2. Add following mappings to vimrc:
  #      nnoremap <silent> <expr> gc comment#Toggle()
  #      xnoremap <silent> <expr> gc comment#Toggle()
  #      nnoremap <silent> <expr> gcc comment#Toggle() .. '_'
  export def Toggle(...args: list<string>): string
      if len(args) == 0
          &opfunc = matchstr(expand('<stack>'), '[^. ]*\ze[')
          return 'g@'
      endif
      if empty(&cms) | return '' | endif
      var cms = substitute(substitute(&cms, '\S\zs%s\s*', ' %s', ''), '%s\ze\S', '%s ', '')
      var [lnum1, lnum2] = [line("'["), line("']")]
      var cms_l = split(escape(cms, '*.'), '\s*%s\s*')
      if len(cms_l) == 0 | return '' | endif
      if len(cms_l) == 1 | call add(cms_l, '') | endif
      var comment = 0
      var indent_min = indent(lnum1)
      var indent_start = matchstr(getline(lnum1), '^\s*')
      for lnum in range(lnum1, lnum2)
          if getline(lnum) =~ '^\s*$' | continue | endif
          if indent_min > indent(lnum)
              indent_min = indent(lnum)
              indent_start = matchstr(getline(lnum), '^\s*')
          endif
          if getline(lnum) !~ '^\s*' .. cms_l[0] .. '.*' .. cms_l[1] .. '$'
              comment = 1
          endif
      endfor
      var lines = []
      var line = ''
      for lnum in range(lnum1, lnum2)
          if getline(lnum) =~ '^\s*$'
              line = getline(lnum)
          elseif comment
              if exists("g:comment_first_col") || exists("b:comment_first_col")
                  # handle % with substitute
                  line = printf(substitute(cms, '%s\@!', '%%', 'g'), getline(lnum))
              else
                  # handle % with substitute
                  line = printf(indent_start .. substitute(cms, '%s\@!', '%%', 'g'),
                          strpart(getline(lnum), strlen(indent_start)))
              endif
          else
              line = substitute(getline(lnum), '^\s*\zs' .. cms_l[0] .. ' \?\| \?' .. cms_l[1] .. '$', '', 'g')
          endif
          add(lines, line)
      endfor
      noautocmd keepjumps setline(lnum1, lines)
      return ''
  enddef


Background change
-----------------

Auto change ``&background`` in GUI Vim depending on time (check every 5 mins):

.. code:: vim

  vim9script

  if has("gui_running")
      def Lights()
          if !get(g:, "auto_bg", 1) | return | endif
          var hour = strftime("%H")->str2nr()
          var bg: string
          if hour > 8 && hour < 17
              bg = "light"
          else
              bg = "dark"
          endif
          if bg != &bg | &bg = bg | endif
      enddef
      Lights()
      if exists("g:lights_timer")
          timer_stop(g:lights_timer)
      endif
      g:lights_timer = timer_start(5 * 60000, (_) => Lights(), {repeat: -1})
  else
      if has("win32") | set t_Co=256 | endif
      set bg=dark
  endif
  # colorscheme should support both dark and light colors
  silent! colorscheme habamax


Colors
======

- habamax_: dark background, this should be really the last one;
- habaurora_: light background, graish;
- bronzage_: dark background, was thinking of zenburn while creating it;
- sugarlily_: white background, blue accents;
- saturnite_: dark background, variation of the awesome Apprentice_;
- freyeday_: light background, to complement ``saturnite``;
- alchemist_: dark background, variation of the awesome Apprentice_;
- psionic_: light background;
- gruvbit_: simplified variant of ``gruvbox_hard``;
- polar_: white background variantion of base16-one-light;
- habanight_: black background variation of base16-default-dark colorscheme.

.. _habamax: https://github.com/habamax/vim-habamax
.. _habaurora: https://github.com/habamax/vim-habaurora
.. _bronzage: https://github.com/habamax/vim-bronzage
.. _sugarlily: https://github.com/habamax/vim-sugarlily
.. _saturnite: https://github.com/habamax/vim-saturnite
.. _freyeday: https://github.com/habamax/vim-freyeday
.. _alchemist: https://github.com/habamax/vim-alchemist
.. _psionic: https://github.com/habamax/vim-psionic
.. _gruvbit: https://github.com/habamax/vim-gruvbit
.. _polar: https://github.com/habamax/vim-polar
.. _habanight: https://github.com/habamax/vim-habanight
.. _Apprentice: https://github.com/romainl/Apprentice
