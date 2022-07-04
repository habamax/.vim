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

def ShareScreen()
    var url = ""
    if executable("gnome-screenshot")
        var img_file = tempname()
        system($'gnome-screenshot --file={img_file}')
        url = system($"curl -F file=@{img_file} http://0x0.st")
    elseif executable("cmd.exe")
        url = systemlist('screenshot0x0.py')[-1]
    else
        echo "Can't share the screen!"
        return
    endif
    setreg("+", url)
    echo url
enddef

command! ShareScreen call ShareScreen()

nnoremap <space><F12> <ScriptCmd>ShareScreen<CR>
xnoremap <space><F12> <ScriptCmd>ShareScreen<CR>
