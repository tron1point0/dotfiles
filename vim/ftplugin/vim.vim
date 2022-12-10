" Bindings specific to editing vim files

" Tags don't mean anything in vimfiles, so just go to help
nnoremap <C-]> "zyiw:help <C-r>z<CR>
vnoremap <C-]> "zy:help <C-r>z<CR>
" Also bind it to <localleader>h so we can still use it when lsp is on
nnoremap <localleader>h "zyiw:help <C-r>z<CR>
vnoremap <localleader>h "zy:help <C-r>z<CR>
let g:which_key.h = 'Show help'

