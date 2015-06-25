" vundle {{{1

" needed to run vundle (but i want this anyways)
set nocompatible

" vundle needs filtype plugins off
" i turn it on later
filetype plugin indent off
syntax off


" set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim

" start vundle environment
call vundle#begin()

" list of plugins {{{2
" let Vundle manage Vundle (this is required)
Plugin 'gmarik/Vundle.vim'

" to install a plugin add it here and run :PluginInstall.
" to update the plugins run :PluginInstall! or :PluginUpdate
" to delete a plugin remove it here and run :PluginClean
" 
"
" Import all the bundles
Bundle 'gmarik/vundle'
Bundle 'vim-multiple-cursors'
Bundle 'jellybeans.vim'
Bundle 'The-NERD-tree'
Bundle 'vimux'
Bundle 'ctrlp.vim'
Bundle 'scrooloose/syntastic.git'
Bundle 'vim-ruby/vim-ruby'
Bundle 'fatih/vim-go'

" add plugins before this
call vundle#end()

" now (after vundle finished) it is save to turn filetype plugins on
filetype plugin indent on
syntax on


filetype plugin indent on

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

" Formatting
set wrap
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set number
set t_Co=256
colors zenburn

" The-NERD-Tree 
let NERDTreeIgnore=['\.pyc$', '\~$']

" Keybindings
inoremap kj <Esc>
inoremap jj <Esc>:wq<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:signify_sign_delete_first_line = 'x'
set clipboard=unnamed

nnoremap tk :tabfirst<CR>
nnoremap tj :tablast<CR>
nnoremap tt :tabedit<Space>
nnoremap tm :tabm<Space>
nnoremap tc :tabclose<CR>
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>

nnoremap <f2> :NERDTreeToggle<cr>

" Misc
filetype off
filetype plugin indent off
filetype plugin indent on

syntax on
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set encoding=utf-8
filetype plugin on
set omnifunc=syntaxcomplete#Complete
