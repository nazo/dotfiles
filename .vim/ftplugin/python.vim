setlocal expandtab

setlocal tabstop=4
setlocal shiftwidth=4

setlocal nofoldenable

autocmd BufWrite *.py :call Flake8()

