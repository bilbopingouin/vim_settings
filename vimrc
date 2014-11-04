"This file allows to set up some useful options of vim


" leader
let mapleader = ',' " default is \ but on a French keyboard , is easier
set showcmd	    " see that we have typed the leader and other commands

" Dealing with Japanese
:source ~/.vim/scripts/JaInVim.vim

"Indent with respects with C programming
":se cindent
au FileType c,cpp     set cindent " sets cindent but only for certain files
au FileType javacript set cindent
  "Keep the linux standart (when using other editors: less, a2ps...)
:se tabstop=8
  "Make it using spaces in indenting: so that it looks reasonnable 
  "(8 spaces being much too large).
:se softtabstop=2
:se shiftwidth=2
:se noet

"See colours of the syntax
if &t_Co > 1
	syntax enable
endif

"Set the status line
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"Show positions of the cursor within the file
:se ruler

"For backspace to delete the previous character
set backspace=indent,eol,start

"Not cutting the end of the words
:se lbr

" Check spell in US English, type V
map <F2> :w<enter>:!ispell % <enter>:e!<enter><enter>
" in UK English, type F2
map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
"map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
" in French, type F3
map <F3> :w<enter>:!ispell -d french % <enter>:e!<enter><enter>

" Compile and show result in a split screen
map <F7> :w<enter>:tabnew<enter>:r!make<enter>

" When incrementing, numbers starting with 0x are recognised as hexa and the ones starting with 0 as octal.
" Since I never work with octal numbers and that I sometimes defined decimal starting from 0, I set the 
" formats as 
:se nrformats=hex
" also possible are 'octal' and 'alpha'.

" Some abbreviations. Particularly useful for mails.
:ab MfG Mit freundlichen Gruessen
":ab TLB Tudi Le Bleis

" Search configuration
source ~/.vim/scripts/search_utils.vim

" Commenting code
source ~/.vim/scripts/commenting_code.vim

" templates for C/C++ files
au FileType c,cpp source ~/.vim/scripts/c_templ.vim

" Aligning assignments:
source ~/.vim/scripts/align_assign.vim

" browsing
source ~/.vim/scripts/browsing.vim

" Save undo history for future use
source ~/.vim/scripts/undo_utils.vim

" tags
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 50
" map <leader>tl :TlistToggle<cr>
nmap <leader>tu :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <leader>tm [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" automatic foldings
" possible values: manual, indent, syntax, expr
au FileType c,cpp set foldmethod=indent

" Some configuration for games or such plugins
source ~/.vim/scripts/games.vim
