vim9script

# detect delimiter
var delimiters = ",;\t|"

var max = 0
for d in delimiters
    var count = getline(1)->split(d)->len() + getline(2)->split(d)->len()
    if count > max
        max = count
        b:csv_delimiter = d
    endif
endfor

if exists("b:did_ftplugin")
    finish
endif
b:did_ftplugin = 1
