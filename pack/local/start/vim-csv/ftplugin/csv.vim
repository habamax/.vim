vim9script

if exists("b:did_ftplugin")
    finish
endif
b:did_ftplugin = 1

# detect delimiter
var delimiters = {',': 0, ';': 0, "\t": 0}

for key in keys(delimiters)
    delimiters[key] += getline(1)->split(key)->len()
    delimiters[key] += getline(2)->split(key)->len()
endfor

var max = 0
for [key, value] in items(delimiters)
    if value > max
        b:csv_delimiter = key
        max = value
    endif
endfor
