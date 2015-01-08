"==============================================================================
" Configuations for code writing/reading in vim
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  (none)           -- comment
"==============================================================================
" Notes
"   Moved out of .vimrc
"   Calls a few other functionalities.
"==============================================================================


" set syntax for modelica file
au BufRead,BufNewFile *.mo set filetype=mo

" set syntax for arduino ino files
au BufRead,BufNewFile *.ino set filetype=c

" Gnuplot configuration
au BufRead,BufNewFile *.gp  set filetype=gnuplot

"Indent with respects with C programming
":se cindent
au FileType c,cpp     set cindent " sets cindent but only for certain files
au FileType javacript set cindent

" Compile and show result in a split screen
"map <F7> :w<enter>:tabnew<enter>:r!make<enter>
" one can also use :make which calls a Makefile
" Since there are some default compilation one can also
au FileType c,cpp set makeprg=make\ %:r
" then calling 'make' will result in either calling the Makefile OR using default


" Commenting code
source ~/.vim/scripts/commenting_code.vim

" templates for C/C++ files
au FileType c,cpp source ~/.vim/scripts/c_templ.vim

" templates also available for other files:
au FileType mo	source ~/.vim/scripts/c_templ.vim

" Aligning assignments:
source ~/.vim/scripts/align_assign.vim

" automatic foldings
" possible values: manual, indent, syntax, expr
au FileType c,cpp set foldmethod=indent

" tags for souce code
source ~/.vim/scripts/tags.vim
