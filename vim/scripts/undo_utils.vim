"==============================================================================
" Save undo history into files to be usable after closing and reopening
"==============================================================================
" Author: T. Le Bleis
" Original date: 24.10.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  27.11.14 | TLB          | No hardcoding of the home directory
"           |              |
"==============================================================================
" Available commands:
"  <C-z>		-- Undo in insert mode: typical MS command
"  <leader>vu		-- View undo history
"  <leader>nu           -- No undo: delete current history file and prevent
"			    saving currently edited file.
"  <leader>su           -- Avoid prevention from the previous command (but do
"			    not recover history).
"==============================================================================
" Notes
"   The main functions were adapted from functions provided in the vim help
"==============================================================================

" undo in insert mode
imap <C-z> <C-O>u

" visualise undotree
nmap <leader>vu :UndotreeToggle<CR>

" keeping tracks of changes even after leaving a file
if has("persistent_undo")
    set undodir='~/.undodir/'
    "set undofile
endif 

let s:undodir_name = expand('~') . '/.undodir'


func! ReadUndo()
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

func! WriteUndo()
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

func! DeleteUndo()
  if filereadable(s:undodir_name . expand('%:p:h') . '/' . expand('%:t'))
    :!rm -f ~/.undodir%:p:h/%:t
  endif
  let g:undosave_yn = 0
endfunc

au BufReadPost * call ReadUndo()
au BufWritePost * call WriteUndo()
let g:undosave_yn = 1
" if you don't want any undo file
nmap <leader>nu :call DeleteUndo()<CR>
" set/(re)set undo saving
nmap <leader>su :let g:undosave_yn = 1

