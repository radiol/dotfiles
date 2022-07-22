" ---------------------------------------------------------
" General
" ---------------------------------------------------------
set number
set nowritebackup
set nobackup
set autoread
" set ambiwidth=double
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

" ---------------------------------------------------------
" Install vim-jetpack
" ---------------------------------------------------------
let s:jetpack_root = expand('~/.cache/jetpack-vim')
let s:jetpack_vim = s:jetpack_root . '/jetpack.vim'

if !filereadable(s:jetpack_vim)
  execute '!curl -fLo' s:jetpack_vim '--create-dirs'
    \ 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
  let s:jetpack_sync = 1
endif
execute 'source ' . s:jetpack_vim

" ---------------------------------------------------------
" Plugin
" ---------------------------------------------------------
call jetpack#begin(s:jetpack_root)
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'https://github.com/dense-analysis/ale'
"Jetpack 'junegunn/fzf.vim'
"Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'nvim-lua/plenary.nvim' "telescopeに必要
Jetpack 'nvim-telescope/telescope.nvim' "fuzzy finder
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
"Jetpack 'vlime/vlime', { 'rtp': 'vim' }
" Jetpack 'tpope/vim-fireplace', { 'for': 'clojure' }
Jetpack 'tpope/vim-commentary' "範囲コメントアウト
" Jetpack 'vim-airline/vim-airline'
" Jetpack 'itchyny/lightline.vim'
Jetpack 'nvim-lualine/lualine.nvim'
"Jetpack 'preservim/nerdtree' "ファイラー
Jetpack 'lambdalisue/fern.vim' "ファイラー
Jetpack 'ervandew/supertab' "tab補完
Jetpack 'jiangmiao/auto-pairs' "カッコの自動入力
"Jetpack 'sheerun/vim-polyglot' "色々な言語のsyntax highlightなどを提供
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "構文解析によるsyntax highlight
Jetpack 'Vimjas/vim-python-pep8-indent' "pep8準拠のインデント
Jetpack 'mhinz/vim-startify' "起動時のスタートメニューを追加

" colorschemes
Jetpack 'dracula/vim', { 'as': 'dracula' }
Jetpack 'sainnhe/gruvbox-material', { 'as': 'gruvbox-material' }
Jetpack 'cocopon/iceberg.vim', { 'as': 'iceberg' }
Jetpack 'Mofiqul/vscode.nvim', { 'as': 'codedark' }
Jetpack 'EdenEast/nightfox.nvim', { 'as': 'nightfox' }
call jetpack#end()

" ---------------------------------------------------------
" run JetpackSync
" ---------------------------------------------------------
if get(s:, 'jetpack_sync', 0)
  call jetpack#sync()
endif

" ---------------------------------------------------------
" Colorscheme
" ---------------------------------------------------------
"colorscheme dracula
"colorscheme iceberg
"colorscheme gruvbox-material
colorscheme nightfox

" ---------------------------------------------------------
" Telescope Setting
" ---------------------------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" ---------------------------------------------------------
" Treesitter Setting
" ---------------------------------------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" ---------------------------------------------------------
" NERDTree Setting
" ---------------------------------------------------------
"nmap <C-f> :NERDTreeToggle<CR>
"let g:airline#extensions#tabline#enabled = 1
"nmap <C-p> <Plug>AirlineSelectPrevTab
"nmap <C-n> <Plug>AirlineSelectNextTab

" ---------------------------------------------------------
" Fern Setting
" ---------------------------------------------------------
" open a current working directory.(focused, split view)
nmap <C-f> :Fern . -reveal=% -drawer<CR>
set statusline=2

" ---------------------------------------------------------
" Airline Setting
" ---------------------------------------------------------
" let g:airline_powerline_fonts = 1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }


" ---------------------------------------------------------
" lualine Setting
" ---------------------------------------------------------
" lua << END
" require('lualine').setup()
" END

" ---------------------------------------------------------
" ESC Setting
" ---------------------------------------------------------
inoremap jk <Esc>
inoremap jj <Esc>

" ---------------------------------------------------------
" Enable Netrw (default file browser)
" ---------------------------------------------------------
"filetype plugin on
"" Netrw Setting
"let g:netwr_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_winsize = 30
"let g:netrw_sizestyle = "H"
"let g:netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
"let g:netrw_preview = 1

" ---------------------------------------------------------
" SPLIT BORDER Setting
" ---------------------------------------------------------
hi VertSplit cterm=none

