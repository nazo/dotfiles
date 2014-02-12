set tabstop=4
set shiftwidth=4
set expandtab

" ファイルタイプがJavaScriptのファイルを保存すると即座にjslでチェックを行う
au FileType javascript set makeprg=jsl\ -conf\ /home/nazo/opt/jsl/jsl.conf\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -process\ %
au FileType javascript set errorformat=%f(%l):\ %m
au QuickfixCmdPost make call PostQuickfixCmd()
au BufWritePost *.js sil! make! | redraw!
function! PostQuickfixCmd()
  if len(getqflist()) > 0
    cw
  else
    cclose
  endif
endfunction

