vim9script

## screenshort0x0.py
## Doesn't work with gnome on wayland
##
## # pip install pillow
## import os, uuid, tempfile as tf
## from PIL import ImageGrab
##
## os.sep = '/'
## img_file = os.path.join(tf.gettempdir(), str(uuid.uuid1()) + ".png").replace("\\", "/")
## img = ImageGrab.grab()
## img.save(img_file)
##
## os.system(f"curl -F file=@{img_file} http://0x0.st")
import autoload 'os.vim'

def ShareScreen()
    redraw!
    var url = ""
    if executable("gnome-screenshot")
        var img_file = tempname()
        system($'gnome-screenshot --window --file={img_file}')
        silent! url = systemlist($"curl -F file=@{img_file} http://0x0.st")[-1]
    elseif executable("cmd.exe")
        if exists("$WSLENV") && executable("screenshot0x0.py")
            var exepath = os.WslToWindowsPath(exepath('screenshot0x0.py'))
            var cmd = $'cmd.exe /C "{exepath}"'
            url = systemlist(cmd)[-1]
        else
            url = systemlist('screenshot0x0.py')[-1]
        endif
    else
        echo "Can't share the screen!"
        return
    endif
    setreg('+', url)
    setreg('"', url)
    echom url
enddef

command! ShareScreen call ShareScreen()

nnoremap <space><F12> <ScriptCmd>ShareScreen<CR>
xnoremap <space><F12> <ScriptCmd>ShareScreen<CR>
