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
"  call SetCHeaderTags()	 -- Set the #ifndef ... macros
"  call CreateNewCHeaderFile()	 -- Create a new header file including the
"				  templates
"  call SetCSourceInclude()	 -- Set the #include "header.h"
"  call CreateNewCSourceFile()	 -- Create a new C source file including the 
"				  corresponding templates
"==============================================================================
" Notes
"
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

  if search("TIME") != 0
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

  if search("<CURSOR>") != 0
    :echo "Reaching <CURSOR>"
    :call search("<CURSOR>")
    :normal 8x
    :startinsert
  endif
endfunction

function! SetCHeaderTags ()
  :let tag_name = "__".substitute(toupper(expand("%:t")), '\.', '_', 'g')."__"
  if search("|TAG|")
    :%s/|TAG|/\=expand(tag_name)
  endif
endfunction

function! CreateNewCHeaderFile()
  :let file_name = input("Header file name: ")
  if filereadable(file_name)
    :echo "File already exists"
  else
    :execute ":tabnew ".expand(file_name)
    :r!cat ~/.vim/templates/chead.c
    :r!cat ~/.vim/templates/cbody.h
    :call SetCHeaderTags()
    :call SetTemplValues()
  endif
endfunction

function! SetCSourceInclude ()
  :let header_name = substitute(expand("%:t"), '.c$', '.h', '')
  if search("|FILEHEADER|")
    :%s/|FILEHEADER|/\=expand(header_name)
  endif
endfunction

function! CreateNewCSourceFile()
  :let file_name = input("Source file name: ")
  if filereadable(file_name)
    :echo "File already exists"
  else
    :execute ":tabnew ".expand(file_name)
    :r!cat ~/.vim/templates/chead.c
    :r!cat ~/.vim/templates/cbody.c
    :call SetCSourceInclude ()
    :call SetTemplValues()
  endif
endfunction


