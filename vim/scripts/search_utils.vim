"==============================================================================
" Some configuration and commands for searching within a file
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  5.11.14  |  TLB         | moved syntax highlighting to color_configuration.vim
"==============================================================================
" Available commands:
"  <Space>	      -- Toggle Search Highlight
"  <F8>		      -- Highlight occurences of current word w/o jump
"  *		      -- Same as built-in * but with visually selected text
"  #		      -- Same as built-in # but with visually selected text
" Built-in commands:
"  *		      -- Search current word
"  #		      -- Backward search current word
"==============================================================================
" Notes
"   Some of these have been in my .vimrc for a long time.
"==============================================================================



" Search ignoring case
:se ignorecase	" normally ignore the case when searching or by replace
:se smartcase	" overrides ignorecase if search pattern contains uppercase: 
    " to search all case: use only lower case in search
    " otherwise will match the case

" moved to color_configuration.vim
" " Highlighting search matches
" if &t_Co > 1
"   set hlsearch		      " Highlight search
"   highlight search guibg=LightGreen ctermbg=10  " Change color of highlight
" endif


  " some commands that can be useful:
    " space to remove current highlighting: movved to color_configuration.vim
":nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
":nnoremap <silent> <Space> :se hlsearch!<CR>
    " F8 to do like * but without moving to the next occurence
:nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
    " F8 and visual
"set guioptions+=a
":so ~/.vim/scripts/MakePattern.vim
"vnoremap <silent> <F8> :<C-U>let @/="<C-R>=MakePattern(@*)<CR>"<CR>:set hls<CR>
"do not work... :-(

" Search visually selected text
:vmap * y/<C-R>"<CR>
:vmap # y?<C-R>"<CR>

" Search current in all opened tabs
":noremap <F3> :bufdo vimgrepadd yoursearchpattern  % | copen
" enables to search in all open buffers with :Search <pattern>
"command! -nargs=1 Search call setqflist([]) | silent bufdo grepadd! <args> %

"nnoremap <C-n> :cprev<cr>zvzz
"nnoremap <C-p> :cnext<cr>zvzz
