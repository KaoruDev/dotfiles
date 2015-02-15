set nocompatible
filetype plugin on
colorscheme molokai
set number
syntax on
set hlsearch
set tabstop=2 shiftwidth=2 expandtab smartindent
set nowrap
set nowritebackup " Disabled so gulp doesn't rewatch things twice, vim has it on to reduce risk of data loss on save

" map jj to esc
imap jj <Esc>

" Map leader key to ,
let mapleader = ","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Setup fuzzy search
set rtp+=~/.fzf
nmap f :FZF<Enter>

" multi-cursor
Plugin 'terryma/vim-multiple-cursors'

" emmet plugin for css / html
Plugin 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<S-tab>'

" tab indentation lines
Plugin 'Yggdroot/indentLine'
let g:indentLine_loaded = 0

" Plugin for the nifty status bar
Bundle 'bling/vim-airline'

" Plugin to help comment blocks
Plugin 'scrooloose/nerdcommenter'
" Enable tabline extension
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
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

" Erase white space on save
autocmd BufWritePre * :%s/\s\+$//e

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

