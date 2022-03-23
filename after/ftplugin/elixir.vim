nnoremap <silent><buffer> K :call os#Open("https://hexdocs.pm/elixir/search.html?q=" .. expand("<cfile>"))<CR>
command -buffer Fmt :up | silent! call system("mix format ", expand("%")) | e
