if has('vim_starting')
  " Vim起動時に以下実行

  if &compatible
    " vi互換動作を無効化
    set nocompatible
  endif

  " vim-plugがまだインストールされていなければインストールする
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
end

""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" Denops
Plug 'vim-denops/denops.vim'
" Ruby等でendを自動入力
Plug 'tpope/vim-endwise'
" インデントに色を付けて見やすくする
Plug 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
" fzf連携
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Language Servers
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Auto-complete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" for JSX
Plug 'maxmellon/vim-jsx-pretty'
" for TypeScript
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
" for Go
Plug 'fatih/vim-go'
" for Scala
Plug 'derekwyatt/vim-scala'
" for Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

syntax enable
colorscheme molokai
set t_Co=256
"set fileformats=unix, dos
set fileformats=unix

""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""
" nothing

""""""""""""""""""""""""""""""""""""""""
" インデント
""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set cindent
set smarttab
" タブで半角スペース2つ挿入
set expandtab
" タブを半角スペース2つで表示
set tabstop=2
set softtabstop=0
" 矩形選択中に行末にテキストがなくくてもカーソルを行末に移動可能にする
set virtualedit=block
" 閉じ括弧が入力された時、対応する括弧を表示する
set showmatch
set shiftwidth=2
if has("autocmd")
  " ファイルタイプ検索有効化
  filetype plugin on
  " ファイルタイプに合わせたインデントを利用する
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=2 sts=2 ts=2 et
  autocmd FileType asm         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sass        setlocal sw=2 sts=2 ts=2 et
endif

set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan

" 不可視文字を表示する
set list
set number
set listchars=tab:>-,trail:~

set ambiwidth=double
if has('path_extra')
"    set tags& tags + =.tags, tags
endif
set laststatus=2
set showtabline=2

set clipboard=unnamed

set backspace=eol,indent,start

set wildmenu
set wildmode=list:full
set wildignore=*.o,*.obj,*.pyc,*.so,*.dll

""""""""""""""""""""""""""""""""""""""""
" ショートカットキー
""""""""""""""""""""""""""""""""""""""""
" for US keyboard
nnoremap ; :
nnoremap : ;
vnoremap : :
vnoremap : ;
" for vim-lsp
nnoremap <silent> ]e  :LspNextError<CR>
nnoremap <silent> [e  :LspPreviousError<CR>
nnoremap <silent> ]w  :LspNextWarning<CR>
nnoremap <silent> [w  :LspPreviousWarning<CR>
nnoremap <silent> <C-]> :LspDefinition<CR> " Ctrl-Oで元のカーソル位置に戻ることができる（Ctrl-Iで再度定義に移動することができる）

""""""""""""""""""""""""""""""""""""""""
" asyncomplete.vim
""""""""""""""""""""""""""""""""""""""""
let g:asyncomplete_auto_popup = 1
"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"
let g:lsp_settings = { 'typescript-language-server': { 'cmd': [&shell, &shellcmdflag, 'typescript-language-server --stdio']}}

""""""""""""""""""""""""""""""""""""""""
" プラグインの検証用のディレクトリを設定
""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/vim-plugin-development
