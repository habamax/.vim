********************************************************************************
                                 Personal .vim
********************************************************************************


Personal vim configuration.


Scratches of Not Invented Here
==============================

vim-commentary__ alike comment toggling:

__ https://github.com/tpope/vim-commentary

.. code:: vim

  " Toggle comments
  " Usage:
  " Put the function into ~/.vim/autoload/comment.vim
  " Add following mappings to vimrc:
  " nnoremap <silent> <expr> gc comment#toggle()
  " xnoremap <silent> <expr> gc comment#toggle()
  " nnoremap <silent> <expr> gcc comment#toggle() . '_'
  func! comment#toggle(...)
      if a:0 == 0
          let &opfunc = matchstr(expand('<sfile>'), '[^. ]*$')
          return 'g@'
      endif
      if empty(&cms) | return | endif
      let cms = substitute(substitute(&cms, '\S\zs%s\s*', ' %s', ''), '%s\ze\S', '%s ', '')
      let [lnum1, lnum2] = [line("'["), line("']")]
      let cms_l = split(escape(cms, '*.'), '%s')
      if len(cms_l) == 0 | return | endif
      if len(cms_l) == 1 | call add(cms_l, '') | endif
      let comment = 0
      let indent_min = indent(lnum1)
      let indent_start = matchstr(getline(lnum1), '^\s*')
      for lnum in range(lnum1, lnum2)
          if getline(lnum) =~ '^\s*$' | continue | endif
          if indent_min > indent(lnum)
              let indent_min = indent(lnum)
              let indent_start = matchstr(getline(lnum), '^\s*')
          endif
          if getline(lnum) !~ '^\s*' . cms_l[0] . '.*' . cms_l[1] . '$'
              let comment = 1
          endif
      endfor
      let lines = []
      for lnum in range(lnum1, lnum2)
          if getline(lnum) =~ '^\s*$'
              let line = getline(lnum)
          elseif comment
              if exists("g:comment_first_col") || exists("b:comment_first_col")
                  let line = printf(cms, getline(lnum))
              else
                  let line = printf(indent_start . cms, strpart(getline(lnum), strlen(indent_start)))
              endif
          else
              let line = substitute(getline(lnum), '^\s*\zs'.cms_l[0].'\|'.cms_l[1].'$', '', 'g')
          endif
          call add(lines, line)
      endfor
      noautocmd keepjumps call setline(lnum1, lines)
  endfunc


Colors
======

- bronzage_: dark background, was thinking of zenburn while creating it.
- sugarlily_: white background, blue accents.
- saturnite_: dark background, variation of the awesome Apprentice_;
- freyeday_: light background, to complement ``saturnite``;
- alchemist_: dark background, variation of the awesome Apprentice_;
- psionic_: light background;
- gruvbit_: simplified variant of ``gruvbox_hard``;
- polar_: white background variantion of base16-one-light;
- habanight_: black background variation of base16-default-dark colorscheme.

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


Look'n'Feel
===========

.. image:: https://user-images.githubusercontent.com/234774/133601573-4b91eba9-4080-40f8-86ad-0826f2b494d7.gif
