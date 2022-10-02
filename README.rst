================================================================================
                                 Personal .vim
================================================================================


Personal vim configuration.


Vimscript scratches
===================


Fuzzy Popup Finder
------------------

Sometimes ago I have created `vim-select`_ plugin to simplify opening of
files/buffers and other things in vim. I was a happy user but then another
scratch of vimscript and I have a way simpler fuzzy popup finder that does most
of the things I need:

- A `wrapper function`__ to narrow down any list provided as a parameter to
  something you can select from.
- `Set of functions`__ that actually generate lists and "do things" over a selected
  item.
- `Mappings`__ that call those functions.

__ https://github.com/habamax/.vim/blob/9c134346affce6e5166fcaac39c58ef3960ca563/autoload/popup.vim#L49-L192
__ https://github.com/habamax/.vim/blob/master/autoload/fuzzy.vim
__ https://github.com/habamax/.vim/blob/9c134346affce6e5166fcaac39c58ef3960ca563/vimrc#L71-L92
.. _vim-select: https://github.com/habamax/vim-select

Some of the examples:


Fuzzy file/buffer/MRU
~~~~~~~~~~~~~~~~~~~~~

.. image:: https://user-images.githubusercontent.com/234774/186641098-d1f0f4ca-3396-4c8f-82ac-8de06f61cf0c.gif


Fuzzy project file finder
~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: https://user-images.githubusercontent.com/234774/186641084-9f9b4086-ea7b-4ee5-9ac8-32091e0412d5.gif


Fuzzy help
~~~~~~~~~~

.. image:: https://user-images.githubusercontent.com/234774/186641608-6cc2f280-deef-48cb-8e72-dc423ca31daa.gif


Fuzzy TOC for TeX/Markdown/ReStructuredText
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: https://user-images.githubusercontent.com/234774/186641087-ba2d0d5e-b057-4e69-a062-acdaa44fc29f.gif


Fuzzy highlight finder
~~~~~~~~~~~~~~~~~~~~~~

.. image:: https://user-images.githubusercontent.com/234774/186641079-4d4e41b1-ff9e-4a1f-b785-1554801fe244.gif



Commenting
----------

vim-commentary__ alike comment toggling is a very handy and convenient thing, so
"to make it safe and available" I did implement `my own version`__.

__ https://github.com/tpope/vim-commentary
__ https://github.com/habamax/.vim/blob/master/autoload/comment.vim


Toggle ColorColumn at cursor position
-------------------------------------

Sometimes you might need to edit table-like text, ``colorcolumn`` and
``vartabstop`` `could be helpful`__:

__ https://github.com/habamax/.vim/blob/9c134346affce6e5166fcaac39c58ef3960ca563/vimrc#L116-L146

.. image:: https://user-images.githubusercontent.com/234774/186644105-53985289-ccd6-43a0-9813-9dccda3f86eb.gif


Colors
======

- pire_: dual background, this should be really (x3) the last one (for the third
  time);
  *bundled with vim9*
- lunaperche: dual background, this should be really the last one (100%);
  *bundled with vim9*
- habamax_: dark background, this should be really the last one (not really);
  *bundled with vim9*
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

.. _pire: https://github.com/habamax/vim-pire
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
