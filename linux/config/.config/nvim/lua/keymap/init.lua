vim.g.mapleader=','
vim.keymap.set('n', '<leader>t', 'a<C-R>=strftime("%c")<CR><Esc>' )
vim.keymap.set('n', '<leader>n', ':bnext<CR>')
vim.keymap.set('n', '<leader>p', ':bprevious<CR>')
vim.keymap.set('n', '<leader>d', ':bdelete<CR>')
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')

function formatCode()
	-- We save to make sure latest file data is formatted
	vim.cmd([[:w<CR>]])
	current_filetype = vim.bo.filetype
	local current_file = vim.fn.expand('%')
	if current_filetype == 'rust' then
		vim.cmd([[silent exe "!cargo fmt"]])
	elseif current_filetype == 'html' then
		vim.cmd([[silent exe "!tidy --show-body-only yes -modify -indent -quiet %"]])
	elseif current_filetype == 'python' then
		vim.cmd([[silent exe "!black %"]])
	else
		print("Current filetype: other")
	end
end



function runTests()
	current_filetype = vim.bo.filetype
	local current_file = vim.fn.expand('%')
	if current_filetype == 'rust' then
		vim.cmd([[!cargo test]])
	end
end
function saveAndFormatCode()
	-- File gets reloaded after formatting so we save first to make sure that the current data is formatted
	vim.cmd([[:w<CR>]])
	formatCode()
	vim.cmd([[:w<CR>]])
end

vim.keymap.set('n', '<C-s>', [[:lua formatCode()<CR>]])

vim.keymap.set('n', '<leader>f', [[:lua formatCode()<CR>]])
vim.keymap.set('n', '<leader>t', [[:lua runTests()<CR>]])

