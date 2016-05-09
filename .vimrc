set nocompatible
" Let VIM know the terminal can support 256 colors
set t_Co=256
filetype plugin off
" colorscheme pencil
set number
syntax on
set hlsearch
set tabstop=2 shiftwidth=2 expandtab smartindent
set nowrap
set nowritebackup " Disabled so gulp doesn't rewatch things twice, vim has it on to reduce risk of data loss on save
set backspace=2 " fix weird VIM 7.4 backspace behavior
set cursorline
set noswapfile
set re=1
set textwidth=80
set colorcolumn=+1

" Map leader key to ,
let mapleader = "\<Space>"

" Erase white space on save
autocmd BufWritePre * :%s/\s\+$//e

" Map CTRL(hjkl) to switch panes easier
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Map Window Resizes
map <leader>h <C-w>\|
map <leader>v <C-w>_
map <leader>e <C-w>=

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
nmap ff :call fzf#run({
 \  'source': 'find . -type f -not -path "*node_modules*" -not -path "*bower_components*" -not -path "*.git*" -not -path "*sass-cache*" -not -path ".tmp"',
 \  'sink': 'edit'
 \  })<Enter>

" Opens file Vertically
nmap fv :call fzf#run({
 \  'source': 'find . -type f -not -path "*node_modules*" -not -path "*bower_components*" -not -path "*.git*" -not -path "*sass-cache*" -not -path ".tmp"',
 \  'down': '40%',
 \  'sink': 'botright split' })<CR>
 \  })<Enter>

" Opens file Horizontal
nmap fh :call fzf#run({
 \  'source': 'find . -type f -not -path "*node_modules*" -not -path "*bower_components*" -not -path "*.git*" -not -path "*sass-cache*" -not -path ".tmp"',
 \  'sink': 'vertical botright split',
 \  'right': winwidth('.') / 2,
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
  " bind K to grep word under cursor
  nnoremap <C-\> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

endif

" Json Syntax
Plugin 'elzr/vim-json'
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END

" Handlebars Syntax
Plugin 'mustache/vim-mustache-handlebars'
au BufReadPost *.hbs set filetype=html.mustache syntax=html.mustache
au BufReadPost *.ejs set filetype=html
au BufReadPost *.jst set filetype=html

" Elixir Syntax
Plugin 'elixir-lang/vim-elixir'
au BufReadPost *.ex set filetype=elixir
au BufReadPost *.exs set filetype=elixir
au BufReadPost *.eex set filetype=elixir

" emmet plugin for css / html
Plugin 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<S-tab>'

Plugin 'tpope/vim-haml'
au BufReadPost *.haml set filetype=haml
au BufReadPost *.hamlc set filetype=haml

"tab indentation lines
let g:indentLine_char = '|'
" fix the json coneal
let g:indentLine_noConcealCursor=""
Plugin 'Yggdroot/indentLine'

nmap <C-i> :IndentLinesToggle<CR>

" Plugin to help comment block
Plugin 'scrooloose/nerdcommenter'

" Plugin for the nifty status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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

" Jade / Pug syntax highlighting
Plugin 'digitaltoad/vim-pug'
au BufReadPost *.jade set filetype=coffee

" NerdTree
Plugin 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw=0

" Pencil Color scheme
Plugin 'reedes/vim-colors-pencil'
set background=light " for pencil colorscheme
autocmd VimEnter * colorscheme pencil

" Syntastic
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Toggle syntastic checker
map <C-c> :SyntasticToggleMode<CR>

let g:syntastic_javascript_checkers = ['jshint', 'jscs']
let g:syntastic_sass_checkers = []
let g:syntastic_scss_checkers = []
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" ignore certain html rules
let g:syntastic_html_tidy_ignore_errors = [
    \   'escaping malformed URI reference',
    \   'trimming empty',
    \   'proprietary attribute "NULL"',
    \   'attribute "method" has invalid value',
    \   'missing </a> before <div>',
    \   'discarding unexpected </a>'
    \ ]

let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of'}

" Pry shortcut
nmap <leader>pry orequire('pry');binding.pry<ESC>
" Awesome Print shortcut
nmap <leader>ap orequire('awesome_print');ap
" debugger shortcut
nmap <leader>debug odebugger;<ESC>
" console.log shortcut
nmap <leader>log oconsole.log(;<ESC>
" number toogle
nmap <leader>N :set invnumber<CR>

" Run rspec from vim
Plugin 'thoughtbot/vim-rspec'

let g:rspec_command = '!bundle exec rspec --format documentation {spec}'
let g:rspec_runner = "os_x_iterm2"
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
  execute "source ".b:vim
endif
