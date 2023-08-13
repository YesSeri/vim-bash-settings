call plug#begin()
Plug 'akinsho/bufferline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
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
