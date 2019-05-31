"==============================================================================
" Basic behaviour
"==============================================================================
" Author: T. Le Bleis
" Original date: 31.05.2019
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  (none)           -- comment
"==============================================================================
" Notes
"   Some parts from scripts/basic_configuration.vim
"==============================================================================


set showcmd	    " see that we have typed the leader and other commands

"Show positions of the cursor within the file
set ruler

"For backspace to delete the previous character
set backspace=indent,eol,start

"Not cutting the end of the words
set lbr

" When incrementing, numbers starting with 0x are recognised as hexa and the ones starting with 0 as octal.
" Since I never work with octal numbers and that I sometimes defined decimal starting from 0, I set the
" formats as
set nrformats=hex
" also possible are 'octal' and 'alpha'.
