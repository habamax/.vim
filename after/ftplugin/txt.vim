if exists("b:did_ftplugin")
    finish
endif

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl cms< com< fo< flp< tw<"
else
    let b:undo_ftplugin = "setl cms< com< fo< flp< tw<"
endif

setlocal comments=
setlocal commentstring=
setlocal formatoptions=tcqln
setlocal formatlistpat=^\\s*
setlocal formatlistpat+=[
setlocal formatlistpat+=\\[({]\\?
setlocal formatlistpat+=\\(
setlocal formatlistpat+=[0-9\ xX]\\+
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

setlocal textwidth=80
