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
  endif
endfunction


