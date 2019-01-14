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

" 81文字目に縦の線を表示する
set cc=81

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

" クリップボードを共有
set clipboard=unnamed,autoselect

"全角スペースをハイライト表示する
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

" 最後のカーソル位置を復元
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
endif

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

match ZenkakuSpace /　/

"タブ、空白、改行の可視化
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

" 行番号の色
highlight LineNr ctermfg=darkyellow

" ------------------------------------
" syntastic setting
" ------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

let g:syntastic_error_symbol='❌'
let g:syntastic_style_error_symbol = '❌'
let g:syntastic_warning_symbol = '🚧'
let g:syntastic_style_warning_symbol = '🚧'

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
" inoremap <C-e> <Esc>$a
" inoremap <C-a> <Esc>^i
" noremap <C-e> <Esc>$a
" noremap <C-a> <Esc>^i

inoremap <C-e> $
inoremap <C-a> ^
noremap <C-e> $
noremap <C-a> ^

" ------------------------------------
" status line
" ------------------------------------
set laststatus=2
set t_Co=256
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" ------------------------------------
" color setting
" ------------------------------------
" 構文毎に色分けする
syntax on

" ビープ音をすべて視覚表示する
set visualbell

" ------------------------------------
" python setting
" ------------------------------------
filetype plugin on
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" ------------------------------------
" pluging setting
" ------------------------------------
" vim-gitgutter で変更のある行をハイライト
let g:gitgutter_highlight_lines = 1

" caw.vim.git C-k でまとめてコメントアウト
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

autocmd FileType python setlocal completeopt-=preview

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ------------------------------------
" dein setting
" ------------------------------------
if (!isdirectory(expand('$HOME/.vim/repos/github.com/Shougo/dein.vim')))
  call system(expand('mkdir -p $HOME/.vim/repos/github.com'))
  call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.vim/repos/github.com/Shougo/dein.vim'))
endif

if &compatible
  set nocompatible
endif

" Required:
set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim'))

" Let dein manage dein
" Require:
call dein#add('shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete')
call dein#add('honza/vim-snippets')
call dein#add('ConradIrwin/vim-bracketed-paste')
call dein#add('tpope/vim-fugitive')
call dein#add('tyru/caw.vim.git')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('scrooloose/syntastic')
call dein#add('airblade/vim-gitgutter')
call dein#add('itchyny/lightline.vim')
call dein#add('ajmwagar/vim-deus')

" Required:
call dein#end()

" Required:
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

set background=dark
colorscheme deus
syntax on
