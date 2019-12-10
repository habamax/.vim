if !has('nvim') && !has('python') && !has('python3')
	finish
endif

" pip install num2range first
command! -nargs=* Num2Rubles let @* = Num2Rubles(<f-args>)

func! Num2Rubles(num)
pyx << EOF
from num2words import num2words
value = int(vim.eval("a:num"))

div = value%10
if div == 1:
	ending = 'рубль'
elif div in range(2, 5):
	ending = 'рубля'
else:
	ending = 'рублей'

words = num2words(value, lang='ru')

result = '{} {} 00 копеек'.format(words, ending)
print(result)
EOF
return pyxeval("words")
endfunc

