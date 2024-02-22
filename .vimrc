" plugins
" =================================
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" settings
" =================================
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif
colorscheme lunaperche
set number
set relativenumber
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
set foldmethod=indent
" Folds always start fully open. 
autocmd BufReadPost * silent! :%foldopen!
" Open help on right side, with capital H
if has('persistent_undo')
	if !isdirectory("/tmp/.vim-undo-dir")
		call mkdir("/tmp/.vim-undo-dir", "", 0700)
	endif
	set undodir=/tmp/.vim-undo-dir
	set undofile
endif
set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif




" keybindings
" =================================
map <F10> :source $MYVIMRC<CR>
map <C-s> :write <CR>
map <F1> :call DecreaseWindowSize()<CR>
map <F2> :call IncreaseWindowSize()<CR>
cnoreabbrev h h
cnoreabbrev H vert bo h


" autocmd
" =================================
augroup auFileTypes
	autocmd!
	autocmd FileType markdown setlocal wrap linebreak
augroup end
" functions
" =================================
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

" coc nvim
" ============================
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
nnoremap <silent> K :call ShowDocumentation()<CR>


function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction



" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
