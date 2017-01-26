if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
end

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-endwise'

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

call neobundle#end()

NeoBundleCheck

filetype plugin indent on

syntax enable
colorscheme molokai
set t_Co=256
"set fileformats=unix, dos
set fileformats=unix

set smarttab
set expandtab
set virtualedit=block
" 閉じ括弧が入力された時、対応する括弧を表示する
set showmatch
set shiftwidth=4

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
