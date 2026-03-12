exe 'syn match typstCheckbox /\%(' .. &l:formatlistpat .. '\)\@<=\[[xX ]\]/ containedin=TOP'
hi def link typstCheckbox typstMarkupBulletList
