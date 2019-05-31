"==============================================================================
" Add or remove C-style comments /* .. */
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  <leader>bc           -- add /* and */ around a visual selection
"  <leader>bu           -- remove /* and */ WITHIN the visual selection
"			   note that on multiple lines it removes multiple
"			   occurences of /* and */
"==============================================================================





" Includes C commenting /* .. */ on visually selected text
  " the following works well but on single line
    "vnoremap <leader>cc y:<C-B>sil <C-E>s/\(<C-R>"\)/\/* \1 *\//<CR>:noh<CR> 
  " an alternative that works on multiple lines
    "vnoremap <leader>bc <Esc>`<i/* <Esc>`>a */<Esc>  " Does not work on a single line, as `> moves due to the insertion
    vnoremap <leader>bc <Esc>`>a */<Esc>`<i/* <Esc>
  " another alternative
    " vnoremap <leader>k x:exe "normal i/*<C-r>"*/"<CR>
  " Suppressing comment:
    "vnoremap <leader>uc :<C-B>sil <C-E>s/\/\*\ \([.<CR>]*\)\ \*\//\1/<CR>:noh<CR>
  " it seems not to work on multiple lines


function! RemoveCBlockComments()
  let l:curr_line = getline('.')

  let l:nostart	  = substitute(l:curr_line,'\/\* ','','g')
  let l:noend	  = substitute(l:nostart,' \*\/','','g')

  call setline('.',l:noend)
endfunction

function! IsCommentMultipleLines() range
  if a:lastline != a:firstline
    execute a:firstline . ',' . a:lastline . 'call RemoveCBlockComments()'
    echo "yes"
  else 
    :s/\/\*\ \(.*\)\ \*\//\1/
  endif
endfunction

vnoremap <leader>bu :call IsCommentMultipleLines()<CR>

