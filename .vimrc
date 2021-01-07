set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Git plugin
Plugin 'tpope/vim-fugitive'
" use cs ys or ds to do surround commands
Plugin 'tpope/vim-surround'
" Some standard stuff
Plugin 'tpope/vim-sensible'
" Directory Tree
Plugin 'arzg/vim-colors-xcode'
Plugin 'preservim/nerdtree'
" Color scheme
" Plugin 'nanotech/jellybeans.vim'
" Auto completes code
Plugin 'valloric/youcompleteme'
" JS color
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
" Error message
Plugin 'scrooloose/syntastic'
" Auto resizing of window
Plugin 'camspiers/animate.vim'
Plugin 'camspiers/lens.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Color Scheme
:colorscheme xcodedarkhc


" My settings
if has('persistent_undo')
  if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
  endif
  set undodir=/tmp/.vim-undo-dir
  set undofile
endif

function ToggleColors()
    if (g:colors_name == "xcodedarkhc")
        colorscheme xcodelighthc
    else
        colorscheme xcodedarkhc
    endif
endfunction

nnoremap <C-b> :call ToggleColors()<CR>

nmap <C-n> :NERDTreeToggle<CR>
:set tabstop=2
:set shiftwidth=2
:set expandtab
:set smartindent
:set lazyredraw

" Makes end curly brace if enter is quickly pressed
inoremap {<CR>  {<CR>}<Esc>O

