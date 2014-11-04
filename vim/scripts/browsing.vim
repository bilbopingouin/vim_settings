"==============================================================================
" Using netrw browing style: configuration and useful tools
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  <F9>           -- Toggle :Vexplore
"  <C-Left>       -- Runs :Rexplore to 'go back' to exploring mode
"==============================================================================
" Notes
"   A compilation between internet sources and vim built-in help
"==============================================================================


" Some basic configuration
let g:netrw_list_hide = '^\.[a-zA-Z]' " hide linux hidden files: toggle with 'a'
let g:netrw_preview   = 1	      "	split vertically for previews: opens vertically using 'p'
let g:netrw_alto      = 1	      " split vertically for opening: using 'o'
let g:netrw_liststyle = 3	      " defaults showing tree: toggle using 'i', careful when opening
let g:netrw_winsize   =	30	      " browing window occupy 30% after opening file
" https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
" set autochdir



" Toggle exploration
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

"map <F9> :tabnew<CR>:e .<CR>
"map <F9> :Vexplore<CR>
"map <silent> <C-E> :call ToggleVExplorer()<CR>
map <silent> <F9> :call ToggleVExplorer()<CR>

nmap <silent> <C-Left> :Rexplore<CR>

