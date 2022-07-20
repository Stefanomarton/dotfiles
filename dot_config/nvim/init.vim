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

Plug 'vimoxide/vim-quickscope'

Plug 'Stefanomarton/texgroff.vim'

Plug 'liuchengxu/vim-which-key'

Plug 'neoclide/coc.nvim' 

Plug 'voldikss/vim-floaterm'



call plug#end()

" ---------------------------------------------Theming -----------------------------------------------"

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
set scrolloff=8
set modifiable 
syntax on
set relativenumber
set mouse=a
set number
set undofile
set cursorline
set incsearch
set hlsearch
set showmatch
filetype on
filetype plugin on
filetype indent on
set tabstop=4
set formatoptions-=cro
set ignorecase
set smartcase
set wrap
"set noshowcmd
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
let g:startify_custom_header = 'startify#center(startify#fortune#cowsay())'


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

"Vim-which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=250
"let g:mapleader = "\<Space>"

"Quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#eF5F70' gui=underline ctermfg=81 cterm=underline

let g:qs_max_chars=350


let g:coc_global_extensions = [ 'coc-snippets', 'coc-pairs', 'coc-vimtex', 'coc-explorer', 'coc-json', 'coc-yank', ]

"-------------------------------------------------------------- Keybindings --------------------------------------------------------"

nnoremap <SPACE> <Nop>
map <SPACE> <leader>
nnoremap <leader>G :Goyo<CR>
nnoremap <leader>g :Goyo <CR> :set number <CR> :set relativenumber <CR>
nnoremap <leader>i :set hlsearch! <CR>
nnoremap <leader>q :x <CR>
nnoremap <leader>x :qa! <CR>
nnoremap <leader>w :w <CR>
nnoremap <leader>v <C-w>v
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>n :CocCommand explorer <CR>
nnoremap <leader>è :source $MYVIMRC<CR>
nnoremap J 4j
nnoremap K 4k


" Compiling shortcuts
"noremap <leader>P :w<CR> :!pdflatex %:r.tex && bibtex %:r.aux && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl<cr>

noremap <leader>P :w<CR> :!pdflatex -shell-escape %:r.tex && pdflatex -shell-escape %:r.tex && pdflatex -shell-escape %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl %:r.fls %:r.fdb_latexmk<cr><cr>
map <leader>C :w! \| !compiler "<c-r>%"<CR>
noremap <leader>L :!zathura %:r.pdf > /dev/null 2>&1 &<cr><cr>

" Automatically refresh preview when saving groff file
autocmd FileType groff nnoremap <buffer> <leader>w :w<CR> :call Compile()<CR>

"Easy preview for markdown, latex and groff
noremap <leader>p :call Preview()<CR><CR><CR>
noremap <leader>c :call Compile()<CR><CR>

"Chezmoi autocmd
autocmd BufWritePost ~/.local/share/chezmoi/* !chezmoi apply --source-path "%"

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-floaterm',
  \ 'coc-vimtex',
  \ 'coc-explorer',
  \ 'coc-json',
  \ 'coc-yank',
  \'coc-python',
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <A-Tab>   
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use K to show documentation in preview window.
nnoremap <silent> <A-K> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
    

