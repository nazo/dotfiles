" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif





set nocompatible

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'rails.vim'

Bundle 'haml.zip'
Bundle 'git-commit'
Bundle 'YankRing.vim'
Bundle 'EasyMotion'
Bundle 'vimwiki'

Bundle 'quickrun'
Bundle 'git://github.com/taq/vim-git-branch-info.git'
Bundle 'matchit.zip'
Bundle 'mru.vim'
Bundle 'svn-diff.vim'
Bundle 'git://github.com/thinca/vim-ref.git'

Bundle 'newspaper.vim'
Bundle 'xoria256.vim'

Bundle 'vim-ruby/vim-ruby'
Bundle 'motemen/git-vim'

Bundle 'tsukkee/unite-help'

Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-fakeclip'

Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/unite.vim'

Bundle 'php.vim'

Bundle 'h1mesuke/vim-alignta'
Bundle 'h1mesuke/unite-outline'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'

Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'nelstrom/vim-textobj-rubyblock'

Bundle 'altercation/vim-colors-solarized'

Bundle 'kchmck/vim-coffee-script'

filetype plugin indent on     " required!
"
" Brief help
"
" :BundleInstall  - install bundles (won't update installed)
" :BundleInstall! - update if installed
"
" :Bundles foo    - search for foo
" :Bundles! foo   - refresh cached list and search for foo
"
" :BundleClean    - confirm removal of unused bundles
" :BundleClean!   - remove without confirmation
"
" see :h vundle for more details
" or wiki for FAQ
" Note: comments after Bundle command are not allowed..


" display
"-----------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set shortmess+=I

set list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set display=uhex
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /$B!!(B/

set laststatus=2
set cmdheight=1
set showcmd
set title
set number

set scrolloff=2

set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L

" search
"-----------------------------------------------------------
set incsearch
set ignorecase
set smartcase

" edit
"-----------------------------------------------------------
set autoindent
set backspace=indent,eol,start
set showmatch
set wildmenu
set formatoptions+=mM

" tab
"-----------------------------------------------------------
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
inoremap <C-Tab> <C-V><Tab>

set modelines=5

" backup
"-----------------------------------------------------------
set backup
set backupdir=~/.backup
set swapfile
set directory=~/.swp

" key map
" move at line
nnoremap j gj
nnoremap k gk

" input time
inoremap <Leader>date <C-R>=strftime('%A, %B %d, %Y')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>rdate <C-R>=strftime('%A, %B %d, %Y %H:%M')<CR>
inoremap <Leader>w3cdtf <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" search
vnoremap * "zy:let @/ = @z<CR>n

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" vimfiler
let g:vimfiler_as_default_explorer = 1

au QuickfixCmdPost vimgrep cw

" putline
"-----------------------------------------------------------
let putline_tw = 60

inoremap <Leader>line <ESC>:call <SID>PutLine(putline_tw)<CR>A
function! s:PutLine(len)
  let plen = a:len - strlen(getline('.'))
  if (plen > 0)
    execute 'normal ' plen . 'A-'
  endif
endfunction

" utf-8
"-----------------------------------------------------------
"let &termencoding=&encoding
"set termencoding=utf-8
"set encoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp-2,euc-jisx0213,euc-jp,cp932,utf-8
"set fileencodings=utf-8

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" format.vim
"-----------------------------------------------------------
let format_allow_over_tw = 0

" chalice
"-----------------------------------------------------------
set runtimepath+=$HOME/.vim/chalice
nnoremap <F2> :call <SID>DoChalice()<CR>
let chalice_preview = 0
let chalice_columns = 120
let chalice_exbrowser = 'openurl %URL% &'
function! s:DoChalice()
  Chalice
endfunction

" autodate
"-----------------------------------------------------------
let g:autodate_format = '%Y-%m-%d'
let g:autodate_keyword_pre = 'Last Modified:'
let g:autodate_keyword_post = '$'

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

colorscheme mrkn256
" colorscheme solarized

autocmd BufNewFile,BufRead *.ctp set filetype=php
autocmd BufNewFile,BufRead *.twig set filetype=html

" 行末の余計なスペース削除
autocmd BufWritePre * :%s/\s\+$//ge

if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif

