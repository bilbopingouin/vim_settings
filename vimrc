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

" Dealing with Japanese
:source ~/.vim/scripts/JaInVim.vim

" Some basic configuration
source ~/.vim/scripts/basic_configuration.vim

" Color schemes and highlighting
source ~/.vim/scripts/color_configuration.vim

" Basic various commands
source ~/.vim/scripts/basic_commands.vim

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

" Search configuration
source ~/.vim/scripts/search_utils.vim

" browsing
source ~/.vim/scripts/browsing.vim

" Save undo history for future use
source ~/.vim/scripts/undo_utils.vim

" Some configuration for games or such plugins
source ~/.vim/scripts/games.vim

" Some global variables for various usage
if filereadable(expand("~/.vim/config"))
  :source ~/.vim/config
endif

" Allowing filetype plugins
filetype plugin on

" List of managed plugins
source ~/.vim/scripts/plugins_list.vim
