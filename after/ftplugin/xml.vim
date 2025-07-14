if exists("b:did_after_ftplugin")
    finish
endif
let b:did_after_ftplugin = 1

if executable('xml')
    " Use xmlstarlet in windows (`scoop install xmlstarlet`):
    command -buffer Fmt :%!xml format --indent-spaces 4
elseif executable('xmlstarlet')
    " in debian (`apt install xmlstarlet`):
    command -buffer Fmt :%!xmlstarlet format --indent-spaces 4
endif
