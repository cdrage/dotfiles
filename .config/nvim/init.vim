" Needed to run plugins
set nocompatible
filetype plugin indent off
syntax off

" Install those plugins
call plug#begin('~/.vim/plugged')
  Plug 'pearofducks/ansible-vim'
  Plug 'preservim/nerdtree'
  Plug 'benmills/vimux'
  Plug 'kien/ctrlp.vim'
  Plug 'andviro/flake8-vim'
  Plug 'rking/ag.vim'
  Plug 'SirVer/ultisnips'
  Plug 'ervandew/supertab'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'tarekbecker/vim-yaml-formatter'
  Plug 'mzlogin/vim-markdown-toc'

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
  Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

  " Snippets
	Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  " Linting
  Plug 'w0rp/ale'

  " Rust
  Plug 'rust-lang/rust.vim'

  " Terraform
  Plug 'hashivim/vim-terraform'

  " Typescript / javascript
  Plug 'leafgarland/typescript-vim'


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
" Deoplete python3 stuff
"
" let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3.7"
let g:deoplete#enable_at_startup = 1

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
" FOLDING
"
" set foldmethod=syntax

" 
" CODE LINTING
"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

"
" GO STUFF
"

" Highlight
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Highlight same names
let g:go_auto_sameids = 0

" 
" HTML STUFF
"
au BufRead,BufNewFile *.template set filetype=html

" 
" YAML STUFF
"

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
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

" ===========================
" Shortcuts for tmux / running a command in the other window

" Run the last command
:map rr :call VimuxRunCommand("r")<CR> 

" Interrupt
:map rc :VimuxInterruptRunner<CR>

" ===========================
"
"
" OTHER
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:signify_sign_delete_first_line = 'x'
let g:loaded_clipboard_provider = 0

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
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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

" Snippets!
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.config/nvim/mysnippets'

let g:vim_markdown_conceal = 0
