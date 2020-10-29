" Use xmlstarlet in windows (`scoop install xmlstarlet`):
if executable('xml')
    command -buffer Format :%!xml format --indent-spaces 4
" in debian (`apt install xmlstarlet`):
elseif executable('xmlstarlet')
    command -buffer Format :%!xmlstarlet format --indent-spaces 4
endif
