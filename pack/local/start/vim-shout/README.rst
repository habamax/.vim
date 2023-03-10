~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   VIM-SHOUT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Run and Capture Shell Command Output
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

  Should work with Vim9 (compiled with ``HUGE`` featurs).


I always wanted a simpler way to run an arbitrary shell commands with the output
being captured into some throwaway buffer. Mostly for the simple scripting
(press a button, script is executed and the output is immediately visible).

I have used (and still use) relevant builtin commands (``:make``, ``:!cmd``,
``:r !cmd`` and all the jazz with quickfix/location-list windows) but ... I
didn't feel it worked my way.

This works my way though.

.. image:: https://asciinema.org/a/DaVumBuy1qtyXoIsNveok70dF.svg
  :target: https://asciinema.org/a/DaVumBuy1qtyXoIsNveok70dF


Mappings
========

In a ``[shout]`` buffer:

:kbd:`Enter`
  - While on line 1, re-execute the command.
  - Switch (open) to the file under cursor.

:kbd:`Space` + :kbd:`Enter`
  Open file under cursor in a new tabpage.

:kbd:`CTRL-C`
  Kill the shell command


Commands
========

``:Sh {command}``
  Start ``{command}`` in background, open existing ``[shout]`` buffer or create
  a new one and print output of ``stdout`` and ``stderr`` there.
  Put cursor to the end of buffer.

  .. code::

    :Sh ls -lah
    :Sh make
    :Sh python

``:Sh! {command}``
  Same as ``Sh`` but keep cursor on line 1.

  .. code::

    :Sh! rg -nS --column "\b(TODO|FIXME|XXX):" .


Examples of User Commands
=========================

``:Rg searchpattern``, search using ripgrep::

  command! -nargs=1 Rg Sh! rg -nS --column "<args>" .

``:Todo``, search for all TODOs, FIXMEs and XXXs using ripgrep::

  command! -nargs=0 Todo Sh! rg -nS --column "\b(TODO|FIXME|XXX):" .


Examples of User Mappings
=========================

Search word under cursor::

  nnoremap <space>8 <scriptcmd>exe "Rg" expand("<cword>")<cr>

Run python script (put into ``~/.vim/after/ftplugin/python.vim``)::

  nnoremap <buffer> <F5> <scriptcmd>exe "Sh python" expand("%:p")<cr>

Build and run rust project (put into ``~/.vim/after/ftplugin/rust.vim``)::

  nnoremap <buffer> <F5> <scriptcmd>Sh cargo run<cr>
  nnoremap <buffer> <F6> <scriptcmd>Sh cargo build<cr>
  nnoremap <buffer> <F7> <scriptcmd>Sh cargo build --release<cr>


Options
=======

``g:shout_main_win_mode``
  Controls the way ``[shout]`` buffer is opened, by default it is opened o
  is ``"botright vertical"`` and could be one of:

  - ``""`` — default split;
  - ``"vertical"`` — vertical split;
  - ``"topleft"`` — split on top, take full vim width;
  - ``"botright"`` — split on bottom, take full vim width
  - ``"botright vertical"`` — default, split on right, take full vim height.
