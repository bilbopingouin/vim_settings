let s:undodir_name = '/home/tlb/.undodir'

func ReadUndo()
"  if filereadable(expand('%:h'). '/UNDO/' . expand('%:t'))
"    rundo %:h/UNDO/%:t
"  let file = s:undodir_name . expand('%:p:h') . '/' . expand('%:t')
"  echo file
  if (g:undosave_yn == 1)
    if filereadable(s:undodir_name . expand('%:p:h') . '/' . expand('%:t'))
      rundo ~/.undodir%:p:h/%:t
    endif
  endif
endfunc

func WriteUndo()
"  let dirname = expand('%:h') . '/UNDO'
"  if !isdirectory(dirname)
"    call mkdir(dirname)
"  endif
"  wundo %:h/UNDO/%:t
  if (g:undosave_yn == 1)
    let dirname = s:undodir_name . expand('%:p:h')
    " echo dirname
    if !isdirectory(dirname)
      call mkdir(dirname,'p')
    endif
    wundo ~/.undodir%:p:h/%:t
  endif
endfunc

func DeleteUndo()
  if filereadable(s:undodir_name . expand('%:p:h') . '/' . expand('%:t'))
    :!rm -f ~/.undodir%:p:h/%:t
  endif
  let g:undosave_yn = 0
endfunc


