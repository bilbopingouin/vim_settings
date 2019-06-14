"==============================================================================
" Comment line by line with comments that adapts to type of code
"==============================================================================
" Author: bilbopingouin
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  <leader>c           -- add comment on line (or all selected lines)
"  <leader>u           -- remove previously added comments
"==============================================================================
" Note
"  it also calls more specific commenting functions for C/C++, namely /* */
"==============================================================================



" un/comment in Visual
let b:comment_leader = '# ' " default value
au FileType vim	    let b:comment_leader = '" '
au FileType c,css   let b:comment_leader = '// '
au FileType cpp     let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex	    let b:comment_leader = '% '
au FileType vhdl    let b:comment_leader = '-- '
au FileType python  let b:comment_leader = '# '
au FileType ruby    let b:comment_leader = '# '
au FileType javascript    let b:comment_leader = '// '
au FileType gnuplot let b:comment_leader = '# '
au FileType octave  let b:comment_leader = '# '


noremap <leader>c : <C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <leader>u : <C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" /* .. */ comments for C/C++ files
"au FileType c,cpp source ~/.vim/scripts/c_comments.vim


