call plug#begin()
" Plug 'akinsho/bufferline.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'marko-cerovac/material.nvim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'pocco81/true-zen.nvim'
call plug#end()

lua require('keymap')
lua require('lsp')
lua require('plugs')

set hidden
" Who wants .swap files??
set noswapfile

" Enable mouse support
set mouse=a

" Turn persistent undo on
" means that you can undo even when you close a buffer/VIM
set undodir=~/.vim_runtime/temp_dirs/undodir
set undofile

set tabstop=4
set shiftwidth=4

noremap <F9> :source $MYVIMRC<CR>
noremap <F8> :echo &filetype<CR>
noremap <F5> :call RunProgram()<CR>

noremap <leader>c :call CommentLine()<CR>

colorscheme material-deep-ocean

function CommentLine()
	if &filetype == "rust"
		:norm I//
	elseif &filetype == "vim"
		:norm I"
	elseif &filetype == "lua"
		:norm I--
	elseif &filetype == "python"
		:norm I#
	else
		echo 'Commenting not implemented, using most common comment, //'
		:norm I//
	endif

endfunction
function RunProgram()
	if &filetype == "rust"
		:! cargo run
	else
		echo 'File not runnable'
	endif

endfunction

" FZF key bindings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" c-x c-f opens file in normal mode and inserts path in insert mode
imap <c-x><c-k> <plug>(fzf-complete-word)
" This one shows hidden files, most of the time that is irritating.
imap <c-x><c-h><c-f> <plug>(fzf-complete-path)
" This one shows only non-hidden, non-ignore files. Also skips folders.
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
noremap <expr> <c-x><c-f> ":Files<CR>"
noremap <expr> <c-x><c-b> ":Buffers<CR>"
imap <c-x><c-l> <plug>(fzf-complete-line)

set number
