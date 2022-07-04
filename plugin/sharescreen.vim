vim9script

## screenshort0x0.py
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
    var url = systemlist('screenshot0x0.py')[-1]
    setreg("+", url)
    echo url
enddef

command! ShareScreen call ShareScreen()

noremap <F12> <ScriptCmd>ShareScreen<CR>
xnoremap <F12> <ScriptCmd>ShareScreen<CR>
