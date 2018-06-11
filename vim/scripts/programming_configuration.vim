"==============================================================================
" Configuations for code writing/reading in vim
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
" 2015/02/26| TLB          | Adding the C-x functionality
" 2015/03/03| TLB          | Adding the C-Down functionality and fixing the C-x
" 2015/03/10| TLB	   | Octave files
"           |              |
"==============================================================================
" Available commands:
"  C-l           -- run a program/script that is being edited
"  C-Down	 -- if quickfix window is opened: jumps to the next error (:cn)
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

" GNU Octave. conflicts with matlab
au BufRead,BufNewFile *.m  set filetype=octave 

" Siemens SCL
au BufRead,BufNewFile *.scl set filetype=scl

"Indent with respects with C programming
":se cindent
au FileType c,cpp     set cindent " sets cindent but only for certain files
au FileType javacript set cindent

"From Pep8 standard, indent should be 4 spaces in python
au FileType python	  set softtabstop=4
au FileType python	  set shiftwidth=4
au FileType python        set expandtab         " convert tabs into spaces, python3 refuses mixing

" Compile and show result in a split screen
"map <F7> :w<enter>:tabnew<enter>:r!make<enter>
" one can also use :make which calls a Makefile
" Since there are some default compilation one can also
au FileType c,cpp set makeprg=make\ %:r
" then calling 'make' will result in either calling the Makefile OR using default
au FileType c,cpp nmap <F7> :make<CR>

" when compiling using the above, the errors appear in the quickfix window
" if the quickfix buffer is opened, <C-Down> allows to jump to the next error
" it is a shortcut to :cn but only in some conditions
au FileType c,cpp nnoremap <expr> <C-Down> (&buftype is# "quickfix" \|\| empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"')) ? "" : ":cn<CR>" )


" Commenting code
source ~/.vim/scripts/commenting_code.vim

" templates for C/C++ files
au FileType c,cpp source ~/.vim/scripts/c_templ.vim

" templates also available for other files:
au FileType mo	    source ~/.vim/scripts/c_templ.vim
au FileType octave  source ~/.vim/scripts/c_templ.vim

" Aligning assignments:
source ~/.vim/scripts/align_assign.vim

" automatic foldings
" possible values: manual, indent, syntax, expr
au FileType c,cpp set foldmethod=indent

" tags for souce code
source ~/.vim/scripts/tags.vim

" Run the program/script
au FileType c,cpp		nmap <buffer> <C-l> :!./%<<CR>
au FileType python,perl,bash,sh nmap <buffer> <C-l> :!./%<CR>
au FileType gnuplot		nmap <buffer> <C-l> :!gnuplot %<CR>
au FileType octave		nmap <buffer> <C-l> :!octave %<CR>

" When using diff, some options
set diffopt=filler,iwhite

" Some templates handling functions
au FileType c,cpp source ~/.vim/scripts/prog_templates.vim
