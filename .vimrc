"-------------------------------------------------------------------------------
"設定のためにファイルタイプ判定をOFF
"-------------------------------------------------------------------------------
filetype off
filetype plugin indent off
"-------------------------------------------------------------------------------
"VIM標準設定
"-------------------------------------------------------------------------------
set cryptmethod=blowfish "暗号化
set undodir=$HOME/.vim/undo "アンドゥファイルフォルダ
set undofile "全てのファイルが閉じてもundo管理対象
set directory=$VIM/vimfiles/swp "スワップファイルフォルダ
set noswapfile "スワップファイルを生成しない
set nobackup "バックアップファイルを生成しない
"set clipboard+=unnamed "クリップボードとレジスタを連携
set clipboard=unnamed,unnamedplus
set number "ライン番号を表示
set showtabline=2 " タブを常に表示
set antialias " アンチエイリアス
set tabstop=4 " タブサイズ
set shiftwidth=4 " インデント幅
set visualbell t_vb= " ビープ音なし
set autoindent " 自動インデント
set expandtab " タブスペース化
set novisualbell " 画面点滅を消す
set cursorline " カーソル位置を横線で表示
"set cursorcolumn " カーソル位置を縦線で表示
set ambiwidth=double " 全角記号を扱う
set nowrap " 画面幅で折り返さない
set ignorecase " 検索時に大文字小文字を区別しない
set ignorecase " 大文字小文字無視検索
set showmatch " 対応する括弧を強調表示
set guioptions-=m " メニューバー非表示
set guioptions-=T " ツールバーを非表示
set updatetime=1000 " VIMの自動更新時間
set virtualedit=all " フリーカーソル
" 文字コードの優先順位
set fileencodings=ucs-bom,utf-8,utf-16le,utf-16,iso-2022-jp,cp932,sjis,euc-jp
" 80文字で縦線表示
set textwidth=80
    if exists('&colorcolumn')
    set colorcolumn=+2
endif

" コマンドが存在すれば
if isdirectory($HOME."/.vim/user_plugins/kwbd")
    cabbrev q Kwbd
    cabbrev Kwbd! q!
endif

" Insertモードのときカーソルの形状を変更
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
inoremap <Esc> <Esc>

" カラー設定
colorscheme railscasts

" カレントフォルダを変更
lcd $HOME/デスクトップ


" タブの表示
set list
set listchars=tab:>-,trail:-,extends:<,precedes:<

" 新しい行のインデントを現在行と同じにする
set autoindent

" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
set showmatch "対応する括弧を表示
"自動改行を回避※英数字
set textwidth=0
"自動改行を回避※日本語
set formatoptions=q

"IDE風にファイラーを開く
command IdeVimFiler VimFiler -split -simple -winwidth=25 -no-quit

"右タブに移動
noremap <C-Tab> <ESC>:tabn<CR>
"左タブに移動
noremap <C-S-Tab> <ESC>:tabp<CR>

"Ctrl+zでアンドゥ
inoremap <C-z> <ESC>:u<CR>a
nnoremap <C-z> <ESC>:u<CR>

"Ctrl+sで保存とアンドゥを確定
if has('gui')
    inoremap <C-s> <C-G>u<ESC>:w<CR>a
    nnoremap <C-s> <ESC>:w<CR>
endif

"アウトライン
nnoremap <S-o> :Unite outline<CR>

"すべて選択
nnoremap <C-a> <ESC>ggVG

"検索ハイライト消去
nnoremap <ESC><ESC> :noh<CR>

"tagsがカレントに無い場合、親ディレクトリを見に行く
set tags=tags;
nnoremap <C-]> g<C-]>

"tagファイルを基にしたハイライト
map <F11>  :sp tags<CR>:%s/^\([^     :]*:\)\=\([^    ]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <F12>  :so tags.vim<CR>

"文字のイタリック表示を無効化
hi markdownItalic gui=none

"インデントの自動制御を変更
set foldmethod=manual
set foldlevel=12
autocmd FileType java :set foldmethod=indent
autocmd FileType sql :set foldmethod=indent
autocmd FileType html :set foldmethod=indent
autocmd FileType jsp :set foldmethod=indent

"-------------------------------------------------------------------------------
"ステーターバーに文字コードと改行コードを表示
"-------------------------------------------------------------------------------
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"-------------------------------------------------------------------------------
"水平スクロールバー
"-------------------------------------------------------------------------------
if has('gui')
    set guioptions+=b
endif
"-------------------------------------------------------------------------------
" カレントディレクトリの設定
"-------------------------------------------------------------------------------
" ファイルのディレクトリを自動的にカレントディレクトリに変更します
au BufEnter * execute ":lcd " . expand("%:p:h")

"-------------------------------------------------------------------------------
" ユーザープラグインの設定
"-----------------------------------------------------------------------------
"UNIX用
"let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
"let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
"ここまではUNIX用
for s:path in split(glob('~/.vim/user_plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"-------------------------------------------------------------------------------
"NeoBundle
"-------------------------------------------------------------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')

" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "https://github.com/Shougo/vimproc.vim ※kaoriya版VIMの場合は不要
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
    "https://github.com/Shougo/neocomplete.vim ※補完
    call dein#add('Shougo/neocomplete.vim')
    "https://github.com/Shougo/unite.vim ※Uniteプラットフォーム
    call dein#add('Shougo/unite.vim')
    "https://github.com/Shougo/unite-outline ※アウトライン
    call dein#add('Shougo/unite-outline')
    "https://github.com/Shougo/vimfiler.vim ※ファイラーExploreより強力
    call dein#add('Shougo/vimfiler.vim')
    "https://github.com/Shougo/neomru.vim ※Uniteファイル履歴
    call dein#add('Shougo/neomru.vim')
    "https://github.com/glidenote/memolist.vim ※メモ
    call dein#add('glidenote/memolist.vim')
    "https://github.com/wesleyche/SrcExpl ※tags先を表示
    call dein#add('wesleyche/SrcExpl')
    "https://github.com/vim-scripts/Trinity ※IDE化
    "call dein#add('vim-scripts/Trinity')
    "https://github.com/sgur/unite-everything ※ファイル検索
    "call dein#add('sgur/unite-everything')
    "https://github.com/thinca/vim-singleton ※VIMのシングル起動
    call dein#add('thinca/vim-singleton')
    "https://github.com/t9md/vim-textmanip ※範囲選択の移動
    call dein#add('t9md/vim-textmanip')
    "https://github.com/ctrlpvim/ctrlp.vim ※Ctrl+Pで親フォルダ（SVNやGit）フォルダ"の検索
    call dein#add('ctrlpvim/ctrlp.vim')
    "https://github.com/tomtom/tcomment_vim ※gcで選択範囲のコメント切り替え
    call dein#add('tomtom/tcomment_vim')
    "https://github.com/tpope/vim-surround ※cs"'でシングルクオートとダブルクオートを切り替える
    call dein#add('tpope/vim-surround')
    "https://github.com/nathanaelkane/vim-indent-guides ※インデントの可視化
    call dein#add('nathanaelkane/vim-indent-guides')
    "https://github.com/junegunn/vim-easy-align ※テキスト整形
    "※使い方 CSVの場合対象を選択しEasyAlign *,でエンター
    "EasyAlign 整列列数+区切り文字
    "整列列数にはワイルドカードが使える
    call dein#add('junegunn/vim-easy-align')
    "https://github.com/sjl/gundo.vim ※UNDOの履歴管理
    call dein#add('sjl/gundo.vim')
    "https://github.com/vim-scripts/TagHighlight ※ctagのハイライト
    "ハイライトするには:UpdateTypesFileを実行
    call dein#add('vim-scripts/TagHighlight')
    "https://github.com/vim-scripts/dbext.vim ※DBクライアント
    "call dein#add('vim-scripts/dbext.vim')
    "https://github.com/vimplugin/project.vim ※プロジェクト管理 個人のGitHubミラー
    ":Projectでプロジェクト管理を開く
    "\c 対話的に新しいディレクトリをプロジェクトに追加する。
    "\C \cと同じだが、指定したディレクトリ以下のすべてのディレクトリを再帰的にプロジェクトに追加する。
    "\r 現在カーソルがあるディレクトリの中身を再度読み込みなおす。プロジェクトの設定を変更したときやファイルを追加したときなどに実行する。
    "\R \rと同じだが、指定したディレクトリ以下のすべてのディレクトリを再帰的に読み込みなおす。
    "\w 現在開いているファイルを閉じる
    "\W すべての開いているファイルを閉じる
    "プロジェクト自体を:wして保存
    "$VIMのパスにプロジェクト名でプロジェクトファイルが出来る
    "Enter the Name of the Entry
    "    プロジェクト名 例) “Hoge”
    "Enter the Absolute Directory to Load
    "    作業するファイル群のトップディレクトリ 例) “C:/projects/hoge”
    "Enter the CD parameter
    "    カレントディレクトリ 例) “.”
    "Enter the File Filter
    "    作業するファイルの拡張子 例) “*.html *.css *.js *.as”
    call dein#add('vimplugin/project.vim')
    "https://github.com/bling/vim-airline ※ステータスラインのカラーを変更
    "call dein#add('bling/vim-airline'
    "https://github.com/itchyny/lightline.vim ※ステータスラインのカラーを変更
    call dein#add('itchyny/lightline.vim')
    "https://github.com/LeafCage/yankround.vim ※レジスタの履歴を取得・再利用する
    call dein#add('LeafCage/yankround.vim')
    "https://github.com/koron/minimap-vim ※ミニマップ
    "call dein#add('koron/minimap-vim')
    "https://github.com/rust-lang/rust.vim ※rust言語の強調表示
    call dein#add('rust-lang/rust.vim')
    "https://github.com/phildawes/racer ※rust言語の補完
    "call dein#add('phildawes/racer')
    "https://github.com/thinca/vim-fontzoom ※フォントサイズを変更
    call dein#add('thinca/vim-fontzoom')
    "http://nanasi.jp/articles/vim/zoom_vim.htmlの方がWinGVimでは良い
    "カラースキーム
    "https://github.com/w0ng/vim-hybrid
    "call dein#add('w0ng/vim-hybrid')
    "https://github.com/29decibel/codeschool-vim-theme ※イタリック
    "call dein#add('29decibel/codeschool-vim-theme')
    "https://github.com/fugalh/desert.vim
    "call dein#add('fugalh/desert.vim')
    "https://github.com/jpo/vim-railscasts-theme
    call dein#add('jpo/vim-railscasts-theme')
    "https://github.com/vim-scripts/Align ※テキスト整形 GitHubのひとつ古いVer日本語にバグあり
    "本家http://www.vim.org/scripts/script.php?script_id=294
    "下記のコマンドで解凍できる
    ":e $VIM/user_plugins/Align.vba
    ":UseVimball $VIM/user_plugins/align
    "call dein#add('vim-scripts/Align'
    "SVNの場合
    "NeoBundle 'thinca/vim-localrc', {'type' : 'svn'}
    "https://github.com/vim-scripts/javacomplete ※ JAVA補完
    call dein#add('vim-scripts/javacomplete')
    "https://github.com/udalov/kotlin-vim ※Kotlinのシンタックス
    call dein#add('udalov/kotlin-vim')
    "https://github.com/davidhalter/jedi-vim ※Pythonの補完
    call dein#add('davidhalter/jedi-vim')
    "https://github.com/thinca/vim-quickrun ※プログラムの実行結果をVIMに表示
    call dein#add('thinca/vim-quickrun')
    "https://github.com/scrooloose/syntastic ※多言語対応の構文チェック
    call dein#add('scrooloose/syntastic')
    "https://github.com/hynek/vim-python-pep8-indent ※pep8インデント
    call dein#add('hynek/vim-python-pep8-indent')
    "https://github.com/kevinw/pyflakes-vim ※Pythonの構文チェック
    "call dein#add('kevinw/pyflakes-vim')

    call dein#add('mattn/emmet-vim')
    call dein#add('open-browser.vim')
    call dein#add('hail2u/vim-css3-syntax')
    "https://github.com/pangloss/vim-javascript
    call dein#add('pangloss/vim-javascript')

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"-------------------------------------------------------------------------------
"yankround.vim
"-------------------------------------------------------------------------------
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"-------------------------------------------------------------------------------
"lightline.vim
"-------------------------------------------------------------------------------
let g:lightline = {
       \ 'colorscheme': 'jellybeans',
    \ }
set laststatus=2
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'component': {
        \   'readonly': '%{&readonly?"?":""}',
        \ },
        \ 'separator': { 'left': '>>', 'right': '<<' },
        \ 'subseparator': { 'left': '>>', 'right': '<<' }
    \ }
"-------------------------------------------------------------------------------
"gundo.vim
"-------------------------------------------------------------------------------
nnoremap U :<C-u>GundoToggle<CR>
"-------------------------------------------------------------------------------
"Align ※SMコマンドが利かなくなる
"-------------------------------------------------------------------------------
" Alignを日本語環境で使用するための設定
"let g:Align_xstrlen = 3
" コマンドのフォーマット
" :Align {区切り文字}
" \tsp ※空白を整形
" \tab ※タブを整形
"-------------------------------------------------------------------------------
"vim-indent-guides
"-------------------------------------------------------------------------------
if has('gui')
    " vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
    let g:indent_guides_enable_on_vim_startup = 1
    " 奇数番目のインデントカラー
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=#444433 ctermbg=black
    " 偶数番目のインデントカラー
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#444433 ctermbg=darkgray
    " ガイドサイズ
    let g:indent_guides_guide_size=1
endif
"-------------------------------------------------------------------------------
"ctrlp.vim
"-------------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"-------------------------------------------------------------------------------
"vim-textmanip
"-------------------------------------------------------------------------------
xmap <M-d> <Plug>(textmanip-duplicate-down)
nmap <M-d> <Plug>(textmanip-duplicate-down)
xmap <M-D> <Plug>(textmanip-duplicate-up)
nmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

"-------------------------------------------------------------------------------
"Uniteにアクションを追加
"-------------------------------------------------------------------------------
" unite.vim に action を追加する
" unite-action start
if has('win32') || has ('win64')
    let start = {
          \ 'description' : 'start {word}',
          \ 'is_selectable' : 1,
          \ }
    function! start.func(candidates)"{{{
      for l:candidate in a:candidates
        call system("cmd /c start ".l:candidate.action__path)
      endfor
    endfunction"}}}
    call unite#custom_action('openable', 'start', start)
    unlet start
endif

"-------------------------------------------------------------------------------
"dbext.vim
"-------------------------------------------------------------------------------
"let g:dbext_default_profile_ORA_Extended_TEST = 'type=ORA:user=USERNAME:passwd=PASSWORD:srvname=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1000)))(CONNECT_DATA=(SERVICE_NAME=識別名)))'
"let dbext_default_profile='dbext_map_profile_ORA_Extended_TEST'
"vimに表示する行数
"let dbext_default_buffer_lines=1000

"-------------------------------------------------------------------------------
"matchit.vim 括弧などの対となる文字に%キーでジャンプ
"-------------------------------------------------------------------------------
source $VIMRUNTIME/macros/matchit.vim " 有効化
let b:match_ignorecase=1 " 移動に大文字小文字を区別しない
set matchpairs+=<:> " 括弧<>を追加
"-------------------------------------------------------------------------------
"Source Explorer
"-------------------------------------------------------------------------------
"let g:SrcExpl_RefreshTime=0 "手動でtag先を表示Normalモードで単語（tag）ので<space>を叩く。
let g:SrcExpl_RefreshTime=0 "自動でtag先を表示
let g:SrcExpl_isUpdateTags=0 "tagsの自動更新 0非更新:1更新

"-------------------------------------------------------------------------------
"quickrun.vim
"-------------------------------------------------------------------------------
" 一番下にウィンドウを分割させて出力
":QuickRun -outputter/buffer/split ":botright"

" ウィンドウの高さを指定する場合
":QuickRun -outputter/buffer/split ":botright 8sp"

" 出力がなかった場合に出力バッファを自動的に閉じる
":QuickRun -outputter/buffer/close_on_empty 1

" quickfix へと出力する
":QuickRun -outputter quickfix

" 実行時間を計測し、その結果も最後に出力する
":QuickRun ruby -hook/time/enable 1

" runner/vimproc/updatetime で出力バッファの更新間隔をミリ秒で設定できます
" updatetime が一時的に書き換えられてしまうので注意して下さい
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
"-------------------------------------------------------------------------------
"jedi-vim
"-------------------------------------------------------------------------------
" rename用のマッピングを無効にしたため、代わりにコマンドを定義
"command! -nargs=0 JediRename :call jedi#rename()

" pythonのrename用のマッピングがquickrunとかぶるため回避させる
"let g:jedi#rename_command = ""

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"-------------------------------------------------------------------------------
"syntastic
"-------------------------------------------------------------------------------
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'python']
            \}

"-------------------------------------------------------------------------------
"全角スペースを表示
"-------------------------------------------------------------------------------
" 全角スペースの表示
" Two-byte space
autocmd ColorScheme * hi link TwoByteSpace Error
if has('gui_running')
    autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '　')
endif

"-------------------------------------------------------------------------------
"補完設定 neocomplete.vim
"-------------------------------------------------------------------------------
" For smart TAB completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
    function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
" 大文字小文字無視
let g:neocomplete#enable_ignore_case=1

"補完選択時に自動改行するのを防止する
" Recommended key-mappings.
    " <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction



" 自動補完
let g:acp_enableAtStartup = 0
" プラグイン自動有効化
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType *.php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType *.cpp,*.h,*.hpp setlocal omnifunc=cppcomplete#CompleteCPP

autocmd FileType java :setlocal omnifunc=javacomplete#Complete
autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType kotlin :setlocal omnifunc=javacomplete#Complete
autocmd FileType kotlin :setlocal completefunc=javacomplete#CompleteParamsInfo

" docstringは表示しない
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'



"Eclimをインストールしている場合
"let g:EclimCompletionMethod = 'omnifunc'
"if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.java = '\k\.\k*'



"-------------------------------------------------------------------------------
"SingletonVIM
"-------------------------------------------------------------------------------
call singleton#enable()



"-------------------------------------------------------------------------------
"VimFiler
"-------------------------------------------------------------------------------
"セーフモードをOFF コピー等ができるようになる
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_enable_auto_cd = 1

"-------------------------------------------------------------------------------
"ファイル判定の有効化
"-------------------------------------------------------------------------------
" Required:
filetype plugin indent on

"-------------------------------------------------------------------------------
"GitHub以外
"-------------------------------------------------------------------------------
"https://sites.google.com/site/fudist/Home/qfixhowm ※カレンダー・スケジュール・メモ
"http://nanasi.jp/articles/vim/kwbd_vim.html ※レイアウトを崩さずにバッファを閉じる
"http://www.vim.org/scripts/script.php?script_id=273 ※tagのリストを表示GitHubは古いバージョンしか置いていない

"-------------------------------------------------------------------------------
"ショートカットメモ
"-------------------------------------------------------------------------------
"<C-w>s 横分割
"<C-w>v 縦分割
"<C-w>q ウインドウを閉じる
"<C-w>hjkl or <C-w>w ウインドウ移動


"-------------------------------------------------------------------------------
"VimFilerショートカット
"-------------------------------------------------------------------------------
"┏━━━┳━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
"┃キー  ┃対象      ┃機能                                                  ┃
"┣━━━╋━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃e     ┃カーソル下┃ファイル → vim で開く                                ┃
"┃      ┃          ┃ディレクトリ → vimfiler で開く                       ┃
"┣━━━╋━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃x     ┃カーソル下┃システムの関連付けを実行                              ┃
"┣━━━╋━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃Enter ┃カーソル下┃vimfiler の関連付けを実行                             ┃
"┃      ┃          ┃（ディレクトリの場合は移動）                          ┃
"┣━━━╋━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃l     ┃カーソル下┃vimfiler の関連づけを実行                             ┃
"┣━━━╋━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃E     ┃--        ┃外部ファイラでディレクトリを開く(Mac なら Finder など)┃
"┗━━━┻━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
"┏━┳━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
"┃r ┃カーソル下／選択┃ファイルの名前を変更                                      ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃m ┃--／選択        ┃ファイルを移動                                            ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃c ┃--／選択        ┃ファイルをコピー                                          ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃p ┃--              ┃ファイルをペースト                                        ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃d ┃--／選択        ┃ファイルを削除（ゴミ箱への移動）                          ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃D ┃--／選択        ┃ファイルを削除（rm 相当）                                 ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃u ┃--／選択        ┃ファイルをゴミ箱から復元（d によって削除したもののみ有効）┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃K ┃--              ┃新規ディレクトリを作成                                    ┃
"┣━╋━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"┃N ┃--              ┃新規ファイルを作成                                        ┃
"┗━┻━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

