tabnew
setlocal spell
setlocal spelllang=en_ca
setlocal spellfile=$MYVIMDIR/colors/sample/en.utf-8.add
setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile

let s:text = "Colour. colour (Spell Cap), color (Spell Local), couleur (Spell Rare), kolour (Spell Bad)"

call setline(1, "Normal:  " .. s:text)
call setline(2, "String:  " .. s:text)
call setline(3, "Comment: " .. s:text)

syntax match sampleString "^String:.*$"
syntax match sampleComment "^Comment:.*$"

hi link sampleString String
hi link sampleComment Comment
