if exists("b:current_syntax")
    finish
endif

syn match   tomlSection    "^\s*\[.*\]\s*$"
syn match   tomlComment     "#.*$" contains=tomlTodo,@Spell
syn keyword tomlTodo        TODO FIXME XXX contained
syn keyword tomlBoolean     true false
syn region tomlString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=@Spell
syn region tomlString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=@Spell

hi def link tomlSection PreProc
hi def link tomlString  String
hi def link tomlBoolean Boolean
hi def link tomlComment Comment
hi def link tomlTodo Todo

let b:current_syntax = 'toml'

