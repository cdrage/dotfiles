" Needed to run plugins
set nocompatible
filetype plugin indent off
syntax off

" Install those plugins
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'benmills/vimux'
  Plug 'kien/ctrlp.vim'
  Plug 'andviro/flake8-vim'
  Plug 'rking/ag.vim'
  Plug 'SirVer/ultisnips'
  Plug 'ervandew/supertab'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'tarekbecker/vim-yaml-formatter'

  " Git specific
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-fugitive'

  " Autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

  " Ruby
  Plug 'vim-ruby/vim-ruby'

  " Docker
  Plug 'ekalinin/Dockerfile.vim'

  " Go
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'zchee/deoplete-go', { 'do': 'make' }

  " Rust
  Plug 'rust-lang/rust.vim'

call plug#end()

" Revert back to normal
filetype plugin indent on
syntax on

"
" Neovim stuff
"

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=

"
" FORMATTING
"
set wrap
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set number
set t_Co=256
colors zenburn
set encoding=utf-8

" 
" YAML STUFF
"

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" 
" KEYBINDINGS
" 
inoremap 3' ```
inoremap kj <Esc>
inoremap jj <Esc>:wq<CR>

" Tab keybindings
nnoremap tk :tabfirst<CR>
nnoremap tj :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap tm :tabm<Space>
nnoremap tc :tabclose<CR>
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>

" Plugin keybindings
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap \ :Ag<SPACE>
:map rr :call VimuxRunCommand("r")<CR>
:map rc :VimuxInterruptRunner<CR>

"
" OTHER
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:signify_sign_delete_first_line = 'x'
set clipboard=unnamed

" If i'm within TMUX or w/e
syntax on
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"
" PLUGIN CONFIGURATION
"

" The-NERD-Tree 
let NERDTreeIgnore=['\.pyc$', '\~$']

" Notes directory
:let g:notes_directories = ['~/dropbox/txt/']
:let g:notes_conceal_url = 0
:let g:notes_list_bullets = ['*']
:let g:notes_tagsindex = 0
syntax on

" PyFlake shit
let g:PyFlakeDisabledMessages = 'C901'
let g:PyFlakeDisabledMessages = 'E501'
ret g:PyFlakeDefaultComplexity=20

" Ag
let g:ag_working_path_mode="r"

" Thanks xterm for remapping my F keys {
if &term =~ "xterm" || &term =~ "screen"
  map <Esc>OP <F1>
  map <Esc>OQ <F2>
  map <Esc>OR <F3>
  map <Esc>OS <F4>
  map <Esc>[16~ <F5>
  map <Esc>[17~ <F6>
  map <Esc>[18~ <F7>
  map <Esc>[19~ <F8>
  map <Esc>[20~ <F9>
  map <Esc>[21~ <F10>
  map <Esc>[23~ <F11>
  map <Esc>[24~ <F12>
endif

" Snippet stuff
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/mysnippets']
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" Disable scratch window
set completeopt-=preview

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Enable autocompletion on startup
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Copying
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
set mouse=v
