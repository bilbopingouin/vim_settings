"==============================================================================
" Basic behaviour
"==============================================================================
" Author: bilbopingouin
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

" Sets the status line configuration
"if exists('g:loaded_fugitive')
  set statusline=%<%f\ %h%m%r%q%{fugitive#statusline()[4:-2]}%=%-14.(%l,%c%V%)\ %P
"else
"  set statusline=%<%f\ %h%m%r%q%=%-14.(%l,%c%V%)\ %P
"endif

" Sets the statusline visible
" 0 = never
" 1 = only for more than one window
" 2 = always
set laststatus=2
