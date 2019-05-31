"==============================================================================
" Configuration file for Vi IMproved
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  5.11.14  |   TLB        | Moved syntax highl to color_configuration.vim
" 10.11.14  |   TLB        | Added 'basic commands' 
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

" Some global variables for various usage
if filereadable(expand("~/.vim/config"))
  source ~/.vim/config
endif

" Allowing filetype plugins
filetype plugin on

" List of managed plugins
source ~/.vim/scripts/plugins_list.vim
