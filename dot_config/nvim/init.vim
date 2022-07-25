" ---------------------------------------------------------
" General
" ---------------------------------------------------------
set encoding=utf-8
set number
set nowritebackup
set nobackup
set autoread
" set ambiwidth=double
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set cmdheight=2

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

let mapleader = "\<Space>"

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
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'nvim-lua/plenary.nvim' "telescopeに必要
Jetpack 'nvim-telescope/telescope.nvim' "fuzzy finder
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
" Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
"Jetpack 'vlime/vlime', { 'rtp': 'vim' }
" Jetpack 'tpope/vim-fireplace', { 'for': 'clojure' }
" Jetpack 'vim-airline/vim-airline'
"Jetpack 'itchyny/lightline.vim'
Jetpack 'nvim-lualine/lualine.nvim'


"Jetpack 'preservim/nerdtree' "ファイラー
Jetpack 'lambdalisue/fern.vim' "ファイラー
Jetpack 'lambdalisue/fern-git-status.vim' "fernでgit差分を表示
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim' "fernでアイコンを表示
"Jetpack 'jiangmiao/auto-pairs' "カッコの自動入力
"Jetpack 'sheerun/vim-polyglot' "色々な言語のsyntax highlightなどを提供
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "構文解析によるsyntax highlight
Jetpack 'JoosepAlviste/nvim-ts-context-commentstring' "treesitterによるコメントアウト gcc
Jetpack 'haringsrob/nvim_context_vt' "対応する括弧を表示する
Jetpack 'Vimjas/vim-python-pep8-indent' "pep8準拠のインデント
Jetpack 'mhinz/vim-startify' "起動時のスタートメニューを追加
Jetpack 'vim-denops/denops.vim' "fuzzy-motionに必要
Jetpack 'lambdalisue/nerdfont.vim' "Nerd font
Jetpack 'yuki-yano/fuzzy-motion.vim' "fuzzyにjump移動できる Ctrl+s
Jetpack 'hrsh7th/vim-searchx' "標準の検索をoverwrite
Jetpack 'phaazon/hop.nvim' "easymotionのlua版 ss

"colorschemes
Jetpack 'dracula/vim', { 'as': 'dracula' }
Jetpack 'sainnhe/gruvbox-material', { 'as': 'gruvbox-material' }
Jetpack 'cocopon/iceberg.vim', { 'as': 'iceberg' }
Jetpack 'Mofiqul/vscode.nvim', { 'as': 'codedark' }
Jetpack 'EdenEast/nightfox.nvim', { 'as': 'nightfox' }
Jetpack 'folke/tokyonight.nvim', {'as': 'tokyonight'}
Jetpack 'sainnhe/everforest', {'as': 'everforest'}

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
colorscheme tokyonight 

" ---------------------------------------------------------
" Telescope Setting
" ---------------------------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ---------------------------------------------------------
" Coc.nvim setting
" ---------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
let g:fern#renderer = "nerdfont"

nmap <C-f> :Fern . -reveal=% -drawer -toggle<CR>
set statusline=2

" ---------------------------------------------------------
" fuzzy-motion Setting
" ---------------------------------------------------------
nnoremap <leader>ss <cmd>FuzzyMotion<cr>

" ---------------------------------------------------------
" vim-searchx Setting
" ---------------------------------------------------------
" Overwrite / and ?.
nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
cnoremap ; <Cmd>call searchx#select()<CR>

" Move to next/prev match.
nnoremap N <Cmd>call searchx#prev_dir()<CR>
nnoremap n <Cmd>call searchx#next_dir()<CR>
xnoremap N <Cmd>call searchx#prev_dir()<CR>
xnoremap n <Cmd>call searchx#next_dir()<CR>
nnoremap <C-k> <Cmd>call searchx#prev()<CR>
nnoremap <C-j> <Cmd>call searchx#next()<CR>
xnoremap <C-k> <Cmd>call searchx#prev()<CR>
xnoremap <C-j> <Cmd>call searchx#next()<CR>
cnoremap <C-k> <Cmd>call searchx#prev()<CR>
cnoremap <C-j> <Cmd>call searchx#next()<CR>

" Clear highlights
nnoremap <C-l> <Cmd>call searchx#clear()<CR>

let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" The scrolloff value for moving to next/prev.
let g:searchx.scrolloff = &scrolloff

" To enable scrolling animation.
let g:searchx.scrolltime = 500

" To enable auto nohlsearch after cursor is moved
let g:searchx.nohlsearch = {}
let g:searchx.nohlsearch.jump = v:true

" Marker characters.
let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  if a:input !~# '\k'
    return '\V' .. a:input
  endif
  return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
endfunction

" ---------------------------------------------------------
" Hop Setting
" ---------------------------------------------------------
lua << EOF
require('hop').setup()
EOF
nnoremap ss <cmd>HopWord<cr>
nnoremap ll <cmd>HopLine<cr>


" ---------------------------------------------------------
" Airline Setting
" ---------------------------------------------------------
" let g:airline_powerline_fonts = 1

"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"      \ },
"      \ 'component_function': {
"      \   'gitbranch': 'fugitive#head'
"      \ },
"      \ }
"

" ---------------------------------------------------------
" lualine Setting
" ---------------------------------------------------------
lua << END
require('lualine').setup()
END

" ---------------------------------------------------------
" ESC Setting
" ---------------------------------------------------------
inoremap jk <Esc>
inoremap jj <Esc>

" ---------------------------------------------------------
" SPLIT BORDER Setting
" ---------------------------------------------------------
hi VertSplit cterm=none

