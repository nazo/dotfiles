setlocal noexpandtab
set completeopt=menu,preview
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
au FileType go compiler go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
