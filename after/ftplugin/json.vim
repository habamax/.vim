if executable('jq')
    command! -buffer Format :%!jq
elseif executable('python')
    command! -buffer Format :%!python -m json.tool
endif
