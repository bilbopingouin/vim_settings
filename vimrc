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

" Search ignoring case
:se ignorecase	" normally ignore the case when searching or by replace
:se smartcase	" overrides ignorecase if search pattern contains uppercase: 
    " to search all case: use only lower case in search
    " otherwise will match the case

" Highlighting search matches
:se hlsearch		      " Highlight search
:hi search guibg=LightGreen ctermbg=10  " Change color of highlight
  " some commands that can be useful:
    " space to remove current highlighting
":nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
:nnoremap <silent> <Space> :se hlsearch!<CR>
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

" Twitvim
" let twitvim_browser_cmd = 'iceweasel'
" let twitvim_count = 50

" un/comment in Visual
let b:comment_leader = '' " default value
au FileType vim	    let b:comment_leader = '" '
au FileType c,css   let b:comment_leader = '// '
au FileType cpp     let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex	    let b:comment_leader = '% '
au FileType vhdl    let b:comment_leader = '-- '
au FileType python  let b:comment_leader = '# '
au FileType ruby    let b:comment_leader = '# '
au FileType javascript    let b:comment_leader = '// '


noremap ,c : <C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap ,u : <C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" c plugin
"filetype plugin on
" documentation:
" http://www.thegeekstuff.com/2009/01/tutorial-make-vim-as-your-cc-ide-using-cvim-plugin/
" http://lug.fh-swf.de/vim/vim-c/c-hotkeys.pdf
" http://www.vim.org/scripts/script.php?script_id=213
" as vim-latex, this is too invasive! I can use a cheap solution
nnoremap <leader>hc :r ~/.vim/templates/chead.c<CR>
nnoremap <leader>fc :r ~/.vim/templates/cfunc.c<CR>
" other alternative
:so ~/.vim/scripts/ReadSkeleton.vim
nmap <leader>rs :call ReadSkeleton()<cr>
let Skeleton_path = "~/.vim/templates" 



" browsing
"map <F9> :tabnew<CR>:e .<CR>
"map <F9> :Vexplore<CR>
let g:netrw_list_hide = '^\.[a-zA-Z]' " hide linux hidden files: toggle with 'a'
let g:netrw_preview   = 1	      "	split vertically for previews: opens vertically using 'p'
let g:netrw_alto      = 1	      " split vertically for opening: using 'o'
let g:netrw_liststyle = 3	      " defaults showing tree: toggle using 'i', careful when opening
let g:netrw_winsize   =	30	      " browing window occupy 30% after opening file
" https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
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
"map <silent> <C-E> :call ToggleVExplorer()<CR>
map <silent> <F9> :call ToggleVExplorer()<CR>
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
" set autochdir
nmap <silent> <C-Left> :Rexplore<CR>

" undo in insert mode
imap <C-z> <C-O>u
" visualise undotree
nmap <leader>vu :UndotreeToggle<CR>
" keeping tracks of changes even after leaving a file
if has("persistent_undo")
    set undodir='~/.undodir/'
    "set undofile
endif 

au BufReadPost * call ReadUndo()
au BufWritePost * call WriteUndo()
let g:undosave_yn = 1
:so ~/.vim/scripts/undo_utils.vim
" if you don't want any undo file
nmap <leader>nu :call DeleteUndo()<CR>
" set/reset undo saving
nmap <leader>su :let g:undosave_yn = 1

" tags
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 50
" map <leader>tl :TlistToggle<cr>
nmap <leader>tu :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap <leader>tm [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>


