vim9script

export def Eatchar(pat: string): string
    var c = nr2char(getchar(0))
    return (c =~ pat) ? '' : c
enddef
