if has('win32')
    setlocal keywordprg=:!start\ https://hexdocs.pm/elixir/search.html?q=
endif

command -buffer Fmt :up | silent! call system("mix format ", expand("%")) | e
