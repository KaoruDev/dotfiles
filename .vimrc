set nocompatible
" Let VIM know the terminal can support 256 colors
set t_Co=256
filetype plugin off
set number
syntax on
set hlsearch
set tabstop=2 shiftwidth=2 expandtab smartindent
set nowrap
set nowritebackup " Disabled so gulp doesn't rewatch things twice, vim has it on to reduce risk of data loss on save
set backspace=2 " fix weird VIM 7.4 backspace behavior
set cursorline
set noswapfile
set textwidth=80
set colorcolumn=+1
set synmaxcol=200
set re=1 " Used to speed up syntax for ruby

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

" Installs vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialize vim-plug junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~40%' }

" Setup fuzzy search
Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf
nmap ff :call fzf#run({
 \  'source': 'git ls-files --exclude-standard --others --cached',
 \  'sink': 'edit'
 \  })<Enter>

" Opens file Vertically
nmap fv :call fzf#run({
 \  'source': 'git ls-files --exclude-standard --others --cached',
 \  'down': '40%',
 \  'sink': 'botright split' })<CR>
 \  })<Enter>

" Opens file Horizontal
nmap fh :call fzf#run({
 \  'source': 'git ls-files --exclude-standard --others --cached',
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
Plug 'elzr/vim-json'
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END

" Handlebars Syntax
Plug 'mustache/vim-mustache-handlebars'
au BufReadPost *.hbs set filetype=html.mustache syntax=html.mustache
au BufReadPost *.ejs set filetype=html
au BufReadPost *.jst set filetype=html

" Elixir Syntax
Plug 'elixir-lang/vim-elixir'
au BufReadPost *.ex set filetype=elixir
au BufReadPost *.exs set filetype=elixir
au BufReadPost *.eex set filetype=elixir

" emmet plugin for css / html
Plug 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key = '<S-tab>'

Plug 'tpope/vim-haml'
au BufReadPost *.haml set filetype=haml
au BufReadPost *.hamlc set filetype=haml

"tab indentation lines
let g:indentLine_char = '|'
" fix the json coneal
let g:indentLine_noConcealCursor=""
Plug 'Yggdroot/indentLine'

nmap <C-i> :IndentLinesToggle<CR>

" NerdCommenter
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Plug for the nifty status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
Plug 'edkolev/tmuxline.vim'
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#color_template = 'visual'

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
   let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
   let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Coffee Script syntax highlighting
Plug 'kchmck/vim-coffee-script'
au BufReadPost *.coffee set filetype=coffee

" Jade / Pug syntax highlighting
Plug 'digitaltoad/vim-pug'
au BufReadPost *.jade set filetype=pug

" Docker syntax highlighting
Plug 'ekalinin/Dockerfile.vim'

" JSX syntax highlighting
Plug 'pangloss/vim-javascript'

" NerdTree
Plug 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw=0

" Jinja syntax highlight
Plug 'Glench/Vim-Jinja2-Syntax'
au BufReadPost *.jinja set filetype=jinja

" Syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Toggle syntastic checker
map <C-c> :SyntasticToggleMode<CR>

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_ruby_rubocop_args = "--force-exclusion"
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
Plug 'thoughtbot/vim-rspec'

" Pencil Color scheme
Plug 'reedes/vim-colors-pencil'
set background=light " for pencil colorscheme

"comment this out if have yet to run :PlugInstall
autocmd VimEnter * colorscheme pencil

let g:rspec_command = '!bundle exec rspec --format documentation {spec}'
let g:rspec_runner = "os_x_iterm2"
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" All of your Plugs must be added before the following line
call plug#end()
filetype plugin indent on    " required

let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
  execute "source ".b:vim
endif
