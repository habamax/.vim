# CURL with Vim

Example rest api calls:

```
--url https://openlibrary.org/api/books?bibkeys=ISBN:0201558025,LCCN:93005405&format=json

--url https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400

# --jq is not curl parameter. If added, curl output would be piped through jq
--url https://httpbin.org/post
--header "Content-Type: application/json"
--jq
--data
{
"string": "hello world",
"number": 69,
"date": "2024-04-09"
}
```

Common parameters for the rest of `--url`:

.. code::

  --$url https://dog.ceo/api
  --$header "Content-Type: application/json"
  --$jq

  --url /breeds/list/all

  --url /breed/hound/images


## cURL

There is a single command `:Curl` that creates and runs `curl` query out of
text under the cursor.

If `:Curl!` is used, the curl command is copied to `+` register (clipboard).


## Additional setup

One can add mappings to `~/.vim/after/ftplugin/curl.vim`:

```
nnoremap <buffer> <space><space>r :Curl<CR>
xnoremap <buffer> <space><space>r :Curl<CR>
```
