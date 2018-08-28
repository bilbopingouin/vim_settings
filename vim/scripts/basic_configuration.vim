"==============================================================================
" Basic vim configuration
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
" 2015.01.07| TLB          | Adding fugitive in statusline & making statusline always visible
"           |              |
"==============================================================================
" Available commands:
"  (none)           -- comment
"==============================================================================
" Notes
"   Moved out of .vimrc
"==============================================================================



set showcmd	    " see that we have typed the leader and other commands

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

"Set the status line
"set statusline=%<%f\ %h%m%r%q%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %h%m%r%q%{fugitive#statusline()[4:-2]}%=%-14.(%l,%c%V%)\ %P
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" See the statusline even if only one file is opened
set laststatus=2

"Show positions of the cursor within the file
:se ruler

"For backspace to delete the previous character
set backspace=indent,eol,start

"Not cutting the end of the words
:se lbr
