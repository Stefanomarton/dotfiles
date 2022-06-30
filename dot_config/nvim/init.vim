"------------------------------------------------------ Plugin installer ------------------------------------------ "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

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

Plug 'norcalli/nvim-colorizer.lua'

Plug 'tridactyl/vim-tridactyl'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'yaocccc/vim-surround'

Plug 'vim-pandoc/vim-pandoc'

Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'vim-pandoc/vim-rmarkdown'

Plug 'lervag/vimtex'

Plug 'sirver/ultisnips'

"Plug 'svermeulen/vim-macrobatics'

Plug 'Stefanomarton/texgroff.vim'

call plug#end()

" ------------------------- Theming --------------------------------

" Colorscheme
colorscheme dracula
"colorscheme gruvbox
let g:airline_theme='dracula'
set background=dark
let g:gruvbox_italic=1
set statusline=%F[%L][%{&ff}]%y[%04l,%04v]
let g:airline_powerline_fonts = 1
let g:rainbow_active = 1

"--------------------------------------------- Settings -----------------------------------------------"

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
set tabstop=4
set formatoptions-=cro
set ignorecase
set smartcase
set wrap
set noshowcmd
set wildmode=longest,list,full
set clipboard+=unnamedplus
set wrap
:set nospell
let g:markdown_enable_spell_checking = 0

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


" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" Ultisnips config
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


"Neovide config
let g:neovide_transparency=0.9
let g:neovide_refresh_rate=144
let g:neovide_cursor_antialiasing=v:true
set guifont=JetBrainsMono\ Nerd\ Font:h10

"Vim-markdown
let g:markdown_enable_mappings = 0
let g:mkdp_browser = '/bin/firefox'
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'



"-------------------------------------------------------------- Keybindings --------------------------"

nnoremap <SPACE> <Nop>
map <SPACE> <leader>
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
nnoremap <leader>è :source $MYVIMRC<CR>


" Compiling shortcuts
nnoremap <leader>t !autocomp
"
"noremap <leader>P :w<CR> :!pdflatex %:r.tex && bibtex %:r.aux && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl<cr>
noremap <leader>P :w<CR> :!pdflatex %:r.tex && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl<cr>
noremap <leader>L :!zathura %:r.pdf > /dev/null 2>&1 &<cr><cr>

noremap <leader>p :call Preview()<CR><CR><CR>
noremap <leader>c :call Compile()<CR><CR>
map <leader>C :w! \| !compiler "<c-r>%"<CR>
map <leader>o :!opout <c-r>%<CR><CR>
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"Chezmoi autocmd
autocmd BufWritePost ~/.local/share/chezmoi/* !chezmoi apply --source-path "%"

" Autocmd
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
