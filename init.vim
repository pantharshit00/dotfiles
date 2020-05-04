" Use relative numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Indentation settings
set autoindent
set smarttab
set smartindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set incsearch

" Autoreload if contents are changed
set autoread

" change the leader key
let mapleader = " "

" Remap the escape key
:imap jk <Esc>

" Remap buffer navigation keys
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Natural position for new split opening
set splitbelow
set splitright

" Plugins
call plug#begin('~/.config/nvim')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'preservim/nerdcommenter'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline' " Shiny little status bar at the botto
Plug '/usr/local/opt/fzf' " fzf is installed via homebrew
Plug 'junegunn/fzf.vim'
Plug 'jparise/vim-graphql'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'cespare/vim-toml'
" Development Plugin(that I am writing)
Plug '~/code/vim-prisma', { 'as':'vim-prisma'}
call plug#end()

" enable filetype plugins
filetype plugin on

if (has("termguicolors"))
 set termguicolors
endif
" color scheme
syntax on
set background=dark
colorscheme palenight
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1
" if hidden is not set, TextEdit might fail.
set hidden

" Some coc servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" coc vim airline support
let g:airline#extensions#coc#enabled = 1
" extensions
let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ 'coc-rust-analyzer', 
  \ 'coc-json', 
  \ 'coc-html', 
  \ 'coc-css',
  \ 'coc-pairs',
  \ 'coc-emmet'
  \ ]
" coc-prettier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Improved <CR> for pairs
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" remap <C-t> to fzf
map <C-t> :FZF<CR>

" Remap comment key
nmap <C-_> <plug>NERDCommenterToggle 
vmap <C-_> <plug>NERDCommenterToggle 

" Add one space after the comment characters
let NERDSpaceDelims=1

" NERDTree options
" autocmd vimenter * NERDTree " automatically open NERDTree when I start vim
" Next map is so that I can use Ctrl + B to toggle NERDTree
map <C-b> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " show dotfiles
let g:NERDTreeIgnore = ['^node_modules$']
" sync cursor line with NERDTree
let g:nerdtree_sync_cursorline = 1

" Opens vimrc using a shortcut
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" sources vimrc via a shortcut
nnoremap <leader>sv :source $MYVIMRC<cr>

vnoremap <leader>y "*y

nnoremap <leader>d Yp
