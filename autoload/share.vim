vim9script

# Name: autoload/share.vim
# Author: Maxim Kim <habamax@gmail.com>
# Desc: Share text using pastebin like services.
# Usage:
# Define command
# import autoload "share.vim"
# command! -range=% -nargs=? -complete=custom,share.Complete Share share.Paste(<q-args>, <line1>, <line2>)
#
# Share whole buffer with default 0x0.st
# :Share<CR>
#
# Share whole buffer with ix.io
# :Share ix<CR>
#
# Share selection
# :'<,'>Share<CR>


var paste_service = {
    '0x0': ['https://0x0.st/', 'file=@-'],
    'envs': ['https://envs.sh/', 'file=@-;'],
    'dpaste': ['http://dpaste.com/api/v2/', 'content=<-'],
    'ix': ['http://ix.io/', 'f:1=<-'],
    'vpaste': ['http://vpaste.net/', 'text=<-']
}

# Paste lines from current buffer to one of the `paste_service`
# Save URL in clipboard.
export def Paste(service: string, line1: number, line2: number)
    var [paste_url, paste_param] = paste_service->get(service, paste_service["0x0"])
    var url = Curl(paste_url, paste_param, line1, line2)
    @+ = url
    @* = url
    @@ = url
    echom $"Shared as {url}"
enddef

# Helper function to use curl for pastebin-like websites
def Curl(url: string, param: string, line1: number, line2: number): string
    if !executable('curl')
        echom "curl is not available!"
        return ""
    endif
    var lines = getline(line1, line2)->join("\n")
    var result = system($'curl -s -F "{param}" "{url}"', lines)
    return result->trim()
enddef

# Helper command completion function
export def Complete(_, _, _): string
    return paste_service->keys()->join("\n")
enddef
