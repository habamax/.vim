if executable('xml')
    " Use xmlstarlet in windows (`scoop install xmlstarlet`):
    command -buffer Fmt :%!xml format --indent-spaces 4
elseif executable('xmlstarlet')
    " in debian (`apt install xmlstarlet`):
    command -buffer Fmt :%!xmlstarlet format --indent-spaces 4
endif
