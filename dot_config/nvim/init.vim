syntax on
set relativenumber
set mouse=a 
set number
set undofile
set cursorline 
set incsearch
set hlsearch
set showmatch 
filetype plugin on
nnoremap <SPACE> <Nop>
map <SPACE> <leader>
set tabstop=4
set formatoptions-=cro
set ignorecase
set smartcase
set wrap

" Plugin installer
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'

Plug 'junegunn/goyo.vim'

Plug 'andymass/vim-matchup'

Plug 'flazz/vim-colorschemes'

Plug 'sainnhe/gruvbox-material'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'mhinz/vim-startify'

Plug 'morhetz/gruvbox'

Plug 'preservim/nerdtree'

Plug 'catppuccin/nvim'

Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

set clipboard+=unnamedplus
set wrap

" Colorscheme
colorscheme dracula 
"colorscheme gruvbox
let g:airline_theme='dracula'
set background=dark
let g:gruvbox_italic=1 
set statusline=%F[%L][%{&ff}]%y[%04l,%04v]
let g:airline_powerline_fonts = 1 
let g:rainbow_active = 1 

"Keybindings
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>G :Goyo <CR> :set number <CR> :set relativenumber <CR>
nnoremap <leader>i :set hlsearch! <CR>
nnoremap <leader>q :x <CR>
nnoremap <leader>x :qa! <CR> 
nnoremap <leader>w :w <CR>
nnoremap <leader>v <C-w>v
nnoremap <leader>l <C-w>l 
nnoremap <leader>h <C-w>h
nnoremap <leader>n :NERDTreeToggle <CR>
nnoremap <leader>N :NERDTreeFocus <CR>


:highlight Cursorline cterm=bold
set tabstop =4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set cursorline
set termguicolors
let g:loaded_matchit= 1
:hi MatchParen guibg=white
let g:startify_custom_header =
          \ 'startify#center(startify#fortune#cowsay())'


"Neovide config
let g:neovide_transparency=0.9
let g:neovide_refresh_rate=144
let g:neovide_cursor_antialiasing=v:true
set guifont=JetBrainsMono\ Nerd\ Font:h10

