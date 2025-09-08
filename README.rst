********************************************************************************
                                 Personal .vim
********************************************************************************


Personal vim configuration.


Vimscript scratches
===================


Fuzzy Popup Finder
------------------

.. note::

  Vim has introduced improvements on command line complete (e.g.
  ``wildtrigger()``) so I am using regular commands with fuzzy matching instead.


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

If you would like to have it in a plugin, there is https://github.com/girishji/scope.vim.

Some of the examples:


Fuzzy file/buffer/MRU
"""""""""""""""""""""

.. image:: https://github.com/user-attachments/assets/9dc3d15a-4097-42c7-824a-e3b37dbdc1c6


Fuzzy project file finder
"""""""""""""""""""""""""

.. image:: https://github.com/user-attachments/assets/470d741c-3ee4-4daf-a007-de9bb8c55c64


Fuzzy help
""""""""""

.. image:: https://github.com/user-attachments/assets/9e0b718c-4645-4877-8ae8-c5e883b94e1c


Fuzzy TOC for TeX/Markdown/ReStructuredText
"""""""""""""""""""""""""""""""""""""""""""

.. image:: https://github.com/user-attachments/assets/36339dc3-efcc-4597-a46e-e8499163a6d3


Fuzzy highlight finder
""""""""""""""""""""""

.. image:: https://github.com/user-attachments/assets/2b3daece-9016-430f-b033-08d8c5751cc2



Commenting
----------

vim-commentary__ alike comment toggling is a very handy and convenient thing, so
"to make it safe and available" I did implement `my own version`__ which became
a `part of vim`__.

__ https://github.com/tpope/vim-commentary
__ https://github.com/habamax/.vim/blob/3256c3f33dad2be3b479aa198a68cf543dc8315e/autoload/comment.vim
__ https://github.com/vim/vim/commit/5400a5d4269874fe4f1c35dfdd3c039ea17dfd62


Toggle ColorColumn at cursor position
-------------------------------------

Sometimes you might need to edit table-like text, ``colorcolumn`` and
``vartabstop`` `could be helpful`__:

__ https://github.com/habamax/.vim/blob/9c134346affce6e5166fcaac39c58ef3960ca563/vimrc#L116-L146

.. image:: https://user-images.githubusercontent.com/234774/186644105-53985289-ccd6-43a0-9813-9dccda3f86eb.gif


Colors
======

- habamax_: dark colorscheme, *bundled with vim9*;
- wildcharm: dark/light colorscheme, quite colorful and contrast, *bundled with vim9*;
- lunaperche: dark/light colorscheme, bluish comments, bold statements, *bundled with vim9*;
- ... many more ...
- nod_: dark/light colorscheme, this should be the last one.

.. _habamax: https://github.com/habamax/vim-habamax
.. _nod: https://github.com/habamax/vim-nod
