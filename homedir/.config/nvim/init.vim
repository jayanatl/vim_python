if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fisadev/fisa-vim-colorscheme'
Plug 'romainl/Apprentice'
Plug 'wikitopian/hardmode'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sheerun/vim-polyglot' " Additional language pack
Plug 'lilydjwg/colorizer' " Colorize color code text line #0f0
Plug 'heavenshell/vim-pydocstring'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'fisadev/FixedTaskList.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/context_filetype.vim'
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 't9md/vim-choosewin'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'arakashic/nvim-colors-solarized'
Plug 'wesQ3/vim-windowswap'

" Look at this later: https://github.com/ryanoasis/nerd-fonts
" Good for airline / nerdtree / etc...
"Plug 'ryanoasis/vim-devicons'
"Another one for easy motion witin VIM
"Plug 'easymotion/vim-easymotion'
call plug#end()

" Neovim Python interpretter configuration
let g:python_host_prog = expand('/bin/python2')
let g:python3_host_prog = expand('/bin/python3.6')

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    colorscheme apprentice
else
    colorscheme fisa
endif

" Airline
let g:airline_powerline_fonts = 1
"let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" NERDTree
let NERDTreeShowHidden=0
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$[[file]]', '\.pyo$[[file]]', '*cache[[dir]]']

" Tagbar display
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
"let g:tagbar_iconchars = ['↠', '↡']

" Supertab
let g:SuperTabDefaultCompletionType = "<C-n>"

" mapping
nmap  -  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1 " show big letters

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'
set completeopt-=preview " Disable documentation window

" Jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>D"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>b"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
nmap ;D :vsplit<CR>:call jedi#goto()<CR>
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1

" ale signs for errors and warnings
let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '⚠'
let g:ale_sign_warning = '!'
let g:ale_fixers = {
\    'python': ['isort','yapf'],
\}
"let g:ale_fix_on_save = 1
let g:ale_enabled = 1
let g:ale_enabled = 1

" Tasklist
map <F2> :TaskList<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Shortcuts
let mapleader=","
nmap <silent> <leader><leader> :noh<CR>
nmap <leader>tt :tabnew<CR>
nmap <leader>m :tabnext<CR>
nmap <leader>n :tabprevious<CR>
nmap <C-d> yyp
imap <C-d> <ESC>yypi
nmap <leader>E :qa!<CR>
nmap <leader>e :q!<CR>

" Hardmode
let g:HardMode_level = 'wannabe' " Comment this line to enable advanced mode
"Toggle vim hardmode which disables simple motion keys
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Other settings
set list listchars=trail:»,tab:»-
set number relativenumber
set cursorline cursorcolumn colorcolumn=120 scrolloff=3
set splitbelow splitright noequalalways
set hlsearch incsearch ignorecase smartcase " Fix searching
"set mouse=a

" Switching windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clipboard settings
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
tmap <C-d> <Esc>:q<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Show CRLF
set ffs=unix
