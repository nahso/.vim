" ====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
set autoread

nnoremap q: <Nop>

set clipboard=unnamed
set hidden
" ctags -R --langmap=c++:+.cu -f cuda.tags <path to cuda/include>
" ctags -R -f c++.tags /usr/include/c++
set tags=./.tags;,.tags
for tagfile in split(globpath('~/.cache/tags/lib/', '*'), '\n')
    let &tags .=',' . tagfile
endfor

" Prevent delay when O after <esc>
set timeout timeoutlen=1000 ttimeoutlen=100

" Prevent incorrect backgroung rendering
let &t_ut=''

set background=dark
" true color enable
if has("termguicolors")
    " enable true color
    set termguicolors
endif
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


" ===
" === Main code display
" ===
set number
set relativenumber
set ruler
set cursorline
syntax enable
syntax on

" ===
" === Editor behavior
" ===
" Better tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5

" Prevent auto line split
set nowrap
set tw=0

set indentexpr=
" Better backspace
set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99

if &term =~ "screen."
    let &t_ti.="\eP\e[2 q\e\\"
    let &t_SI.="\eP\e[6 q\e\\"
    let &t_EI.="\eP\e[2 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
else
    let &t_ti.="\<Esc>[2 q"
    let &t_SI.="\<Esc>[6 q"
    let &t_EI.="\<Esc>[2 q"
    let &t_te.="\<Esc>[0 q"
endif

" ===
" === Window behaviors
" ===
set splitright
set splitbelow

" ===
" === Status/command bar
" ===
set laststatus=2
"set autochdir
set showcmd
set formatoptions-=tc

" Show command autocomplete
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu " show a navigable menu for tab completion
set wildmode=longest,list,full

" Searching options
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

" ===
" === Restore Cursor Position
" ===
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===
" === Basic Mappings
" ===

" Set <LEADER> as <SPACE>
let mapleader=" "

" 搜索当前选中的内容
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

nmap <leader>fs :w<cr>
nmap <leader>ff :e 
nmap <leader><cr> :noh<cr>

inoremap jk <esc>
inoremap <c-f> <right>
inoremap <c-b> <left>
inoremap <c-g> <esc>

nmap j gj
nmap k gk

nmap <leader>w <c-w>
nmap <leader>wd <c-w>c
nmap <leader>h :bp<CR>
nmap <leader>l :bn<CR>

nmap <leader>rc :e ~/.vim/vimrc<CR>
nmap <leader>rr :source ~/.vim/vimrc<CR>

map <leader>y "+y
map <leader>p "+p

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" theme
Plug 'connorholyday/vim-snazzy'
Plug 'sickill/vim-monokai'
Plug 'liuchengxu/space-vim-dark'

" Git
Plug 'rhysd/conflict-marker.vim'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

"Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent' "i
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] } "f
Plug 'sgur/vim-textobj-parameter'
Plug 'kana/vim-textobj-entire'

Plug 'easymotion/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'

Plug 'derekwyatt/vim-fswitch'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 剪切板图片粘贴到本地
"Plug 'img-paste-devs/img-paste.vim'

"Plug 'preservim/vim-markdown'
" 在当前光标后生成目录
" :GenTocMarked
" 更新目录
" :UpdateToc
"Plug 'mzlogin/vim-markdown-toc'

"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'vim-scripts/LargeFile'

Plug 'rickhowe/spotdiff.vim'

call plug#end()

" =========
" = Plug config
" =========
colorscheme space-vim-dark
"colorscheme monokai
"colorscheme snazzy

" =========
" = airline
" =========
let g:airline#extensions#whitespace#enabled = 0
let g:airline_symbols_ascii = 1

" ========
" = tabularize
" ========
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" ========
" = commenter
" ========
"nmap gcc <leader>cc

" ========
" = esaymotion
" ========
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
vmap <Leader>j <Plug>(easymotion-j)
vmap <Leader>k <Plug>(easymotion-k)
hi EasyMotionTarget ctermbg=none ctermfg=blue

" ========
" = fzf
" ========
nmap <leader>df :Files<CR>
nmap <leader>dg :GFiles<CR>
nmap <leader>bb :Buffers<CR>
nmap <leader>de :Lines<CR>
nmap <leader>dl :BLines<CR>
nmap <leader>t :Tags<CR>
nmap <leader>e :BTags<CR>
nmap <leader>s :GGrep<CR>
nmap <leader>fr :History<CR>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'grep -r -i -n --exclude-dir={.svn,.git,TAGS} --binary-files=without-match -- '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* BTags
            \ call fzf#vim#buffer_tags('',
            \ printf('ctags -f - --sort=no --excmd=number --c++-kinds=+p --fields=+iaS  %s 2> null',
            \ fzf#shellescape(expand('%'))), fzf#vim#with_preview({ "placeholder": "{2}:{3..}" }), <bang>0)

function! MyTags()
    let identifier = expand('<cword>')
    let relevant_fields = taglist(identifier)

    if len(relevant_fields) == 0
        echohl WarningMsg
        echo 'Tag not found: ' . identifier
        echohl None
    elseif len(relevant_fields) == 1
        execute 'tag' identifier
    else
        call fzf#vim#tags(identifier, fzf#vim#with_preview({ "placeholder": "--tag {2}:{-1}:{3..}" }))
    endif
endfunction

" 查找当前光标下的tag
nmap <silent> <C-]> :call MyTags()<CR>

" grep 查找选中的内容
vnoremap <silent> <leader>s "vy:call
            \ fzf#vim#grep(
            \   'grep -r -i -n --exclude-dir={.svn,.git,TAGS} --binary-files=without-match -- ' . getreg('v'), 1,
            \   fzf#vim#with_preview())<CR>

" ========
" = gutentags
" ========
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
" ctags --fields=+nkisazS --extra=+q --sort=no --tag-relative=yes --c++-kinds=+px --c-kinds=+px -R $(pwd)
let g:gutentags_ctags_extra_args = ['--fields=+nkisazS', '--extra=+q', '--sort=no', '--tag-relative=yes']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--langmap=c++:+.cu']
let g:gutentags_ctags_extra_args += ['--langmap=c++:+.cuh']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" ========
" = fswitch
" ========
nmap <silent> <leader>fo :FSHere<CR>

" ========
" = markdown
" ========
"autocmd FileType markdown nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
"let g:vim_markdown_math = 1
"let g:mkdp_path_to_chrome = 'chromium'

vmap <A-w> <Plug>OSCYankVisual

map <leader>dd :Diffthis<CR>
map <leader>do :Diffoff<CR>
