" TPOPE SENSIBLE


" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if &laststatus < 2
  set laststatus=2
endif
set ruler
set wildmenu
set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif


set nocompatible
filetype off

" My settings
if has('persistent_undo')
  if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
  endif
  set undodir=/tmp/.vim-undo-dir
  set undofile
endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
	echo "Installing vim-plug"
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
	Plug 'NLKNguyen/papercolor-theme'
call plug#end()

set background=dark
colorscheme PaperColor

function ToggleColors()
    if (g:colors_name == "PaperColor" && &background== "dark")
		set background=light
    elseif (g:colors_name == "PaperColor")
		set background=dark
    endif
endfunction
" Makes end curly brace if enter is quickly pressed
inoremap { {
}<C-o>dd<C-o>k<C-o>]p<C-o>O

map <F1> :call DecreaseWindowSize()<CR>
map <F2> :call IncreaseWindowSize()<CR>
map <F5> :call RunFile()<CR>
map <F4> :call ToggleColors()<CR>
map <C-s> :write <CR>
map <F10> :source $MYVIMRC<CR>
nmap <C-n> :NERDTreeToggle<CR>

" SETTINGS
" Insert braces automatically
highlight CursorLine cterm=NONE
" Stops buffers from needing to be saved everytime you switch.
set hidden
set visualbell
set cursorline
set t_vb=
set number
set noexpandtab
set tabstop=4
set shiftwidth=4
" # Folds
" Folding by syntax
set foldmethod=syntax
" Folds always start fully open. 
autocmd BufReadPost * silent! :%foldopen!
" Open help on right side, with capital H
cnoreabbrev h h
cnoreabbrev H vert bo h


function IncreaseWindowSize()
	"This means there is a vertical split
	if winwidth(0) != &columns
		vertical resize +5
	else
		resize +5
	endif
endfunction

function DecreaseWindowSize()
	"This means there is a vertical split
	if winwidth(0) != &columns
		vertical resize -5
	else
		resize -5
	endif
endfunction
function! RunFile()
	" Need to have grip installed. pip install grip.
	" Opens a markdown file in firefox.
	if (&ft=='md')
		let l:md_filepath = expand('%:p')
		":h		head (last path component removed)
		"let l:html_filepath = substitute(l:md_filepath, "*\zs.md", ".html", "")
		let l:html_filepath = expand('%:p:h') . '\output.html'
		execute '!grip ' . l:md_filepath . ' --export ' . l:html_filepath
		execute '!Start-Sleep 0.5 | start firefox ' . l:html_filepath
		execute '!rm ' . l:html_filepath
	" Exceute cargo run in directory where vim was opened.
	elseif (&ft=='rust')
		execute '!clear | cargo run'
	" Run current file in awk.
	elseif (&ft=='awk')
		"echo '!awk -f ' . @%
		write
		execute '!awk -f ' . @%
	else
		echo 'Not a valid file to run'
	endif

endfunction