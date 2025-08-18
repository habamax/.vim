vim9script

var project_cache = {}
var projectFile = $'{$MYVIMDIR}.data/projects.json'

def ProjectLoad(): dict<any>
    var projects = {}
    try
        projects = readfile(projectFile)
            ->join()
            ->json_decode()
            ->filter((_, v) => isdirectory(v.path))
    catch
    endtry
    return projects
enddef

def ProjectSave()
    if empty(project_cache)
        return
    endif
    try
        [project_cache->json_encode()]->writefile(projectFile)
    catch
    endtry
enddef

def ProjectAdd()
    if empty(expand("%")) | return | endif
    var name = input("Save project: ", expand("%:t"))
    if empty(name)
        name = expand("%:t")
    endif
    var projects = {}
    try
        if !filereadable(projectFile)
            mkdir(fnamemodify(projectFile, ":p:h"), "p")
        else
            projects = ProjectLoad()
        endif
        projects[name] = {
            path: getcwd(),
            rank: 0
        }
        [projects->json_encode()]->writefile(projectFile)
        project_cache = projects
    catch
        echohl Error
        echomsg v:exception
        echohl None
    endtry
enddef

command! ProjectAdd call ProjectAdd()

command! -nargs=1 -complete=custom,ProjectComplete Project ProjectOpen(<f-args>)

def ProjectComplete(_, _, _): string
    if empty(project_cache) && filereadable(projectFile)
        project_cache = ProjectLoad()
    endif
    return project_cache
        ->items()
        ->sort((a, b) => a[1].use_dt == b[1].use_dt ? 0 : a[1].use_dt < b[1].use_dt ? 1 : -1)
        ->mapnew((_, v) => v[0])
        ->join("\n")
enddef

def ProjectOpen(name: string)
    var project = get(project_cache, name, null)
    if project == null
        echohl Error
        echomsg $'Project "{name}" not found.'
        echohl None
        return
    endif
    project_cache[name].use_dt = reltime()->reltimefloat()
    ProjectSave()
    timer_start(0, (_) => {
        chdir(project.path, 'window')
        feedkeys(":find ", "nt")
    })
enddef
