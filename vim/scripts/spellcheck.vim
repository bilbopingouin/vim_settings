"==============================================================================
" Spell checking usig ispell command available on Linux
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  V           -- checks using English (UK) dictionary
" <F2>	       -- checks using English (US) dictionary
" <F3>	       -- checks using French dictionary
" ,oe	       -- enable on-the-flight spelling check English (UK)
" ,on	       -- disable on-the-flight spelling checks
"==============================================================================
" Notes
"   The commands were previously in .vimrc and have been moved away for clarity
"==============================================================================



" Using external ispell command to spell check

" Check spell in US English, type V
map <F2> :w<enter>:!ispell % <enter>:e!<enter><enter>
" in UK English, type F2
map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
"map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
" in French, type F3
map <F3> :w<enter>:!ispell -d french % <enter>:e!<enter><enter>

" Using internal spell checking
map <leader>oe :setlocal spell spelllang=en_gb<enter>
map <leader>on :setlocal nospell<enter>
