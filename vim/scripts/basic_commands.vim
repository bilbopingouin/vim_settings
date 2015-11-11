"==============================================================================
" Some commands that do not fit in a given category
"==============================================================================
" Author: T. Le Bleis
" Original date: 10.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
" 2015/03/16|  TLB         | Toggling t_ut
"           |              |
"==============================================================================
" Available commands:
"  <F10>           -- toggle paste mode
"==============================================================================
" Notes
"   (some more info)
"==============================================================================





" Copy and Paste from the mouse
function! ToggletUt()
  if &t_ut =~ 'y'
    set t_ut=
"     echo "Setting t_ut"
  else
    set t_ut=y
"     echo "Unsetting t_ut"
  endif 
endfunction

" When copying using the mouse and t_ut is set to empty (to avoid the bleeding in tmux), some extra spaces are selected at the end of the line.
" Using the toggle function, those spaces can be removed for the time to use that copy-paste.
" TODO: make it in a better way, the reload is time consuming when plenty of files are opened at once.
" map <F10> :set invpaste<CR>
map <F10> :set invpaste<CR>:call ToggletUt()<CR><C-L>:echo "toggle CP mode"<CR>
set pastetoggle=<F10>
