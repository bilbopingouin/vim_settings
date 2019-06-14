"==============================================================================
" Some configuration and commands for searching within a file
"==============================================================================
" Author: bilbopingouin
" Original date: 04.11.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"  5.11.14  |  BP         | moved syntax highlighting to color_configuration.vim
" 20.11.14  |  BP         | <C-Right> and <C-Left>
"==============================================================================
" Available commands:
"  <Space>	      -- Toggle Search Highlight
"  <F8>		      -- Highlight occurences of current word w/o jump
"  *		      -- Same as built-in * but with visually selected text
"  #		      -- Same as built-in # but with visually selected text
"  <C-Left>	      -- Jumps to previous item in location list
"  <C-Right>	      -- Jumps to next item in location list
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

" Using the built-in :find command
" https://stackoverflow.com/questions/23976517/vim-find-command-how-to-list-all-matched-files
set wildmenu
set wildmode=longest,list
set wildignorecase
set wildignore=*.o,*.bak
set path+=**
" When typing :find I can use the <Tab> to see a list. I can also see some regexp pattern: 
" :find **/*.c <Tab> will list the c files in the subdirectories

" Some commands: but it does not work if there are too many files in the directory
" regex completion instead of whole word completion
"nnoremap <leader>f :find *
" restrict the matching to files under the directory
" of the current file, recursively
"nnoremap <leader>F :find <C-R>=expand('%:p:h').'/**/*'<CR>
" same as the two above but opens the file in an horizontal window
"nnoremap <leader>s :sfind *
"nnoremap <leader>S :sfind <C-R>=expand('%:p:h').'/**/*'<CR>
" same as the two above but with a vertical window
"nnoremap <leader>v :vert sfind *
"nnoremap <leader>V :vert sfind <C-R>=expand('%:p:h').'/**/*'<CR>
" Allows to look for files with the same name: useful to find .h or .c associated.
" Run <Tab> twice afterwards
nnoremap <Leader>s :find **/<C-R>=expand('%:t:r')<CR>


" Often useful to search something with :lvimgrep pattern/j **/*.[ch]
" one can see the list using :lw of closing it using :lcl
" but jumps without opening the window can be obtained using
" :lnext and :lprev it is more useful to have it as <C-Right> and <C-Left>
nnoremap <C-Left>   :lprev<CR>
nnoremap <C-Right>  :lnext<CR>

" When working on a large project, I regularly use lvimgrep, so here are some utilities to make easier
nnoremap <leader>lvc :execute "lvimgrep /".input("Pattern: ")."/j **/*.[ch]"<CR>
nnoremap §	     bye:execute "lvimgrep /\\<".@"."\\>/j **/*.[ch]"<CR>
vnoremap §	     y:execute "lvimgrep /\\<".@"."\\>/j **/*.[ch]"<CR>

" Replace a pattern in files
nnoremap <leader>rpf  :execute "arg ".input("Where to search: ")."/**/*.[".input("Files filter (e.g. ch): ")."] \| argdo %s/".input("Pattern: ")."/".input("Replacement: ")."/gc \| update"<CR>
