vim9script
# Vim HLSL (High Level Shader Language) syntax file
# Language: HLSL
# Maintainer: Maxim Kim <habamax@gmail.com>
# Description: WIP

if exists("b:current_syntax")
    finish
endif

# TODO: SV_POSITION, SV_TARGET etc
# https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics#system-value-semantics

var expanded_types = [
    'float', 'double', 'int', 'uint', 'bool',
    'min10float', 'min16float', 'min12int', 'min16int', 'min16uint',
    'float16_t', 'int16_t', 'uint16_t', 'uint64_t', 'int64_t'
]

# float1, float2 ...
# ...
# int1x1, int1x2 ...
exe $"syn keyword hlslType {expanded_types->join()}"
range(1, 4)->foreach((_, idx1) => {
    var type1 = expanded_types->mapnew((_, v) => v .. idx1)->join()
    exe $"syn keyword hlslType {type1}"
    range(1, 4)->foreach((_, idx2) => {
        var type1x1 = expanded_types
            ->mapnew((_, v) => $"{v}{idx1}x{idx2}")->join()
        exe $"syn keyword hlslType {type1x1}"
    })
})
syn keyword hlslType void dword half string vector matrix texture sampler
syn keyword hlslType extern nointerpolation precise shared groupshared static
syn keyword hlslType uniform export extern volatile const row_major column_major
syn keyword hlslType struct linear centroid noperspective sample
syn keyword hlslType typedef namespace class interface enum
syn keyword hlslType snorm unorm
syn keyword hlslType vertexfragment pixelfragment
syn keyword hlslType point line lineadj triangle triangleadj
syn keyword hlslType technique10 technique11
syn keyword hlslType cbuffer tbuffer
syn keyword hlslType Buffer StructuredBuffer AppendStructuredBuffer
syn keyword hlslType ByteAddressBuffer ConsumeStructuredBuffer
syn keyword hlslType Texture1D Texture2D Texture3D Texture1DArray Texture2DArray
syn keyword hlslType Texture2DMS Texture2DMSArray
syn keyword hlslType TextureCube TextureCubeArray
syn keyword hlslType RWBuffer RWByteAddressBuffer RWStructuredBuffer
syn keyword hlslType RWTexture1D RWTexture1DArray RWTexture2D
syn keyword hlslType RWTexture2DArray RWTexture3D
syn keyword hlslType PointStream LineStream TriangleStream
syn keyword hlslType SamplerState SamplerComparisonState
syn keyword hlslType RasterizerState DepthStencilState BlendState
syn keyword hlslType OutputPatch InputPatch
# TODO: only recognize it in function parameter list
syn keyword hlslType in out inout

syn keyword hlslCondition if else switch case default
syn keyword hlslRepeat while for do break continue
syn keyword hlslStatement return discard compile compile_fragment packoffset
syn keyword hlslStatement pass register fxgroup
syn keyword hlslConstant true false NULL

syntax match hlslInteger "\v-?<[0-9]+%(_[0-9]+)*[uUlL]?>" display
syntax match hlslFloat "\v-?<[0-9]+%(_[0-9]+)*%(\.[0-9]+%(_[0-9]+)*)%([eE][+-]=[0-9]+%(_[0-9]+)*)=[hHfFlL]?>" display
syntax match hlslHex "\v<0[xX][0-9A-Fa-f]+%(_[0-9A-Fa-f]+)*[uUlL]?>" display
syntax match hlslOct "\v<0[oO][0-7]+%(_[0-7]+)*[uUlL]?>" display
syntax cluster hlslNumber contains=hlslInteger,hlslFloat,hlslHex,hlslOct

syntax region hlslChar start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=hlslEscape
syntax region hlslString start=+"+ skip=+\\\\\|\\'+ end=+"+ contains=hlslEscape
syntax match  hlslEscape display contained /\\\([abefnrtv\\'"]\|\o\{3}\|x\x\{2}\|u\x\{4}\|U\x\{8}\)/

# TODO: better preproc
syn region hlslPreProc start=/^\s*\zs#/ end=/$/ contains=@hlslNumber,hlslString,hlslChar,@hlslComment

syntax match   hlslTodo "TODO" contained
syntax match   hlslTodo "XXX" contained
syntax match   hlslTodo "FIXME" contained
syntax region  hlslLineComment start=/\/\// end=/$/  contains=@Spell,hlslTodo
syntax region  hlslBlockComment start=/\/\*/ end=/\*\// contains=@Spell,hlslTodo
syntax cluster hlslComment contains=hlslLineComment,hlslBlockComment

hi def link hlslType         Type
hi def link hlslStatement    Statement
hi def link hlslCondition    Statement
hi def link hlslRepeat       Statement
hi def link hlslInteger      Number
hi def link hlslFloat        Float
hi def link hlslHex          Number
hi def link hlslOct          Number
hi def link hlslLineComment  Comment
hi def link hlslBlockComment Comment
hi def link hlslTodo         Todo
hi def link hlslChar         Character
hi def link hlslString       String
hi def link hlslEscape       Special
hi def link hlslPreProc      PreProc

b:current_syntax = "hlsl"
