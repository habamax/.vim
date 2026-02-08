exe 'syn match typstCheckbox /\%(' .. &l:formatlistpat .. '\)\@<=\[[xX ]\]/ containedin=TOP'
hi def link typstCheckbox typstMarkupBulletList

" hi! def link typstMarkupHeading Title

hi! def link typstMarkupBold Bold
hi! def link typstMarkupItalic Italic
hi! def link typstMarkupBoldItalic BoldItalic
