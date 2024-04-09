********************************************************************************
                                 CURL with Vim
********************************************************************************

.. image:: https://asciinema.org/a/XFnIGhMxETK4z1JhSI6qAferw.svg
  :target: https://asciinema.org/a/XFnIGhMxETK4z1JhSI6qAferw

Example rest api calls:

.. code::

  --url https://openlibrary.org/api/books?bibkeys=ISBN:0201558025,LCCN:93005405&format=json

  --url https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400

  --url https://httpbin.org/post
  --header "Content-Type: application/json"
  --data
  {
    "string": "hello world",
    "number": 69,
    "date": "2024-04-09"
  }


Common parameters for the rest of ``--url``:

.. code::

  --$url https://dog.ceo/api
  --$header "Content-Type: application/json"

  --url /breeds/list/all

  --url /breed/hound/images

One can add mappings to ``~/.vim/after/ftplugin/curl.vim``::

  nnoremap <buffer> <space><space>r :Curl<CR>
  xnoremap <buffer> <space><space>r :Curl<CR>
