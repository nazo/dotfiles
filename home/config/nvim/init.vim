" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Shougo/unite.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'

Plug 'tpope/vim-endwise'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }

" visual
Plug 'jdkanani/vim-material-theme'

" Ruby/Rails
Plug 'tpope/vim-rails'
Plug 'basyura/unite-rails'
Plug 'slim-template/vim-slim'

" Go
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" PHP
Plug 'StanAngeloff/php.vim'
Plug 'arnaud-lb/vim-php-namespace'

" Python
Plug 'davidhalter/jedi-vim'

" JavaScript/AltJS/SPA
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'kchmck/vim-coffee-script'
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
Plug 'posva/vim-vue'

" Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'

" Java

" Kotlin

" ObjC

" Swift

" template engine
Plug 'juvenn/mustache.vim'
Plug 'lumiliet/vim-twig'
Plug 'Glench/Vim-Jinja2-Syntax'

" devops
Plug 'hashivim/vim-terraform'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""

set listchars=trail:-,nbsp:+,tab:>.
set list

set number

" deoplete
let g:deoplete#enable_at_startup = 1

" the silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Mac
if has('mac')
  set clipboard=unnamed
endif

if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
set background=dark
colorscheme material-theme

