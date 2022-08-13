-----------------------------------------------------------
-- Install Vim-Jetpack
-----------------------------------------------------------
local jetpack_url = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
local jetpack_root = vim.fn.expand("~/.cache") .. "/jetpack-vim"
local jetpack_vim = jetpack_root .. "/jetpack.vim"
if vim.fn.filereadable(jetpack_vim) == 0 then
	vim.fn.execute("!curl -fLo " .. jetpack_vim .. " --create-dirs " .. jetpack_url)
end
vim.fn.execute("source " .. jetpack_vim)
