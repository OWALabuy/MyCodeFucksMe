" Enable syntax highlighting
syntax on

" Enable line numbers
set number

" Enable auto indentation
set autoindent
set smartindent

" Enable mouse support
set mouse=a

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Show matching parentheses
set showmatch

" Set color scheme
colorscheme desert

vmap <leader>y :w !xclip -selection clipboard<CR><CR>

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'daveyarwood/vim-alda',
Plug 'chazmcgarvey/vim-mermaid'
Plug 'preservim/tagbar' " 代码映射插件
Plug 'preservim/nerdtree' " 目录树插件
Plug 'euclio/vim-markdown-composer', { 'do': 'cargo build --release' }
Plug 'vim-airline/vim-airline' " 美化插件(装逼用)
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color' " 用来显示css的颜色的 搞前端设计时使用
Plug 'prettier/vim-prettier' "输入:Prettier 格式化html css js代码
call plug#end()

" 使用coc.nvim进行代码补全
autocmd BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx setlocal filetype=javascript
autocmd BufNewFile,BufRead *.py setlocal filetype=python
autocmd BufNewFile,BufRead *.java setlocal filetype=java

" 使用 <Tab> 和 <S-Tab> 进行补全选择
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" 使用 <CR> 进行补全确认
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" 使用 <C-space> 手动触发补全
inoremap <silent><expr> <C-Space> coc#refresh()

" 使用f2进入粘贴模式 这是为了避免老版本中粘贴内容与语言支持插件的冲突
" 但是目前的版本似乎修复了
nnoremap <F2> :set paste!<CR>

" 设置NERDTree(目录树)的开关为ctrl+n
map <C-n> :NERDTreeToggle<CR>

" 设置主题
colorscheme gruvbox
set background=dark

" 配置vim-airline
set laststatus=2  " 显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和bufferlet 
let g:airline_theme='angr'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
