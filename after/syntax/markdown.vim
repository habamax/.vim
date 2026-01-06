unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
syntax clear markdownError

syn match markdownListMarker "^\s*[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "^\s*\<\d\+\.\%(\s\+\S\)\@=" contained

hi! def link markdownBold Bold
hi! def link markdownItalic Italic
hi! def link markdownBoldItalic BoldItalic
