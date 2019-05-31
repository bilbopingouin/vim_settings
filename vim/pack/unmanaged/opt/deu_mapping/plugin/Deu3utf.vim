"==============================================================================
" When having German characters entered and one wants to compile LaTeX w/o
" changing the encoding of the file. It changes the special charactes with
" their specific LaTeX code.
"==============================================================================
" Author: T. Le Bleis
" Original date: 14.10.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  call Deu2utf()        -- Replace automatically in the whole file
"==============================================================================



function! Deu2utf()
  
  " Removing ignorecase to avoid problems
  :let l:icase = 0
  :if (&ignorecase)
    :set noignorecase
    :let l:icase = 1
    :echo "* Unset ignorecase *"
  :endif

  " Simply replace to LaTeX commands
  " Umlauts
  :echo "Replacing Ä"
  :%s/Ä/\\"A/ge
  :echo "Replacing Ö"
  :%s/Ö/\\"O/ge
  :echo "Replacing Ü"
  :%s/Ü/\\"U/ge
  :echo "Replacing ä"
  :%s/ä/\\"a/ge
  :echo "Replacing ö"
  :%s/ö/\\"o/ge
  :echo "Replacing ü"
  :%s/ü/\\"u/ge

  " "ss" problematic since we don't want to delete the following space
  :echo "Replacing ß"
  :%s/ß\ /\\ss\\\ /ge		  " if it is followed by a space: gem\"a\ss
  :%s/ß\([a-zA-Z]\)/\\ss\ \1/ge	  " if it is followed by a letter

  " quotation marks: please note that one needs "\usepackage[ngerman]{babel}" to get them.
  :echo "Replacing quotation marks"
  :%s/„/\\glqq\ /ge
  :%s/“/\\grqq\ /ge

  " Set back the user configuration
  :if l:icase == 1
    :set ignorecase
    :echo "* Reset ignorecase *"
  :endif

endfunction

