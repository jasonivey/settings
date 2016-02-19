set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'Rip-Rip/clang_complete.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'wincent/command-t.git'
Plugin 'rhysd/vim-clang-format.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'rbgrouleff/bclose.vim.git'
Plugin 'rking/ag.vim'
Plugin 'a.vim'

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

" The location of the libclang depending on linux (specify fullpath) or mac (specify directory)
if has("macunix")
  if !empty(glob('/usr/lib/libclang.dylib'))
    " This works on OS X Lion - 10.7
    let g:clang_library_path='/usr/lib/'
  elseif !empty(glob('/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'))
    " This works on OS X Yosemite - 10.10
    let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/'
  else
    " This works on OS X El Capitan - 10.11
    let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
  endif
else
  if !empty(glob('/usr/lib/x86_64-linux-gnu/libclang.so.1'))
    " Post clang-3.5 libclang.so is now libclang.so.1
    let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang.so.1'
  else
    " The standard linux x64 location
    let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang.so'
  endif
endif

" Adjust clang auto-complete options
let g:clang_user_options='|| exit 0'
let g:clang_complete_copen=1
let g:clang_complete_patterns=0
let g:clang_complete_macros=1
let g:clang_use_library=1
let g:clang_sort_algo='alpha'
let g:clang_debug=0

" Adjust NERDTree to always show hidden files
let g:NERDChristmasTree       = 1
let g:NERDTreeQuitOnOpen      = 1
let g:NERDTreeShowHidden      = 1
let g:NERDTreeMapToggleHidden = 'h'
let g:NERDTreeMapQuit         = 'q'
let g:NERDTreeMapToggleZoom   = 'z'
nnoremap <Leader>n  :NERDTreeToggle<CR>

" Close the auto-complete tip window after selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Adjust the NERDCommenter settings
let g:NERDRemoveExtraSpaces=0  " if value=1 '// int a = 0;' will uncomment to 'int a = 0;'
let g:NERDDefaultNesting=0     " disable the ability to comment block and then comment again nesting them
map <Leader>c <plug>NERDCommenterAlignLeft
map <Leader>u <plug>NERDCommenterUncomment

filetype plugin on

" Set up the auto tab and indent settings for the following types
autocmd FileType make set noexpandtab
autocmd Filetype c,cpp,cs,java,objc set cindent tabstop=4 softtabstop=4 shiftwidth=4 expandtab
"autocmd Filetype c,cpp,cs,java,objc set cst csto=0

"let g:CommandTMaxFiles=1000000
let g:CommandTMaxFiles=200000
let g:CommandTTraverseSCM='pwd'
set wildignore+=*.o,*.d,*.git

" SuperTab options
let g:SuperTabDefaultCompletionType='<c-n>'
