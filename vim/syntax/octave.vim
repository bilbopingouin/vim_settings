" Created for modelica files
" Author: bilbopingouin (bilbopingouin@gmail.com)
" Original: 10.03.2015
" Modification: 10.03.2015
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
syn match   octaveComment     '#.*$'

syn keyword octaveFuncKey     function endfunction

syn keyword octaveBasicKeys   if endif else elseif
syn keyword octaveBasicKeys   for endfor
syn keyword octaveBasicKeys   end
syn keyword octaveBasicKeys   while endwhile
syn keyword octaveBasicKeys   do until

syn keyword octaveIOKeys      printf save load input error
syn keyword octaveIOKeys      save_default_options save_precision save_header_format_string
syn keyword octaveIOKeys      fileread native_float_format fdisp dlmwrite dlmread csvwrite csvread textread textscan importdata 
syn keyword octaveIOKeys      argv program_name system

syn keyword octaveStringKeys  regexprep num2str str2num

syn keyword octaveMatrixKeys  size

syn region  octaveString      start='"' skip='\\"' end='"'

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
" hi def link modelicaModType   Constant
" hi modelicaFirstBrace ctermfg=1
" hi modelicaSecondBrace ctermfg=2
" hi modelicaThirdBrace ctermfg=3
" hi modelicaFourthBrace ctermfg=4
" hi modelicaKeyMod ctermfg=1
" hi modelicaModName ctermfg=2
" hi modelicaKeyPProc ctermfg=3
hi def link octaveString    String
hi def link octaveComment   Comment

hi def link octaveBasicKeys Statement

hi def link octaveFuncKey   Type
hi def link octaveIOKeys    Type

hi def link octaveStringKeys Special
hi def link octaveMatrixKeys Special
