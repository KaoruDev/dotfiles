set nocompatible
" Let VIM know the terminal can support 256 colors
set t_Co=256
filetype plugin on
colorscheme molokai
set number
syntax on
set hlsearch
set tabstop=2 shiftwidth=2 expandtab smartindent
set nowrap
set nowritebackup " Disabled so gulp doesn't rewatch things twice, vim has it on to reduce risk of data loss on save
set backspace=2 " fix weird VIM 7.4 backspace behavior
set cursorline

" Map leader key to ,
let mapleader = "'"

" Erase white space on save
autocmd BufWritePre * :%s/\s\+$//e

" Map CTRL(hjkl) to switch panes easier
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" map jj to esc
imap jj <Esc>

" toggle between paste modes
nnoremap <C-p> :set invpaste paste?<CR>

" Close Buffer but not pane
nmap <leader>w :b#<bar>bd#<CR>
noremap <leader>j <S-j>
nmap <S-j> 10j
nmap <S-k> 10k
imap <C-d> <esc>ldBi

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Setup fuzzy search
set rtp+=~/.fzf
nmap f :call fzf#run({
 \  'source': 'find . -type f -not -path "*node_modules*" -not -path "*bower_components*" -not -path "*.git*" -not -path "*sass-cache*"',
 \  'sink': 'edit'
 \  })<Enter>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>

endif

" Handlebars Syntax
Plugin 'mustache/vim-mustache-handlebars'
au BufReadPost *.hbs set filetype=html.mustache syntax=html.mustache
au BufReadPost *.ejs set filetype=html
au BufReadPost *.jst set filetype=html

" emmet plugin for css / html
Plugin 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<S-tab>'

Plugin 'tpope/vim-haml'
au BufReadPost *.haml set filetype=haml
au BufReadPost *.hamlc set filetype=haml

"tab indentation lines
let g:indentLine_char = '|'
Plugin 'Yggdroot/indentLine'

" Plugin to help comment block
Plugin 'scrooloose/nerdcommenter'

" Plugin for the nifty status bar
Bundle 'bling/vim-airline'

" Enable tabline extension
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " # of splits (default)
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme="luna"
" Mapping to switch tabs easily
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader><tab> :bn<Enter>
nmap <leader><s-tab> :bp<Enter>

" TMUX line Bottom status bar?
Plugin 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#color_template = 'visual'

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
   let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
   let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Coffee Script syntax highlighting
Plugin 'kchmck/vim-coffee-script'
au BufReadPost *.coffee set filetype=coffee

" NerdTree
Plugin 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw=0

" Syntastic
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_sass_checkers = []
let g:syntastic_scss_checkers = []
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

