"==============================================================================
" Configuration of color scheme and particular highlighiting
"==============================================================================
" Author: T. Le Bleis
" Original date: 05.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  26.11.14 | TLB          | Adding the t_ut part
"           |              |
"==============================================================================
" Available commands:
"  (none)           -- comment
"==============================================================================
" Notes
"   Using a modified version of darkblue
"==============================================================================

" When running in tmux I have a strange bleeding of the background color
" https://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif
" essentially adds spaces until the end of the screen. This is a problem when copy-paste with mouse selection

"See colours of the syntax
if &t_Co > 1
  syntax enable
endif


" Color scheme
color darkblue_t

" Rendered uninteresting by the use of own color scheme.
" " Highlighting search matches
" if &t_Co > 1
"   set hlsearch		      " Highlight search
"   highlight search guibg=LightGreen ctermbg=10  " Change color of highlight
" endif
" 
" " Some commands related to color highlighting
" " http://vim.wikia.com/wiki/Better_colors_for_syntax_highlighting
" map <silent> <F10> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" nnoremap <silent> <Leader>rc :hi comment ctermfg=0 ctermbg=2 cterm=bold,standout<CR>
" nnoremap <silent> <Leader>dhi :hi clear<CR>


" toggle highlithing for search results
:nnoremap <silent> <Space> :se hlsearch!<CR>
