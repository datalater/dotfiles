" vi 편집기록 기억갯수 .viminfo에 기록
set history=1000
set encoding=utf-8
" 메뉴 표시 언어: 영어
lang mes en_US
" enable mouse scrolling
set mouse=a
set showcmd

""
" APPEARANCE
""
"colorscheme desert
if has("syntax")
  syntax on
endif
set background=dark

colorscheme jellybeans

" Show line number
set nu
" Show current cursor position
set ruler
" 상태바를 언제나 표시할 것
set laststatus=2


""
" CODE STYLE
""
set autoindent
set smartindent
" shift를 4칸으로 ( >, >>, <, << 등의 명령어)
set shiftwidth=4
" tab을 4칸으로
set tabstop=4

""
" SEARCH
""
" Try to be smart about cases when searching
set smartcase

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" 검색 키워드 입력시 한 글자 입력할 때마다 점진 검색
set incsearch

""
" ERROR SOUND
""
set noerrorbells
set novisualbell

""
" BACKUP
""
set nobackup
set nowb
set noswapfile

" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" 명령행 한글 입력 오류 처리
ca ㅈ w

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Status bar
Plugin 'vim-airline/vim-airline'

" File tree
Plugin 'scrooloose/nerdtree'

" Git diff
Plugin 'airblade/vim-gitgutter'

" Git branch
Plugin 'tpope/vim-fugitive'

" Lint
Plugin 'scrooloose/syntastic'

" Jellybeans color scheme
Plugin 'nanotech/jellybeans.vim'

" Find files
Plugin 'ctrlpvim/ctrlp.vim'

" Easy Align
Plugin 'junegunn/vim-easy-align'

call vundle#end()            " required
filetype plugin indent on    " required

"""
" SHORTCUT
"""

" navigation
nnoremap <Space>h ^
nnoremap <Space>l $
noremap <Space>j 8j
noremap <Space>k 8k

" to normal mode
imap jk <Esc>
imap kj <Esc>

" insert today for jekyll
map! <F5> <C-R>=strftime('%Y-%m-%d %H:%M:%S %z')<CR>

"--- plugin
nnoremap <F12>n :NERDTreeToggle<ENTER>
"map <Leader>nt <ESC>:NERDTree<CR>

"--- vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

""" autocmd
function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}update\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre * call LastModified()

function! Created()
	let save_cursor = getpos(".")
	let n = min([10, line("$")])
	keepjumps exe '1,' . n . 's#^\(.\{,10}date\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
	call histdel('search', -1)
	call setpos('.', save_cursor)
endfun
autocmd BufNewFile *_posts/*.md call Created()

if has("autocmd")
  augroup templates
    autocmd BufNewFile *_posts/*.md 0r ~/.vim/templates/post.md
  autocmd BufNewFile *_posts/*.md call Created()
  augroup END
endif

