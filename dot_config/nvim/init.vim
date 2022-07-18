set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
syntax enable

" Install vim-jetpack
let s:jetpack_root = expand('~/.cache/jetpack-vim')
let s:jetpack_vim = s:jetpack_root . '/jetpack.vim'
if !filereadable(s:jetpack_vim)
  execute '!curl -fLo' s:jetpack_vim '--create-dirs'
    \ 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
  let s:jetpack_sync = 1
endif
execute 'source ' . s:jetpack_vim

" Plugin setting
packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'https://github.com/dense-analysis/ale'
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Jetpack 'vlime/vlime', { 'rtp': 'vim' }
Jetpack 'dracula/vim', { 'as': 'dracula' }
Jetpack 'tpope/vim-fireplace', { 'for': 'clojure' }
Jetpack 'tpope/vim-commentary' "範囲コメントアウト
Jetpack 'vim-airline/vim-airline'
Jetpack 'preservim/nerdtree'
Jetpack 'ervandew/supertab' "tab補完
Jetpack 'jiangmiao/auto-pairs' "カッコの自動入力
Jetpack 'sheerun/vim-polyglot' "色々な言語のsyntax highlightなどを提供
Jetpack 'Vimjas/vim-python-pep8-indent' "pep8準拠のインデント
call jetpack#end()

colorscheme dracula
set termguicolors

" NERDTree SETTINGS
nmap <C-f> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab


" Airline SETTINGS
let g:airline_powerline_fonts = 1

" Esc SETTINGS
inoremap jk <Esc>
inoremap jj <Esc>

" /// Enable Netrw (default file browser)
" filetype plugin on
" /// Netrw SETTINGS
" let g:netwr_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 30
" let g:netrw_sizestyle = "H"
" let g:netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
" " let g:netrw_preview = 1

"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none

