" We want to use cscope and ctags to create some database which allows to
" peruse the code in a better way.


" List of source files with the directory
nnoremap  <leader>cr_l	:!find . -type f -name "*.[ch]" > cscope.files<CR>

" Generate the database
nnoremap  <leader>cr_d	:!cscope -b<CR>

" Generate the tag list
nnoremap  <leader>cr_t	:!ctags -L cscope.files -R -h="h.c.cu" --c-kinds=+p --if0=yes --totals=yes -f tags<CR>

" Combine the previous commands
nnoremap  <leader>cr_u	:execute "normal <leader>cr_l<leader>cr_d<leader>cr_t"<CR>
