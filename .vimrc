set rtp+=~/dotfiles/neobundle.vim

if has('vim_starting')
  set runtimepath+=~/dotfiles/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

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

" let Vundle manage Vundle
" required!
NeoBundle 'gmarik/vundle'

" My Bundles here:
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'rails.vim'

NeoBundle 'haml.zip'
NeoBundle 'git-commit'
NeoBundle 'EasyMotion'
NeoBundle 'vimwiki'

NeoBundle 'quickrun'
NeoBundle 'git://github.com/taq/vim-git-branch-info.git'
NeoBundle 'matchit.zip'
NeoBundle 'mru.vim'
NeoBundle 'svn-diff.vim'
NeoBundle 'thinca/vim-ref'

NeoBundle 'newspaper.vim'
NeoBundle 'xoria256.vim'

NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'motemen/git-vim'

NeoBundle 'tsukkee/unite-help'

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-fakeclip'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'

NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'h1mesuke/unite-outline'

NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround'

NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'nelstrom/vim-textobj-rubyblock'

NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'mattn/gist-vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'

NeoBundle 'scrooloose/syntastic'

NeoBundle '2072/PHP-Indenting-for-VIm'

NeoBundle 'mrtazz/simplenote.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'msanders/cocoa.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'

NeoBundle 'tsukkee/unite-tag'
NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'vim-jp/vital.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-scripts/tagbar-phpctags'

NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/excelview-vim'
NeoBundle 'vim-flake8'
NeoBundle 'itchyny/lightline.vim'

filetype plugin indent on     " required!

NeoBundleCheck

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
set clipboard=unnamed

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
set backupdir=~/.vimbackup
set swapfile
set directory=~/.vimswp

" タブページを常に表示
set showtabline=2
" gVimでもテキストベースのタブページを使う
set guioptions-=e

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



"windowsのvimfilesを.vimに変更する
if has('win32') + has('win64')
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif

"C-n補完の対象(カレントバッファ、タグ、辞書) :help 'complete'
"neocomplcacheには影響しない？
"neocomplcacheには影響しないそうなのでコメントアウト
"set complete=.,w,b,u,k,t
"補完ウィンドウの設定 :help completeopt
set completeopt=menuone

"起動時に有効
let g:neocomplcache_enable_at_startup = 0
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20
"自動補完を行う入力数を設定。初期値は2
let g:neocomplcache_auto_completion_start_length = 2
"手動補完時に補完を行う入力数を制御。値を小さくすると文字の削除時に重くなる
let g:neocomplcache_manual_completion_start_length = 3
"バッファや辞書ファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_keyword_length = 4
"シンタックスファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_syntax_length = 4
"1:補完候補検索時に大文字・小文字を無視する
let g:neocomplcache_enable_ignore_case = 1
"入力に大文字が入力されている場合、大文字小文字の区別をする
let g:neocomplcache_enable_smart_case = 1
";で英数字候補選択できるようにしたかったけど動かない
"動かないのは仕様のようです。コメントアウト
"let g:neocomplcache_quick_match_patterns = {
"  \ 'default' : ';'
"  \ }
"大文字小文字を区切りとしたあいまい検索を行うかどうか。
"DTと入力するとD*T*と解釈され、DateTime等にマッチする。
let g:neocomplcache_enable_camel_case_completion = 0
"アンダーバーを区切りとしたあいまい検索を行うかどうか。
"m_sと入力するとm*_sと解釈され、mb_substr等にマッチする。
let g:neocomplcache_enable_underbar_completion = 0

"neocomplcacheを自動的にロックするバッファ名のパターンを指定。
"ku.vimやfuzzyfinderなど、neocomplcacheと相性が悪いプラグインを使用する場合に設定。
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"キャッシュディレクトリの場所
let g:neocomplcache_temporary_dir = $HOME.'/.neocon'

"シンタックス補完を無効に
let g:neocomplcache_plugin_disable = {
\ 'tags_complete' : 1,
\ 'omni_complete' : 1,
\ 'syntax_complete' : 1,
\ }

"補完するためのキーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"twigはhtmlと同じに
let g:neocomplcache_keyword_patterns['twig'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'

"関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

"カーソルより後のキーワードパターンを認識。
"h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
"修正するときにかなり便利。
"g:neocomplcache_next_keyword_patternsは分からないときはいじらないほうが良いです。
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif
"よく分からない場合は未設定のほうがよいとのことなので、ひとまずコメントアウト
"let g:neocomplcache_next_keyword_patterns['php'] = '\h\w*>'
"twigはhtmlと同じに
let g:neocomplcache_next_keyword_patterns['twig'] = '[[:alnum:]_:-]*>\|[^"]*"'

"ファイルタイプの関連付け
if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists = {}
endif
"let g:neocomplcache_same_filetype_lists['ctp'] = 'php'
"let g:neocomplcache_same_filetype_lists['twig'] = 'html'

"ディクショナリ補完
"ファイルタイプごとの辞書ファイルの場所
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'php' : $HOME . '/.vim/dict/php.dict',
  \ 'ctp' : $HOME . '/.vim/dict/php.dict',
  \ 'vimshell' : $HOME . '/.vimshell/command-history',
  \ }

"タグ補完
"タグファイルの場所
augroup SetTagsFile
  autocmd!
  autocmd FileType php set tags=$HOME/.vim/tags/php.tags
augroup END
"タグ補完の呼び出しパターン
if !exists('g:neocomplcache_member_prefix_patterns')
  let g:neocomplcache_member_prefix_patterns = {}
endif
let g:neocomplcache_member_prefix_patterns['php'] = '->\|::'

"スニペット補完
"標準で用意されているスニペットを無効にする。初期化前に設定する
let g:neocomplcache_snippets_disable_runtime_snippets = 1
"スニペットファイルの置き場所
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

"zencoding連携
let g:use_zen_complete_tag = 1

"オムニ補完
augroup SetOmniCompletionSetting
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ctp setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType twig setlocal omnifunc=htmlcomplete#CompleteTags
"  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END

"オムニ補完のパターンを設定
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns['twig']= '<[^>]*'
"let g:neocomplcache_omni_patterns['php'] = '[^. \t]->\h\w*\|\h\w*::'


"インクルード補完。よくわからない。初期化のみに留める
"通常は設定する必要はないらしい。
"Vim標準のインクルード補完を模倣しているそうなので、そちらを勉強する
if !exists('g:neocomplcache_include_paths')
    let g:neocomplcache_include_paths = {}
endif
if !exists('g:neocomplcache_include_patterns')
    let g:neocomplcache_include_patterns = {}
endif
if !exists('g:neocomplcache_ctags_arguments_list')
    let g:neocomplcache_ctags_arguments_list = {}
endif

""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" tab
nnoremap <silent> ,ut :<C-u>Unite tab<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_ctags_bin = $HOME . '/opt/ctags/bin/ctags'

" local config
if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif

