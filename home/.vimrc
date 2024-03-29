" Use the Solarized Dark theme
" set background=dark
" colorscheme solarized8
" let g:solarized_termtrans=1

" One Dark Theme
syntax on
colorscheme onedark

let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

let g:rainbow_active = 1

let g:floaterm_wintype = 'split'
let g:floaterm_height = 0.3

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ctrlp_show_hidden = 1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
"noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
"noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Toggles NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" Toggles Terminal
nnoremap <leader>t :FloatermToggle<CR>
" FZF Files
nnoremap <leader>f :FZF<CR>
" FZF Buffers
nnoremap <leader>b :Buffers<CR>
" Smart way to move between buffers
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>
" Indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	"autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Tabs
Plug 'pacha/vem-tabline'

" Rainbow brackets
Plug 'frazrepo/vim-rainbow'

" Surroundings (parentheses, brackets, quotes, etc)
Plug 'tpope/vim-surround'

" fzf
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'

" Floating Terminal
Plug 'voldikss/vim-floaterm'

" The NERDTree
Plug 'preservim/nerdtree'

" Git Wrapper
Plug 'tpope/vim-fugitive'

" Git lines changed
Plug 'airblade/vim-gitgutter'

" Syntax linting
Plug 'scrooloose/syntastic'

" VIM dev-icons
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

