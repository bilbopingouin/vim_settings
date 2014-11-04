"==============================================================================
" Configuration file for Vi IMproved
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  <F10>           -- switch from light to dark background and back
"  <leader>rc	   -- change comment highlight for improved readability
"  <leader>dhi	   -- reset highlight to defaults
"==============================================================================
" Notes
"   calls many other utilities!
"   date is written starting from 2014, but some of the commands have just been
"  moved away, and some are there since years!
"==============================================================================



"This file allows to set up some useful options of vim


" leader
let mapleader = ',' " default is \ but on a French keyboard , is easier

" Dealing with Japanese
:source ~/.vim/scripts/JaInVim.vim

"See colours of the syntax
if &t_Co > 1
  syntax enable
endif

" Some commands related to color highlighting
" http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
map <silent> <F10> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <silent> <Leader>rc :hi comment ctermfg=0 ctermbg=2 cterm=bold,standout<CR>
nnoremap <silent> <Leader>dhi :hi clear<CR>

" Some basic configuration
source ~/.vim/scripts/basic_configuration.vim

" Text spell checking
source ~/.vim/scripts/spellcheck.vim

" Programming functionalities
source ~/.vim/scripts/programming_configuration.vim

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

" browsing
source ~/.vim/scripts/browsing.vim

" Save undo history for future use
source ~/.vim/scripts/undo_utils.vim

" Some configuration for games or such plugins
source ~/.vim/scripts/games.vim
