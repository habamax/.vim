********************************************************************************
                                 CURL with Vim
********************************************************************************

.. image:: https://asciinema.org/a/651725.svg
  :target: https://asciinema.org/a/651725

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


cURL
====

There is a single command ``:Curl`` that creates and runs ``curl`` query out of
text under the cursor, capturing results into ``[cURL output]`` buffer.


Additional setup
================

One can add mappings to ``~/.vim/after/ftplugin/curl.vim``::

  nnoremap <buffer> <space><space>r :Curl<CR>
  xnoremap <buffer> <space><space>r :Curl<CR>

To format output I use following in ``~/.vim/after/ftplugin/json.vim``::

  vim9script

  setlocal expandtab shiftwidth=2

  import autoload 'dist/json.vim'
  setl formatexpr=json.FormatExpr()

  command -buffer -range=% Fmt json.FormatRange(<line1>, <line2>)

  if exists(":Fmt") == 2
      augroup Curl | au!
          autocmd User CurlOutput Fmt
      augroup END
  endif

User auto command ``CurlOutput`` is called from ``vim-curl`` after json is
detected in ``[cURL output]`` buffer.
