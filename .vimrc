" vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120
set nocompatible
filetype off

" Temporary because Python 3.7 is causing powerline to puke!
if has('python3')
  silent! python3 1
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'gmarik/vundle'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'jeaye/color_coded'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'wincent/command-t.git'
Plugin 'rhysd/vim-clang-format.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'rbgrouleff/bclose.vim.git'
Plugin 'jremmen/vim-ripgrep'
Plugin 'a.vim'
call vundle#end()

" Powerline
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols='fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata\ for\ Powerline:h15
   endif
endif

" Remap F3 <previous> and F4 <next> to step through the quickfind results
map <F3> :cp<CR>
map <F4> :cn<CR>

" Enable code file customization with modelines
set modeline
set modelines=5

set noautochdir

"set cursorline
set colorcolumn=120

" Remap the leader key from \ to ,
let mapleader=","

" Set the line wrap
set nowrap

" Auto indent
set autoindent

" Tab settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set list

" Allows you to press <Shift><Tab> to insert a real <tab> character
:inoremap <S-Tab> <C-V><Tab>

set completeopt=longest

" Highlight current line
" set cursorline

" Adjust color
" hi CursorLine term=none cterm=none ctermbg=red

" Set case insensitivity
set ignorecase

" Unless there's a capital letter
set smartcase

" Highlight the search
set hlsearch

" Highlight as we search however
set incsearch

" Activate syntax highlighting
" syntax on

" Blink matching chars for .x seconds
set matchtime=5

" Turn on the line and offset markers in the bottom right corner
set ruler

" Show line numbers
set number

" No error bells please
set noerrorbells

" Fix the backspace key
set backspace=2

" set the ctags location
set tags=./tags,./TAGS,tags;~,TAGS;~

" Map <ctrl-l> to turn off highlighting the search terms
noremap <silent> <c-l> :nohls<cr><c-l>

" Enable golang plugin modules
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
filetype plugin indent on
syntax on

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

"Airline settings
let g:airline#extensions#tabline#enabled=1
set laststatus=2
let g:airline_theme='kalisi'

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
"autocmd Filetype c,cpp,cs,java,objc set cst csto=0

"let g:CommandTMaxFiles=1000000
let g:CommandTMaxFiles=200000
let g:CommandTTraverseSCM='file'
let g:CommandTMatchWindowReverse=0
let g:CommandTMaxHeight=50
"let g:CommandTAlwaysShowDotFiles=1
set wildignore+=*.o,*.d,*.git,CMakeFiles

" SuperTab options
let g:SuperTabDefaultCompletionType='<c-n>'

