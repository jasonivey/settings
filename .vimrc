" vim: softtabstop=4:tabstop=4:shiftwidth=4:expandtab:cindent:foldmethod=manual:textwidth=120:filetype=vim
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'jeaye/color_coded'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'rhysd/vim-clang-format.git'
" Git plugin to add extensions into vim
Plugin 'tpope/vim-fugitive.git'
Plugin 'jremmen/vim-ripgrep'
" Plugin for go-lang
Plugin 'fatih/vim-go'
" Syntax Checker for Python, Rust, go... see below
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
" Plugin to ensure modeline does not contain anything invalid
Plugin 'ciaranm/securemodelines'
" Command :Bclose will close and destroy buffer
Plugin 'rbgrouleff/bclose.vim.git'
" Open header of the source file you are in
Plugin 'a.vim'
call vundle#end()

" Always set encoding to utf-8
set encoding=utf-8
let &t_Co=256
"set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

colorscheme challenger_deep
set transparency=5

if has("gui_running") && has("gui_macvim")
  set guifont=MesloLGS-NF-Regular:h11
endif

"Airline settings
let g:Powerline_symbols='unicode'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:laststatus=2
let g:airline_theme='murmur'

" Syntastic Plugin Modifications
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checkers=['pylint', 'flake8']
let g:syntastic_aggregate_errors=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let python_highlight_all=1

if has('mac')
    vnoremap <C-C> :w !pbcopy<CR><CR>
    inoremap <C-V> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
elseif has('unix')
    vnoremap <C-c> :w !xclip -i -sel c<CR><CR>
    inoremap <C-V> <Esc>:set paste<CR>:r !xclip -o<CR>:set nopaste<CR>
endif

if has('mouse')
    set mouse=a
endif

" Remap F3 <previous> and F4 <next> to step through the quickfind results
nnoremap <S-F4> :cp<CR>
nnoremap <F4> :cn<CR>

" Move backups and swp files to a dedicated location
if !isdirectory($HOME . "/.vim/backups")
    call mkdir($HOME . "/.vim/backups", "p")
endif
if !isdirectory($HOME . "/.vim/swapfiles")
    call mkdir($HOME . "/.vim/swapfiles", "p")
endif
set backupdir=$HOME/.vim/backups//
set directory=$HOME/.vim/swapfiles//
set swapfile
set writebackup

" Enable code file customization with modelines
set modeline
set modelines=5

set noautochdir

" Note: with this set all vi copy and paste in visual mode get put into system
"  buffer. This is a little overwhelming as someone not used to this behavior.
" set yank to update the clipboard
"set clipboard=unnamed

" Remap the leader key from \ to ,
let mapleader=","

" Set the line wrap
set nowrap

" Auto indent
set autoindent

" Highlight trailing whitespace by default
highlight ws ctermbg=red guibg=red
match ws /\s\+$/
autocmd BufWinEnter * match ws / \+$/

" Tab settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
"set listchars=eol:¬,tab:>,trail:~,extends:>,precedes:<,space:␣
set listchars=trail:~
set list

" Allows you to press <Shift><Tab> to insert a real <tab> character
"inoremap <S-Tab> <C-V><Tab>

set completeopt=longest

" Set case insensitivity
set ignorecase

" Unless there's a capital letter
set smartcase

" Highlight the search
set hlsearch

" Highlight as we search however
set incsearch

" Blink matching chars for .x seconds
set matchtime=5

" Turn on the line and offset markers in the bottom right corner
set ruler

" No error bells please
set noerrorbells

" Fix the backspace key
set backspace=2

" set the ctags location
set tags=./tags,./TAGS,tags;~,TAGS;~

" Map <ctrl-l> to turn off highlighting the search terms
noremap <silent> <c-l> :nohls<cr><c-l>

filetype plugin indent on

" Activate syntax highlighting
syntax on

" Not sure why, but these theme/color customizations must after the above two lines
highlight ColorColumn ctermbg=cyan guibg=lightcyan
highlight LineNr term=bold cterm=bold ctermbg=black ctermfg=green guibg=black guifg=lightgreen
highlight clear CursorLine
highlight CursorLine term=underline cterm=underline gui=underline ctermbg=NONE guibg=NONE

" Highlight current line
set cursorline
" Create a virtical column to makr a 120 characters 
set colorcolumn=120
" Show line numbers
set number

" Add bindings for clang-format
let g:clang_format#command ='clang-format'
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" ripgrep options
let g:rg_highlight=1
let g:rg_derive_root=1
let g:rg_root_types=['.git','.hg','.svn','.bzr']

" Adjust YouCompleteMe options
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_error_symbol='E>'
let g:ycm_warning_symbol='W>'
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_complete_in_comments=0
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_goto_buffer_command='vertical-split'
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
let g:ycm_confirm_extra_conf=0
let g:ycm_global_ycm_extra_conf='$HOME/settings/.doesnotexist.py'
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <F12> :YcmCompleter GoToDefinition<CR>
nnoremap <S-F12> :YcmCompleter GoToDeclaration<CR>

" Adjust NERDTree to always show hidden files
let g:NERDChristmasTree       = 1
let g:NERDTreeQuitOnOpen      = 1
let g:NERDTreeShowHidden      = 1
let g:NERDTreeMapToggleHidden = 'h'
let g:NERDTreeMapQuit         = 'q'
let g:NERDTreeMapToggleZoom   = 'z'
nnoremap <Leader>n :NERDTreeToggle<CR>

" Close the auto-complete tip window after selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Adjust the NERDCommenter settings
let g:NERDRemoveExtraSpaces=0  " if value=1 '// int a = 0;' will uncomment to 'int a = 0;'
let g:NERDDefaultNesting=0     " disable the ability to comment block and then comment again nesting them
map <Leader>c <plug>NERDCommenterAlignLeft
map <Leader>u <plug>NERDCommenterUncomment

filetype plugin on

" color_coded options
" Disable color_coded in diff mode
if &diff
  let g:color_coded_enabled = 0
else
  let g:color_coded_enabled = 1
endif
let g:color_coded_filetypes = ['c', 'cc', 'cpp', 'h', 'hh', 'hpp', 'objc']

" Set up the auto tab and indent settings for the following types
autocmd FileType make set noexpandtab
autocmd Filetype c,cpp,cs,java,objc,php,py set cindent tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" CTRL-P Settings
let g:ctrlp_map='<Leader>t'
let g:ctrlp_max_files=200000
let g:ctrlp_show_hidden=1
set wildignore+=*.o,*.d,*.git,CMakeFiles
