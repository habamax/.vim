" Use xmlstarlet (`scoop install xmlstarlet`):
if executable('xml')
    command -buffer Format :%!xml format --indent-spaces 4
endif
