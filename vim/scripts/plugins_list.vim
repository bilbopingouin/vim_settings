" Using vim-plug

call plug#begin('~/.vim/managed_plugs')

"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/drawit'
Plug 'junegunn/vimawesome.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'jmanoel7/vim-games'
Plug 'vim-scripts/Align'
Plug 'mbbill/echofunc'
Plug 'mbbill/undotree'
" Plug 'tomtom/ttagecho_vim'
" Plug 'WolfgangMehner/c-support'
" Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'hhatto/autopep8', {'for': 'python'}

call plug#end()
