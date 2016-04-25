" ------------------------------------------------------------------------------
"  Various Startup Commands
" ------------------------------------------------------------------------------

if has('vim_starting')
    set nocompatible
    set runtimepath+=/Users/chenyiyu/.vim/bundle/neobundle.vim/,/usr/share/vim/vim73
endif

call neobundle#begin('~/.vim/bundle')

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:

" NeoBundle 'gregsexton/gitv'
" NeoBundle 'scrooloose/syntastic'
" NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jeetsukumaran/vim-buffergator'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Valloric/YouCompleteMe'
" NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-airline/vim-airline'
" NeoBundle 'bling/vim-bufferline'
call neobundle#end()
" ------------------------------------------------------------------------------
" Plugin Options
" ------------------------------------------------------------------------------
" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 1
" " prevents conflict in tab-key usage with Ultisnips - use C-N/C-P to
" " cycle YCM completions
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Tagbar
let g:tagbar_ctags_bin='/User/chenyiyu/libs/exctags/install/bin/ctags'
let g:tagbar_show_linenumbers=0
let g:tagbar_autopreview=0
let g:tagbar_previewwin_pos='belowleft'

" CtrlP
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = {
     \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$\|build$',
     \ 'file': '\.so$\|\.dat$\|\.DS_Store$\|\.pdf$\|\.doc$'
     \ }
let g:ctrlp_extensions = ['line', 'dir']
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

" Buffergator
let g:buffergator_hsplit_size=8
let g:buffergator_vsplit_size=16
let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy = "B"

" Ultinsips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir='~/.vim/bundle/ultisnips'

" Syntaastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_check_on_open=1

" Gitv
" let g:Gitv_OpenHorizontal=1

autocmd VimEnter * NERDTree
set mouse=n

" ------------------------------------------------------------------------------
" Settings
" ------------------------------------------------------------------------------
set timeoutlen=400
set updatetime=1024
set statusline= "%{fugitive#statusline()}"
set smartcase   " ignore case if all lower, case sensitive if mixed
set showmatch   " matches parens
set noswapfile
set nobackup
set laststatus=2

" " Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set smartindent
set backspace=2
"
" " UI
set lazyredraw
syntax on
set t_Co=256
set background=dark
" colorscheme solarized
set showmatch
set hlsearch
set incsearch
" set scrolloff=8
set number
" set ruler
" set mouse=incr
" set t_Co=256
" colorscheme Tomorrow-Night
" set bg=dark
" let &titleold=getcwd()
" colorscheme Tomorrow-Night
set splitbelow
set splitright
"
set cursorline
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70
let &titleold=getcwd()
let mapleader=','

" Required
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" KeyBindings
nmap <F8> :TagbarToggle<CR>

nmap <F9> :YcmCompleter GoTo<CR>

map <C-t> :NERDTreeToggle<CR>

" Functions

" ClangCheck
function! ClangCheckImpl(cmd)
  if &autowrite | wall | endif
    echo "Running " . a:cmd . " ..."
    let l:output = system(a:cmd)
    cexpr l:output
    cwindow
    let w:quickfix_title = a:cmd
    if v:shell_error != 0
      cc
    endif
    let g:clang_check_last_cmd = a:cmd
endfunction

function! ClangCheck()
  let l:filename = expand('%')
  if l:filename =~ '\.\(cpp\|cxx\|cc\|c\)$'
    call ClangCheckImpl("clang-check " . l:filename)
  elseif exists("g:clang_check_last_cmd")
    call ClangCheckImpl(g:clang_check_last_cmd)
  else
    echo "Can't detect file's compilation arguments and no previous clang-check invocation!"
  endif
endfunction

nmap <silent> <F5> :call ClangCheck()<CR><CR>

