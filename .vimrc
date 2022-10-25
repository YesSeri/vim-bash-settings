set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Directory Tree
Plugin 'preservim/nerdtree'
" Color scheme
Plugin 'arzg/vim-colors-xcode'
" Plugin 'nanotech/jellybeans.vim'

call vundle#end()            " required
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
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set smartindent
:set lazyredraw

" Makes end curly brace if enter is quickly pressed
inoremap {<CR>  {<CR>}<Esc>O
