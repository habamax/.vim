if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl flp< tw<"
else
    let b:undo_ftplugin = "setl flp< tw<"
endif

compiler rst2html

setlocal textwidth=78

setlocal formatlistpat=^\\s*
setlocal formatlistpat+=[
setlocal formatlistpat+=\\[({]\\?
setlocal formatlistpat+=\\(
setlocal formatlistpat+=[#0-9\ xX]\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=[a-zA-Z]
setlocal formatlistpat+=\\)
setlocal formatlistpat+=[\\]:.)}
setlocal formatlistpat+=]
setlocal formatlistpat+=\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*-\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*[*]\\+\\s\\+
setlocal formatlistpat+=\\\|
setlocal formatlistpat+=^\\s*[.]\\+\\s\\+

