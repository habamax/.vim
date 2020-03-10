" Use xmlstarlet (`scoop install xmlstarlet`):
if executable('xml')
    command -buffer Format :%!xml format --indent-tab
endif
