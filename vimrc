" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Rebind <Leader> key
let mapleader = ","

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'captbaritone/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'ajh17/spacegray.vim'

" Syntax
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Make tab handle all completions
Plug 'ervandew/supertab'

" Fancy statusline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy file opener
Plug 'ctrlpvim/ctrlp.vim'

" Navigate files in a sidebar
Plug 'scrooloose/nerdtree'

" Only show cursorline in the current window
Plug 'vim-scripts/CursorLineCurrentWindow'

" Change brackets and quotes
Plug 'tpope/vim-surround'

" Custom motions

" Argument object
Plug 'vim-scripts/argtextobj.vim'

" Fugitive: Git from within Vim
Plug 'tpope/vim-fugitive'

" Show git status in the gutter
Plug 'airblade/vim-gitgutter'

" Wrap and upwrap argument lists
Plug 'FooSoft/vim-argwrap'

" Python-mode
Plug 'python-mode/python-mode', { 'for': 'python' }

call plug#end()


" Wrap / unwrap arguments
nnoremap <silent> <leader>a :ArgWrap<CR>

" Markdown settings
"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_folding_style_pythonic = 1

" ----------------------------------------------------------------------------
" General settings
" ----------------------------------------------------------------------------

" gets rid of extra space
autocmd BufWritePre * %s/\s\+$//e

" map ctrl n to line numbers
:nmap <C-N><C-N> :set invnumber<CR>

" Quick quit command
noremap <Leader>e :quit<CR> " Quit current window
noremap <Leader>E :qa!<CR> " Quit all windows

" Move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Move between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Show white spaces, must be inserted before color scheme
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
set t_Co=256
color wombat256mod

" Disable compatible mode
set nocp
set nocompatible

" Showing line numbers and length
set number " show line numbers
set tw=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup files
set nobackup
set nowritebackup
set noswapfile

" Settings for ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" load up the nerd tree
" autocmd vimenter * NERDTree
" map <Leader>t <plug>NERDTreeTabsToggle<CR>
" let g:NERDTreeWinPos = "right"

" paste toggle
set pastetoggle=<F2>

" python_mode settings
let g:pymode_python = 'python3'
let g:pymode_breakpoint = 0
