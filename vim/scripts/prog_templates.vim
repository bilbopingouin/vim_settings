"==============================================================================
" Include some pre-defined templates into the text
"==============================================================================
" Author: bilbopingouin
" Original date: 2018.06.08
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  call SetTemplValues()	 -- Set some values from the templates
"  call IncludeVimHeaderTempl()	 -- Include the template and update them
"  call CreateNewVimCfgFile()	 -- Create a new vim file including the 
"				  corresponding template
"  call SetCHeaderTags()	 -- Set the #ifndef ... macros
"  call IncludeCHeaderFileTempl()-- Include the template and update them
"  call CreateNewCHeaderFile()	 -- Create a new header file including the
"				  templates
"  call SetCSourceInclude()	 -- Set the #include "header.h"
"  call IncludeCSourceFileTempl()-- Include the template and update them
"  call CreateNewCSourceFile()	 -- Create a new C source file including the 
"				  corresponding templates
"  call IncludeCFunctionDoc()	 -- Include the function documentation
"==============================================================================
" Notes
"
"==============================================================================

let s:function_name   = "|FUNCTION NAME|"
let s:function_retval = "None"
let s:param_list      = [["name","type"]]

"==============================================================================

function! SetTemplValues()
  if search("|YEAR|") != 0
    :echo "Substitute |YEAR|"
    :%s/|YEAR|/\=strftime("%Y")/g
  endif

  if search("|DATE|") != 0
    :echo "Substitute |DATE|"
    :%s/|DATE|/\=strftime("%Y-%m-%d")/g
  endif

  if search("|TIME|") != 0
    :echo "Substitute |TIME|"
    :%s/|TIME|/\=strftime("%H:%M")/g
  endif

  if search("|FILENAME|") != 0
    :echo "Substitute |FILENAME|"
    :%s/|FILENAME|/\=expand("%:t")/g
  endif

  if search("|MODULE|") != 0
    :echo "Substitute |MODULE|"
    ":%s/|MODULE|/\=input("Module name: ")/g
    :%s/|MODULE|/\=expand("%:t:r")/g
    ":echo "."
  endif

  if search("|AUTHOR|") != 0
    :echo "Substitute |AUTHOR|"
    if exists("g:author_name") != 0
      :%s/|AUTHOR|/\=expand(g:author_name)/g
    else
      :%s/|AUTHOR|/\=input("Author name: ")/g
      :echo "."
    endif
  endif

  if search("|AUTHSHORT|") != 0
    :echo "Substitute |AUTHSHORT|"
    if exists("g:author_short") != 0
      :%s/|AUTHSHORT|/\=expand(g:author_short)/g
    else
      :%s/|AUTHSHORT|/\=input("Author short name: ")/g
      :echo "."
    endif
  endif
 
  if search("|EMAIL|") != 0
    :echo "Substitute |EMAIL|"
    if exists("g:author_short") != 0
      :%s/|EMAIL|/\=expand(g:author_email)/g
    else
      :%s/|EMAIL|/\=input("Email address: ")/g
      :echo "."
    endif
  endif


  if search("|COMPANY|") != 0
    :echo "Substitute |COMPANY|"
    if exists("g:author_short") != 0
      :%s/|COMPANY|/\=expand(g:author_company)/g
    else
      :%s/|COMPANY|/\=input("Company name: ")/g
      :echo "."
    endif
  endif

  if search("|FUNCTION NAME|") != 0
    :%s/|FUNCTION NAME|/\=expand(s:function_name)/g
  endif

  if search("RETVAL") != 0
    :%s/|RETVAL|/\=expand(s:function_retval)/g
  endif

  if search("|PARAM DESC|") != 0
    if len(s:param_list) == 0
      /|PARAM DESC|
      :execute "normal! 0c$ * @param   none"
    else
      /|PARAM DESC|
      :delete
      :.-1
      :let i=0
      while i<len(s:param_list)
	:execute "normal! o * @param   ".s:param_list[i][0]."  description"
	:let i=i+1
      endwhile
    endif
  endif

  if search("|PARAM TYPE|") != 0
    if len(s:param_list) == 0
      /|PARAM TYPE|
      :execute "normal! 0c$ * @tparam  none"
    else
      /|PARAM TYPE|
      :delete
      :.-1
      :let i=0
      while i<len(s:param_list)
	:execute "normal! o * @tparam  ".s:param_list[i][0]."  ".s:param_list[i][1]
	:let i=i+1
      endwhile
    endif
  endif

  if search("<CURSOR>") != 0
    :echo "Reaching <CURSOR>"
    :call search("<CURSOR>")
    :normal 8x
    :startinsert
  endif
endfunction

"==============================================================================

function! IncludeVimHeaderTempl()
  :set paste
  :0r!cat ~/.vim/templates/vimhead.vim
  :call SetTemplValues()
  :set nopaste
endfunction

"==============================================================================

function! CreateNewVimCfgFile()
  :let file_name = input("vim file name: ")
  if filereadable(file_name)
    :echo "File already exists"
  else
    :execute ":tabnew ".expand(file_name)
    :call IncludeVimHeaderTempl()
  endif
endfunction

"==============================================================================

function! SetCHeaderTags ()
  :let tag_name = "__".substitute(toupper(expand("%:t")), '\.', '_', 'g')."__"
  if search("|TAG|")
    :%s/|TAG|/\=expand(tag_name)
  endif
endfunction

"==============================================================================

function! IncludeCHeaderFileTempl()
  :set paste
  :0r!cat ~/.vim/templates/chead.c
  :r!cat ~/.vim/templates/cbody.h
  :call SetCHeaderTags()
  :call SetTemplValues()
  :set nopaste
endfunction

"==============================================================================

function! CreateNewCHeaderFile()
  :let file_name = input("Header file name: ")
  if filereadable(file_name)
    :echo "File already exists"
  else
    :execute ":tabnew ".expand(file_name)
    :call IncludeCHeaderFileTempl()
  endif
endfunction

"==============================================================================

function! SetCSourceInclude ()
  :let header_name = substitute(expand("%:t"), '.c$', '.h', '')
  if search("|FILEHEADER|")
    :%s/|FILEHEADER|/\=expand(header_name)
  endif
endfunction

"==============================================================================

function! IncludeCSourceFileTempl()
  :set paste
  :0r!cat ~/.vim/templates/chead.c
  :r!cat ~/.vim/templates/cbody.c
  :call SetCSourceInclude ()
  :call SetTemplValues()
  :set nopaste
endfunction

"==============================================================================

function! CreateNewCSourceFile()
  :let file_name = input("Source file name: ")
  if filereadable(file_name)
    :echo "File already exists"
  else
    :execute ":tabnew ".expand(file_name)
    :call IncludeCSourceFileTempl()
  endif
endfunction

"==============================================================================

function! IncludeCFunctionDoc()
  :set paste
  :r!cat ~/.vim/templates/cfunc.c
  :call SetTemplValues()
  :set nopaste
endfunction

"==============================================================================

function! IncludeCFunction()
  :delm a
  :mark a
  :execute "normal! i".s:function_retval." ".s:function_name." ("
  if len(s:param_list) == 0
    :execute "normal! avoid)"
  else
    :let i=0
    while i < len(s:param_list)
      :echo i
      if i>0
        :execute "normal! a, "
      endif
      :execute "normal! a".s:param_list[i][1]." ".s:param_list[i][0]
      :let i=i+1
    endwhile
    :execute "normal! a)"
  endif
  :execute "normal! o{\n\n}"
  :execute "normal! `aO"
endfunction

"==============================================================================

function! CreateNewCFunction()
  :set paste
  :let s:function_name   = input("Function name: ")
  :let s:function_retval = input("Function return type: ")

  :let param_numbers = input ("Number of parameters: ")
  :let s:param_list  = []
  :let i             =0
  if param_numbers!=0
    while i<param_numbers
      :let pname = input("Parameter ".(i+1)." name: ")
      :let ptype = input("Parameter ".(i+1)." type: ")
      :call add(s:param_list,[pname,ptype])
      :let i=i+1
    endwhile 
  endif

  :call IncludeCFunction()
  :call IncludeCFunctionDoc()
  :set nopaste
endfunction

"==============================================================================

nmap <leader>cch  :call CreateNewCHeaderFile()<CR>
nmap <leader>ccs  :call CreateNewCSourceFile()<CR>

nmap <leader>ccf  :call	CreateNewCFunction()<CR>
