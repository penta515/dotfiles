" ------------------------------------
" dein setting
" ------------------------------------
if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ------------------------------------
" general setting
" ------------------------------------
" フォント設定
set guifont=Ricty-BoldForPowerline

" カーソル行をハイライト
set cursorline

" タブの挿入設定
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rake setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" 保存時に行末の空白を自動で削除
autocmd BufWritePre * :%s/\s\+$//ge

" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" 行番号を表示する
set number

" 検索で大文字小文字を区別しない
set ignorecase

"全角スペースをハイライト表示する
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" 最後のカーソル位置を復元する
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
endif

"タブ、空白、改行の可視化する
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

" 勝手にコメントアウトしない
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" Swapファイル と Backupファイルを無効化する
set nowritebackup
set nobackup
set noswapfile

" 検索マッチテキストをハイライト
set hlsearch

" 不可視文字を可視化する
set list

" 自動的に改行が入るのを無効化
set textwidth=0

" 対応括弧に'<'と'>'のペアを追加する
set matchpairs& matchpairs+=<:>

" ------------------------------------
" syntastic setting
" ------------------------------------
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [
      \ 'ruby', 'javascript','coffee', 'scss', 'html', 'haml', 'slim', 'sh',
      \ 'spec', 'vim', 'zsh', 'sass', 'eruby'] }

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_scss_checkers = ['scss_lint']

let g:syntastic_error_symbol='x'
let g:syntastic_style_error_symbol = 'x'
let g:syntastic_warning_symbol = 'w'
let g:syntastic_style_warning_symbol = 'w'

let g:syntastic_ruby_rubocop_exe = 'bundle exec rubocop'

" ------------------------------------
" file encode setting
" ------------------------------------
" 文字コード
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" ------------------------------------
" key setting
" ------------------------------------
" <Space>i でコードをインデント整形
map <Space>i gg=<S-g><C-o><C-o>zz

" visual モードで連続して、インデント出来るように設定
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" TABキーで対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" C-a, C-e で行頭と行末に移動する
inoremap <C-e> <Esc>$
inoremap <C-a> <Esc>^
noremap <C-e> <Esc>$
noremap <C-a> <Esc>^

" ------------------------------------
" status line
" ------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2
set t_Co=256
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" ------------------------------------
" python setting
" ------------------------------------
filetype plugin on
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" ------------------------------------
" pluging setting
" ------------------------------------
" caw.vim.git C-k でまとめてコメントアウト
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

" ------------------------------------
" color setting
" ------------------------------------
syntax enable
set background=dark
colorscheme gruvbox

" ビープ音をすべて視覚表示する
set visualbell

let  g:gitgutter_max_signs  =  500

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

nnoremap ww <C-w>w
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l
nnoremap wh <C-w>h

