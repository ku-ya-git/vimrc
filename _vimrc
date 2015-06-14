"-------------------------------------------------------------------------------
"�ݒ�̂��߂Ƀt�@�C���^�C�v�����OFF
"-------------------------------------------------------------------------------
filetype off
filetype plugin indent off

"-------------------------------------------------------------------------------
"VIM�W���ݒ�
"-------------------------------------------------------------------------------
set undodir=$VIM/undo "�A���h�D�t�@�C���t�H���_
set directory=$VIM/swp "�X���b�v�t�@�C���t�H���_
set noswapfile "�X���b�v�t�@�C���𐶐����Ȃ�
set nobackup "�o�b�N�A�b�v�t�@�C���𐶐����Ȃ�
"set clipboard+=unnamed "�N���b�v�{�[�h�ƃ��W�X�^��A�g
set clipboard=unnamed,unnamedplus
set number "���C���ԍ���\��
set showtabline=2 " �^�u����ɕ\��
set antialias " �A���`�G�C���A�X
set tabstop=4 " �^�u�T�C�Y
set shiftwidth=4 " �C���f���g��
set visualbell t_vb= " �r�[�v���Ȃ�
set autoindent " �����C���f���g
set expandtab " �^�u�X�y�[�X��
set novisualbell " ��ʓ_�ł�����
set cursorline " �J�[�\���ʒu�������ŕ\��
"set cursorcolumn " �J�[�\���ʒu���c���ŕ\��
set ambiwidth=double " �S�p�L��������
set nowrap " ��ʕ��Ő܂�Ԃ��Ȃ�
set ignorecase " �������ɑ啶������������ʂ��Ȃ�
set ignorecase " �啶����������������
set showmatch " �Ή����銇�ʂ������\��
set guioptions-=m " ���j���[�o�[��\��
set guioptions-=T " �c�[���o�[���\��
set updatetime=1000 " VIM�̎����X�V����
set virtualedit=all " �t���[�J�[�\��
" �����R�[�h�̗D�揇��
set fileencodings=ucs-bom,utf-16le,utf-16,utf-8,iso-2022-jp,cp932,sjis,euc-jp
" 80�����ŏc���\��
set textwidth=80
    if exists('&colorcolumn')
    set colorcolumn=+2
endif


" �J�����g�t�H���_��ύX
lcd C:\Users\sky\Desktop\

" �^�u�̕\��
set list
set listchars=tab:>-,trail:-,extends:<,precedes:<


" �V�����s�̃C���f���g�����ݍs�Ɠ����ɂ���
set autoindent
" �V�����s��������Ƃ��ɍ��x�Ȏ����C���f���g���s��
set smartindent

set showmatch "�Ή����銇�ʂ�\��

"�������s��������p����
set textwidth=0
"�������s����������{��
set formatoptions=q

"�E�^�u�Ɉړ�
noremap <C-Tab> <ESC>:tabn<CR>

"���^�u�Ɉړ�
noremap <C-S-Tab> <ESC>:tabp<CR>

"Ctrl+z�ŃA���h�D
inoremap <C-z> <ESC>:u<CR>a
nnoremap <C-z> <ESC>:u<CR>

"Ctrl+s�ŕۑ��ƃA���h�D���m��
inoremap <C-s> <C-G>u<ESC>:w<CR>a
nnoremap <C-s> <ESC>:w<CR>

"�A�E�g���C��
nnoremap <S-o> :Unite outline<CR>

"���ׂđI��
nnoremap <C-a> <ESC>ggVG

"�����n�C���C�g����
nnoremap <ESC><ESC> :noh<CR>

"tags���J�����g�ɖ����ꍇ�A�e�f�B���N�g�������ɍs��
set tags=tags;
nnoremap <C-]> g<C-]>

"tag�t�@�C������ɂ����n�C���C�g
map <F11>  :sp tags<CR>:%s/^\([^     :]*:\)\=\([^    ]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <F12>  :so tags.vim<CR>

"�����̃C�^���b�N�\���𖳌���
hi markdownItalic gui=none

"�C���f���g�̎��������ύX
set foldmethod=manual
set foldlevel=12
autocmd FileType java :set foldmethod=indent
autocmd FileType sql :set foldmethod=indent
autocmd FileType html :set foldmethod=indent
autocmd FileType jsp :set foldmethod=indent

"-------------------------------------------------------------------------------
"�X�e�[�^�[�o�[�ɕ����R�[�h�Ɖ��s�R�[�h��\��
"-------------------------------------------------------------------------------
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"-------------------------------------------------------------------------------
"�����X�N���[���o�[
"-------------------------------------------------------------------------------
if has('gui')
    set guioptions+=b
endif
"-------------------------------------------------------------------------------
" �J�����g�f�B���N�g���̐ݒ�
"-------------------------------------------------------------------------------
" �t�@�C���̃f�B���N�g���������I�ɃJ�����g�f�B���N�g���ɕύX���܂�
au BufEnter * execute ":lcd " . expand("%:p:h")

"-------------------------------------------------------------------------------
" ���[�U�[�v���O�C���̐ݒ�
"-------------------------------------------------------------------------------
for s:path in split(glob($VIM.'/user_plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path
"-------------------------------------------------------------------------------
"NeoBundle
"-------------------------------------------------------------------------------
" bundle�ŊǗ�����f�B���N�g�����w��
if has("vim_starting")
  set nocompatible
  set runtimepath+=$VIM/bundle/neobundle.vim
endif
call neobundle#begin(expand($VIM.'/bundle/'))
let g:neobundle#install_process_timeout = 300

"neobundle���̂�neobundle�ŊǗ�
NeoBundleFetch 'Shougo/neobundle.vim'
"https://github.com/Shougo/vimproc.vim ��kaoriya��VIM�̏ꍇ�͕s�v
"NeoBundleFetch 'Shougo/vimproc.vim'
"https://github.com/Shougo/neocomplete.vim ���⊮
NeoBundleFetch 'Shougo/neocomplete.vim'
"https://github.com/Shougo/unite.vim ��Unite�v���b�g�t�H�[��
NeoBundleFetch 'Shougo/unite.vim'
"https://github.com/Shougo/unite-outline ���A�E�g���C��
NeoBundleFetch 'Shougo/unite-outline'
"https://github.com/Shougo/vimfiler.vim ���t�@�C���[Explore��苭��
NeoBundleFetch 'Shougo/vimfiler.vim'
"https://github.com/Shougo/neomru.vim ��Unite�t�@�C������
NeoBundleFetch 'Shougo/neomru.vim'
"https://github.com/glidenote/memolist.vim ������
NeoBundleFetch 'glidenote/memolist.vim'
"https://github.com/wesleyche/SrcExpl ��tags���\��
NeoBundleFetch 'wesleyche/SrcExpl'
"https://github.com/vim-scripts/Trinity ��IDE��
NeoBundleFetch 'vim-scripts/Trinity'
"https://github.com/sgur/unite-everything ���t�@�C������
NeoBundleFetch 'sgur/unite-everything'
"https://github.com/thinca/vim-singleton ��VIM�̃V���O���N��
NeoBundleFetch 'thinca/vim-singleton'
"https://github.com/t9md/vim-textmanip ���͈͑I���̈ړ�
NeoBundleFetch 't9md/vim-textmanip'
"https://github.com/ctrlpvim/ctrlp.vim ��Ctrl+P�Őe�t�H���_�iSVN��Git�j�t�H���_"�̌���
NeoBundleFetch 'ctrlpvim/ctrlp.vim'
"https://github.com/tomtom/tcomment_vim ��gc�őI��͈͂̃R�����g�؂�ւ�
NeoBundleFetch 'tomtom/tcomment_vim'
"https://github.com/tpope/vim-surround ��cs"'�ŃV���O���N�I�[�g�ƃ_�u���N�I�[�g��؂�ւ���
NeoBundleFetch 'tpope/vim-surround'
"https://github.com/nathanaelkane/vim-indent-guides ���C���f���g�̉���
NeoBundleFetch 'nathanaelkane/vim-indent-guides'
"https://github.com/junegunn/vim-easy-align ���e�L�X�g���`
"���g���� CSV�̏ꍇ�Ώۂ�I����EasyAlign *,�ŃG���^�[
"EasyAlign �����+��؂蕶��
"����񐔂ɂ̓��C���h�J�[�h���g����
NeoBundleFetch 'junegunn/vim-easy-align'
"https://github.com/sjl/gundo.vim ��UNDO�̗����Ǘ�
NeoBundleFetch 'sjl/gundo.vim'
"https://github.com/vim-scripts/TagHighlight ��ctag�̃n�C���C�g
"�n�C���C�g����ɂ�:UpdateTypesFile�����s
NeoBundleFetch 'vim-scripts/TagHighlight'
"https://github.com/vim-scripts/dbext.vim ��DB�N���C�A���g
"NeoBundleFetch 'vim-scripts/dbext.vim'
"https://github.com/vimplugin/project.vim ���v���W�F�N�g�Ǘ� �l��GitHub�~���[
":Project�Ńv���W�F�N�g�Ǘ����J��
"\c �Θb�I�ɐV�����f�B���N�g�����v���W�F�N�g�ɒǉ�����B
"\C \c�Ɠ��������A�w�肵���f�B���N�g���ȉ��̂��ׂẴf�B���N�g�����ċA�I�Ƀv���W�F�N�g�ɒǉ�����B
"\r ���݃J�[�\��������f�B���N�g���̒��g���ēx�ǂݍ��݂Ȃ����B�v���W�F�N�g�̐ݒ��ύX�����Ƃ���t�@�C����ǉ������Ƃ��ȂǂɎ��s����B
"\R \r�Ɠ��������A�w�肵���f�B���N�g���ȉ��̂��ׂẴf�B���N�g�����ċA�I�ɓǂݍ��݂Ȃ����B
"\w ���݊J���Ă���t�@�C�������
"\W ���ׂĂ̊J���Ă���t�@�C�������
"�v���W�F�N�g���̂�:w���ĕۑ�
"$VIM�̃p�X�Ƀv���W�F�N�g���Ńv���W�F�N�g�t�@�C�����o����
"Enter the Name of the Entry
"    �v���W�F�N�g�� ��) �gHoge�h
"Enter the Absolute Directory to Load
"    ��Ƃ���t�@�C���Q�̃g�b�v�f�B���N�g�� ��) �gC:/projects/hoge�h
"Enter the CD parameter
"    �J�����g�f�B���N�g�� ��) �g.�h
"Enter the File Filter
"    ��Ƃ���t�@�C���̊g���q ��) �g*.html *.css *.js *.as�h
NeoBundleFetch 'vimplugin/project.vim'
"https://github.com/bling/vim-airline ���X�e�[�^�X���C���̃J���[��ύX
"NeoBundleFetch 'bling/vim-airline'
"https://github.com/itchyny/lightline.vim ���X�e�[�^�X���C���̃J���[��ύX
NeoBundleFetch 'itchyny/lightline.vim'
"https://github.com/LeafCage/yankround.vim �����W�X�^�̗������擾�E�ė��p����
NeoBundleFetch 'LeafCage/yankround.vim'
"https://github.com/koron/minimap-vim ���~�j�}�b�v
NeoBundleFetch 'koron/minimap-vim'
"https://github.com/rust-lang/rust.vim ��rust����̋����\��
NeoBundleFetch 'rust-lang/rust.vim'
"https://github.com/phildawes/racer ��rust����̕⊮
"NeoBundleFetch 'phildawes/racer'
"https://github.com/thinca/vim-fontzoom ���t�H���g�T�C�Y��ύX
"NeoBundleFetch 'thinca/vim-fontzoom'
"http://nanasi.jp/articles/vim/zoom_vim.html�̕���WinGVim�ł͗ǂ�

"�J���[�X�L�[��
"https://github.com/w0ng/vim-hybrid
"NeoBundleFetch 'w0ng/vim-hybrid'
"https://github.com/29decibel/codeschool-vim-theme ���C�^���b�N
"NeoBundleFetch '29decibel/codeschool-vim-theme'
"https://github.com/fugalh/desert.vim
"NeoBundleFetch 'fugalh/desert.vim'
"https://github.com/jpo/vim-railscasts-theme
NeoBundleFetch 'jpo/vim-railscasts-theme'

"https://github.com/vim-scripts/Align ���e�L�X�g���` GitHub�̂ЂƂÂ�Ver���{��Ƀo�O����
"�{��http://www.vim.org/scripts/script.php?script_id=294
"���L�̃R�}���h�ŉ𓀂ł���
":e $VIM/user_plugins/Align.vba
":UseVimball $VIM/user_plugins/align
"NeoBundleFetch 'vim-scripts/Align'
"SVN�̏ꍇ
"NeoBundle 'thinca/vim-localrc', {'type' : 'svn'}


call neobundle#end()

" ���C���X�g�[���̃v���O�C��������ꍇ�A�C���X�g�[�����邩�ǂ�����q�˂Ă����悤�ɂ���ݒ�
NeoBundleCheck

for s:path in split(glob($VIM.'/bundle/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

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
"Align ��SM�R�}���h�������Ȃ��Ȃ�
"-------------------------------------------------------------------------------
" Align����{����Ŏg�p���邽�߂̐ݒ�
"let g:Align_xstrlen = 3

" �R�}���h�̃t�H�[�}�b�g
" :Align {��؂蕶��}
" \tsp ���󔒂𐮌`
" \tab ���^�u�𐮌`

"-------------------------------------------------------------------------------
"vim-indent-guides
"-------------------------------------------------------------------------------
if has('gui')
    " vim�𗧂��グ���Ƃ��ɁA�����I��vim-indent-guides���I���ɂ���
    let g:indent_guides_enable_on_vim_startup = 1
    " ��Ԗڂ̃C���f���g�J���[
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   guibg=#444433 ctermbg=black
    " �����Ԗڂ̃C���f���g�J���[
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#444433 ctermbg=darkgray
    " �K�C�h�T�C�Y
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
"Unite�ɃA�N�V������ǉ�
"-------------------------------------------------------------------------------
" unite.vim �� action ��ǉ�����
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
"let g:dbext_default_profile_ORA_Extended_TEST = 'type=ORA:user=USERNAME:passwd=PASSWORD:srvname=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1000)))(CONNECT_DATA=(SERVICE_NAME=���ʖ�)))'
"let dbext_default_profile='dbext_map_profile_ORA_Extended_TEST'

"vim�ɕ\������s��
"let dbext_default_buffer_lines=1000

"-------------------------------------------------------------------------------
"matchit.vim ���ʂȂǂ̑΂ƂȂ镶����%�L�[�ŃW�����v
"-------------------------------------------------------------------------------
source $VIMRUNTIME/macros/matchit.vim " �L����
let b:match_ignorecase=1 " �ړ��ɑ啶������������ʂ��Ȃ�
set matchpairs+=<:> " ����<>��ǉ�

"-------------------------------------------------------------------------------
"Source Explorer
"-------------------------------------------------------------------------------
"let g:SrcExpl_RefreshTime=0 "�蓮��tag���\��Normal���[�h�ŒP��itag�j�̂�<space>��@���B
let g:SrcExpl_RefreshTime=0 "������tag���\��
let g:SrcExpl_isUpdateTags=0 "tags�̎����X�V 0��X�V:1�X�V

"-------------------------------------------------------------------------------
"�S�p�X�y�[�X��\��
"-------------------------------------------------------------------------------
" �S�p�X�y�[�X�̕\��
" Two-byte space
autocmd ColorScheme * hi link TwoByteSpace Error
if has('gui_running')
    autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '�@')
endif


"-------------------------------------------------------------------------------
"�⊮�ݒ� neocomplete.vim
"-------------------------------------------------------------------------------
" For smart TAB completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
    function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
" �啶������������
let g:neocomplete#enable_ignore_case=1

"�⊮�I�����Ɏ������s����̂�h�~����
" Recommended key-mappings.
    " <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" �����⊮
let g:acp_enableAtStartup = 0
" �v���O�C�������L����
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

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"Eclim���C���X�g�[�����Ă���ꍇ
let g:EclimCompletionMethod = 'omnifunc'
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.java = '\k\.\k*'

"-------------------------------------------------------------------------------
"SingletonVIM
"-------------------------------------------------------------------------------
call singleton#enable()

"-------------------------------------------------------------------------------
"VimFiler
"-------------------------------------------------------------------------------
"�Z�[�t���[�h��OFF �R�s�[�����ł���悤�ɂȂ�
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_enable_auto_cd = 1



"-------------------------------------------------------------------------------
"�t�@�C������̗L����
"-------------------------------------------------------------------------------
" Required:
filetype plugin indent on

"-------------------------------------------------------------------------------
"GitHub�ȊO
"-------------------------------------------------------------------------------
"https://sites.google.com/site/fudist/Home/qfixhowm ���J�����_�[�E�X�P�W���[���E����
"http://nanasi.jp/articles/vim/kwbd_vim.html �����C�A�E�g��������Ƀo�b�t�@�����
"http://www.vim.org/scripts/script.php?script_id=273 ��tag�̃��X�g��\��GitHub�͌Â��o�[�W���������u���Ă��Ȃ�

"-------------------------------------------------------------------------------
"�V���[�g�J�b�g����
"-------------------------------------------------------------------------------
"<C-w>s ������
"<C-w>v �c����
"<C-w>q �E�C���h�E�����
"<C-w>hjkl or <C-w>w �E�C���h�E�ړ�

"-------------------------------------------------------------------------------
"VimFiler�V���[�g�J�b�g
"-------------------------------------------------------------------------------
"������������������������������������������������������������������������������
"���L�[  ���Ώ�      ���@�\                                                  ��
"������������������������������������������������������������������������������
"��e     ���J�[�\�������t�@�C�� �� vim �ŊJ��                                ��
"��      ��          ���f�B���N�g�� �� vimfiler �ŊJ��                       ��
"������������������������������������������������������������������������������
"��x     ���J�[�\�������V�X�e���̊֘A�t�������s                              ��
"������������������������������������������������������������������������������
"��Enter ���J�[�\������vimfiler �̊֘A�t�������s                             ��
"��      ��          ���i�f�B���N�g���̏ꍇ�͈ړ��j                          ��
"������������������������������������������������������������������������������
"��l     ���J�[�\������vimfiler �̊֘A�Â������s                             ��
"������������������������������������������������������������������������������
"��E     ��--        ���O���t�@�C���Ńf�B���N�g�����J��(Mac �Ȃ� Finder �Ȃ�)��
"������������������������������������������������������������������������������
"������������������������������������������������������������������������������������
"��r ���J�[�\�����^�I�����t�@�C���̖��O��ύX                                      ��
"������������������������������������������������������������������������������������
"��m ��--�^�I��        ���t�@�C�����ړ�                                            ��
"������������������������������������������������������������������������������������
"��c ��--�^�I��        ���t�@�C�����R�s�[                                          ��
"������������������������������������������������������������������������������������
"��p ��--              ���t�@�C�����y�[�X�g                                        ��
"������������������������������������������������������������������������������������
"��d ��--�^�I��        ���t�@�C�����폜�i�S�~���ւ̈ړ��j                          ��
"������������������������������������������������������������������������������������
"��D ��--�^�I��        ���t�@�C�����폜�irm �����j                                 ��
"������������������������������������������������������������������������������������
"��u ��--�^�I��        ���t�@�C�����S�~�����畜���id �ɂ���č폜�������̂̂ݗL���j��
"������������������������������������������������������������������������������������
"��K ��--              ���V�K�f�B���N�g�����쐬                                    ��
"������������������������������������������������������������������������������������
"��N ��--              ���V�K�t�@�C�����쐬                                        ��
"������������������������������������������������������������������������������������
