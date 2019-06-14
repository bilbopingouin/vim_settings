"==============================================================================
" This file provides some function to help insert some templates into C/C++ 
" files. 
"==============================================================================
" Author: bilbopingouin
" Original date: 03.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  4.11.14  | BP          | Added function InsertPreProcIf and <leader>pi
"           |              |
"==============================================================================
" Available commands:
"  <leader>hc       -- inserts a comment header for C/C++ files
"  <leader>fc       -- inserts a comment header for C/C++ functions
"  <leader>dc       -- inserts a define "frame" for C/C++ header files 
"			(#if!def...)
"  <leader>pi       -- inserts a #if ( statement ) #endif where statement can
"			be entered interactively
"  <leader>rs       -- inserts any template: interactive choice
"==============================================================================


" c plugin
"filetype plugin on
" documentation:
" http://www.thegeekstuff.com/2009/01/tutorial-make-vim-as-your-cc-ide-using-cvim-plugin/
" http://lug.fh-swf.de/vim/vim-c/c-hotkeys.pdf
" http://www.vim.org/scripts/script.php?script_id=213
" as vim-latex, this is too invasive! I can use a cheap solution

" Insert common templates
nnoremap <leader>hc :r ~/.vim/templates/chead.c<CR>
nnoremap <leader>fc :r ~/.vim/templates/cfunc.c<CR>


" Full choice
:so ~/.vim/scripts/ReadSkeleton.vim
nmap <leader>rs :call ReadSkeleton()<cr>
let Skeleton_path = "~/.vim/templates" 

" Insert #if ... #endif
function! InsertPreProcIf(def,inpar)
  call append(line('.')-1,'#if ' . expand(a:def) . ' ( ' . expand(a:inpar) . ' )')
  call append(line('.')  ,'#endif /* ' . expand(a:inpar) . ' */')
endfunction

" Insert pre-processor frame for headers depending on the filename
function! InsertCHeaderPrec()
  let l:filename = "__" .expand('%:t') . "__"
  "let l:filename = "__" .expand('%') . "__"
  let l:dname = toupper(substitute(l:filename,'\.','_','g'))
  "call append(line('.')-1,'#if !defined (' . l:dname . ')')
  call InsertPreProcIf('!defined',l:dname)
  call append(line('.')-1,'#define ' . l:dname)
  "call append(line('.')  ,'#endif /* ' . l:dname . ' */')
endfunction

nnoremap <Leader>dc :call InsertCHeaderPrec()<CR>
nnoremap <Leader>pi :call InsertPreProcIf('',input('Statement: '))<CR>
