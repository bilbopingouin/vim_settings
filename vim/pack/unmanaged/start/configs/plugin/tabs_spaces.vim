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

" Indentation
  "Keep the linux standart (when using other editors: less, a2ps...)
:se tabstop=8
  "Make it using spaces in indenting: so that it looks reasonnable 
  "(8 spaces being much too large).
    " Number of spaces inserted while pressing a tab in insert mode
:se softtabstop=2
    " Used for the incrementation in indenting or with < and > commands
:se shiftwidth=2
  " Insert a tab when the correct number of spaces are put together
:se noet
"	< 4 * 2 spaces = 1 tab

" See tabs and spaces
  "Quick toggling
nmap <leader>vs	:set list!<enter>
  " Characters set
set listchars=tab:▸_,eol:¬,space:·,nbsp:~   "set characters to visualise tabs, end of line and space


