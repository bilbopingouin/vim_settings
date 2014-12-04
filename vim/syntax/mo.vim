" Created for modelica files
" Author: T. Le Bleis (tudi.lebleis@gmail.com)
" Original: 13.11.2014
" Modification: 20.11.2014
" -------------------------------------------------------------

" No time to deal with backward compatibility
if version<700
  finish
endif

" -------------------------------------------------------------
" Customary check
if exists("b:current_syntax")
  finish
endif

" -------------------------------------------------------------
" Find syntax elements
syn match   modelicaModDecl   '^\s*[A-Za-z]\+\s\+[A-Za-z0-9\.]\+' transparent contains=modelicaKeyMod,modelicaModName,modelicaKeyPProc,modelicaKeyEnd,modelicaKeytype,modelicaLibElem

syn match   modelicaModName   '[A-Za-z0-9\.]\+' contained

syn keyword modelicaKeyMod    model package function nextgroup=modelicaModName
syn keyword modelicaKeyPProc  within import extends contained nextgroup=modelicaModName
syn keyword modelicaModVar    partial nextgroup=modelicaKeyMod

syn keyword modelicaKeyEnd    end contained

syn keyword modelicaKeyCond   if when then elseif contained
syn keyword modelicaKeyCond   else
syn match   modelicaCondStart '^\s*\(if\|when\|elseif\)\s*.*then' contains=modelicaKeyCond,modelicaKeyBool
syn match   modelicaCondEnd   '^\s*end\s*\(if\|when\)' contains=modelicaKeyCond,modelicaKeyEnd
syn keyword modelicaKeyBool   and or contained

syn keyword modelicaKeySect   equation algorithm protected public

syn keyword modelicaKeyFunc   reinit connect

syn keyword modelicaKeyType   Real String Boolean Integer
syn keyword modelicaKeyType   parameter final redeclare replaceable
syn keyword modelicaKeyType   output input

syn match   modelicaLibElem   '[Mm]odelica\.[A-Za-z0-9\.]\+'
syn match   modelicaSelfLib   '^\s*[A-Z][A-Za-z0-9]\+\.[A-Za-z0-9\.]\+'

syn region  modelicaString    start='"' skip='\\"' end='"'

syn match   modelicaComment   '\/\/.*$'
syn region  modelicaComment   start='/\*' end='\*/'

syn region  modelicaCond      start='if' end='end\s*if;' transparent fold contains=modelicaKeyCond,modelicaKeyEnd
syn region  modelicaCond      start='when' end='end\s*when;' transparent fold contains=modelicaKeyCond,modelicaKeyEnd


syn keyword modelicaKeyLang   der

" Annotations
" syn match   innerBraces	      '([^()]*)' transparent contained
" syn region  outerBraces	      start='(' end=')' transparent contains=innerBraces
" syn region  modelicaAnnot     start='annotation' end=';'
" syn keyword modelicaKeyAnnot  annotation
syn match   modelicaAnnot     'annotation\s*([\ ()A-Za-z0-9\n={},-.<>\/:%&\"]\+)' contains=modelicaAnnotHTML
syn region  modelicaAnnotHTML  start='\"\s*<html>' end='</html>\s*\"'
" /annotation\s*([A-Za-z0-9(){}=\-,\n\t\ \.\"<>\/:&%]*); matches most of the annotation
" syn match   modelicaAnnot     'annotation\s*([\ ()A-Za-z0-9\n={},-.<>/:%]\+)'
" the previous line is not a perfect match, but it's the best I have had so far...

" Keywords
" syn keyword modelicaKeyword model package nextGroup=modelicaModType
" syn keyword modelicaKeyword end
" syn keyword modelicaKeyword equation algorithm
" syn keyword modelicaKeyword within import extends nextGroup=modelicaModType
" syn keyword modelicaKeyword if when then 
" syn keyword modelicaKeyword reinit
" syn keyword modelicaKeyword parameter type
" syn keyword modelicaKeyType Real String Boolean Integer
"syn keyword modelicaKeyType 

" Matches
"syn match modelicaImpLib  'import\s*\[A-za-z0-9]\+\s*;'
" syn match modelicaImpLib  'import\s*[A-Z][a-zA-Z0-9]\+\s*;'
" syn match modelicaModType '[A-Za-z0-9\.]\+' contained

" syn match modelicaModPreProc '^\s*[A-Za-z]\+\s*[A-Za-z0-9\.]\+' contains=modelicaKeyword,modelicaModType

" Regions
" syn region modelicaString   start='"' end='"'
"syn region innerCurly start='{' end='}' transparent
"syn region innerBrace start='(' end=')' transparent contains=innerBrace,innerCurly
"syn match   innerBrace	    '(\([^()]*\(\r\n\)?\)*)'	      transparent contains=innerBrace
" syn match   innerBrace	    '([^()]*)'	      transparent contained
" syn region  outerBrace	    start='(' end=')' transparent contains=innerBrace
" syn region  modelicaAnnot   start='annotation\s*' end=')' contains=outerBrace
" syn region  modelicaConnect start='connect\s*(' end=')'
" syn match modelicaFirstBrace '([^()]*)' 
" syn match modelicaFirstBrace '(\.{-})' 
" syn region modelicaSecondBrace start='(' end=')' contains=modelicaFirstBrace
"syn match modelicaSecondBrace '([^()]*)' contains=modelicaFirstBrace
" syn region modelicaThirdBrace start='(' end=')' contains=modelicaSecondBrace
" syn region modelicaFourthBrace start='(' end=')' contains=modelicaThirdBrace

" Indent
" syn region modelicaModel start="model" end="end" fold transparent

" -------------------------------------------------------------
" Declare the current syntax
let b:current_syntax="mo"

" -------------------------------------------------------------
" Sets the color scheme

" hi def link modelicaKeyword   Special
" hi def link modelicaString    String
" hi def link modelicaAnnot     Comment
" hi def link modelicaKeyType   Type
" hi def link modelicaConnect   Statement
" hi def link modelicaImpLib    PreProc
" hi def link modelicaModType   Identifier
"hi def link modelicaModType   Constant
"hi modelicaFirstBrace ctermfg=1
"hi modelicaSecondBrace ctermfg=2
"hi modelicaThirdBrace ctermfg=3
"hi modelicaFourthBrace ctermfg=4
" hi modelicaKeyMod ctermfg=1
" hi modelicaModName ctermfg=2
" hi modelicaKeyPProc ctermfg=3
hi def link modelicaKeyMod    Preproc
hi def link modelicaKeyPProc  Special
hi def link modelicaKeySect   Special
hi def link modelicaKeyEnd    Special
hi def link modelicaModVar    Special

" hi def link modelicaKeyCond   Identifier
hi def link modelicaKeyCond   Special
hi def link modelicaKeyBool   Special

hi def link modelicaKeytype   Type

hi def link modelicaString    String
hi def link modelicaComment   Comment

hi def link modelicaKeyLang   Type
hi def link modelicaKeyFunc   Type

" hi def link modelicaKeyAnnot  Constant
hi def link modelicaAnnot     Constant
hi def link modelicaAnnotHTML Constant

hi def link modelicaModName   Identifier

hi def link modelicaSelfLib   Identifier
hi def link modelicaLibElem   Type


" hi Statement	
" hi Underlined	
" hi Ignore	
