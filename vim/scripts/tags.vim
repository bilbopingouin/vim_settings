"==============================================================================
" Configuration to use the built-in tags functionality from vim
"==============================================================================
" Author: T. Le Bleis
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  <C-\>           -- As <C-]> but open a new tab instead of opening the file
"		      in the same window.
"  <C-,>	   -- Same a above, but splits the window. 
"  <leader>tu	   -- updates the tag list
"  <leader>tm	   -- List tags in current file
"==============================================================================
" Notes
"   (no more info)
"==============================================================================



" tags
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 50
" map <leader>tl :TlistToggle<cr>

" look up for tags file
" http://www.anattatechnologies.com/q/2014/04/vim-tags-and-tabs/
set tags+=tags;$HOME

" do like <C-]> but opens the new file in a tab
nmap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> 
nmap <C-,> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Some commands related to tags
nmap <leader>tu :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <leader>tm [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>


