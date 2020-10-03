if has('vim_starting')
  " Vim起動時に以下実行

  if &compatible
    " vi互換動作を無効化
    set nocompatible
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
end

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

""""""""""""""""""""""""""""""""""""""""
" NeoBundle
""""""""""""""""""""""""""""""""""""""""
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
" Ruby等でendを自動入力
NeoBundle 'tpope/vim-endwise'
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
" fzf連携
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
" for TypeScript
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }

NeoBundle 'Quramy/tsuquyomi'
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

call neobundle#end()

NeoBundleCheck

syntax enable
colorscheme molokai
set t_Co=256
"set fileformats=unix, dos
set fileformats=unix

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
  autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
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
let g:python_highlight_all = 1

if version < 600
    syntax clear
elseif exists('b:current_after_syntax')
    finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save

" ref: http://hachibeechan.hateblo.jp/entry/vim-customize-for-python

nnoremap ; :
nnoremap : ;
vnoremap : :
vnoremap : ;
