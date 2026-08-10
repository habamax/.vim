vim9script
# Language:    HLSL (High-Level Shader Language)
# Maintainer:  Maxim Kim <habamax@gmail.com>
# Last Update: 2026-08-10

if exists('b:did_indent')
  finish
endif
b:did_indent = 1

setlocal autoindent cindent
setlocal cinoptions&

b:undo_indent = 'setl ai< ci< cino<'
