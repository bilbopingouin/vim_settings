" Using C default indent
set cindent


" CPM/Sonceboz requires 3 spaces
set softtabstop=3
set shiftwidth=3
set expandtab

" Compile and show result in a split screen
"map <F7> :w<enter>:tabnew<enter>:r!make<enter>
" one can also use :make which calls a Makefile
" Since there are some default compilation one can also
set makeprg=make\ %:r
" then calling 'make' will result in either calling the Makefile OR using default
nmap <F7> :make<CR>

" when compiling using the above, the errors appear in the quickfix window
" if the quickfix buffer is opened, <C-Down> allows to jump to the next error
" it is a shortcut to :cn but only in some conditions
nnoremap <expr> <C-Down> (&buftype is# "quickfix" \|\| empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"')) ? "" : ":cn<CR>" )

" templates for C/C++ files
"source ~/.vim/scripts/c_templ.vim
packadd c_templ

" automatic foldings
" possible values: manual, indent, syntax, expr
set foldmethod=indent

" Run the program/script
nmap <buffer> <C-l> :!./%<<CR>
