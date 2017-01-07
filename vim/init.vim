" Have a random vimrc file!
" Global defaults. Check ftplugin/*.vim for language specific settings

scriptencoding utf-8

" Plugins --- {{{
filetype off
call plug#begin('~/.local/share/vim-plugins')

" Visuals! --- {{{

set termguicolors

" Guistuff?
Plug 'equalsraf/neovim-gui-shim'

" Colourful statusbar
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'

" Better startpage
Plug 'mhinz/vim-startify'

" Colourful parentheses for easier visual matching
Plug 'kien/rainbow_parentheses.vim'

" Colorschemes
Plug 'chriskempson/base16-vim'

" File explorer
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'

" Handy exuberant ctags display
Plug 'majutsushi/tagbar'

" Visual & Handy buffer viewer
Plug 'weynhamz/vim-plugin-minibufexpl'

" Relative numbers in Normal & Visual, Absolute in Insert
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Show git diff stats in the gutter
Plug 'airblade/vim-gitgutter'

" Visualize the Undo-Tree
Plug 'mbbill/undotree'

" }}}

Plug 'dean4devil/vim-hodgepodge'

" Handy little utilities --- {{{

" Interactive command execution (mainly dependency)
" vebugger still requires vimproc
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'

Plug 'tpope/vim-speeddating'

" Better fold mechanics
Plug 'Konfekt/FastFold'

Plug 'blindFS/vim-taskwarrior'

" Github Gist integrations!
Plug 'mattn/gist-vim'

" Enable plugins to repeat actions using '.'
Plug 'tpope/vim-repeat'

" Make Brackets and tags not be a pain to deal with
Plug 'tpope/vim-surround'
Plug 'cohama/lexima.vim'

" Comment functions so powerful - no comment needed.
Plug 'scrooloose/nerdcommenter'

" A few nice mappings
Plug 'tpope/vim-unimpaired'

" Automatic alignment
Plug 'godlygeek/tabular'

" Autoformat source code for beauties' sake.
Plug 'Chiel92/vim-autoformat'

" Movement ... I don't even have words for this.
Plug 'easymotion/vim-easymotion'

" Snippets!
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'kiryph/vim-snippets', { 'as': 'latex-snippets', 'for': ['plaintex', 'tex'] }
" }}}


" Full IDE features --- {{{

" Git integration so awesome it should be illegal
Plug 'tpope/vim-fugitive'

" Language-aware syntax and sanity checker
Plug 'neomake/neomake'

" Debugger Support
Plug 'idanarye/vim-vebugger'

" Code-Completion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neoinclude.vim'

Plug 'wellle/tmux-complete.vim'

" OpenLDAP {{{
Plug 'vim-scripts/slapd.vim'
" }}}

" Language specifics ---- {{{

" C / C++
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp', 'objc', 'objcpp'] }


" Haskell
Plug 'eagletmt/neco-ghc', { 'for': ['haskell', 'lhaskell'] }

Plug 'dag/vim2hs', { 'for': ['haskell', 'lhaskell', 'cabal'] }
"Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'lhaskell', 'cabal'] }
Plug 'pbrisbin/vim-syntax-shakespeare', { 'for': ['haskell', 'lhaskell'] }
Plug 'bitc/vim-hdevtools', { 'for': ['haskell', 'lhaskell'] }
Plug 'eagletmt/ghcmod-vim', { 'for': ['haskell', 'lhaskell'] }


" Rust
"Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" ASM
Plug 'Harenome/vim-mipssyntax', { 'for': 'asm' }


" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
"  }}}
" }}}

" LaTeX
Plug 'lervag/vimtex', { 'for': ['plaintex', 'tex'] }

" For when writing --- {{{
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" }}}

"Plug 'jalcine/cmake.vim'

call plug#end()
filetype plugin indent on
" }}}

" Settings --- {{{

" Disable concealing characters globally, enable in code.vim
set conceallevel=0

syntax on
let g:rehash256 = 1

set lazyredraw
set hidden

cnoremap help vert botright help
cabbrev h vert botright h

set smartindent
set autoindent

set smartcase

set so=1

set showmatch

set incsearch
set nohlsearch
nnoremap <Leader>h :set hlsearch!<CR>

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set foldenable
set foldlevelstart=10
set foldmethod=indent

set cursorline

" Don't save blank windows so Syntastic's quickfix window does not get saved
set sessionoptions-=blank
set sessionoptions-=options

set list listchars=tab:»\ ,trail:·,nbsp:·
set number

" No visual bell
set noerrorbells
set belloff=all

" Neovim makes heavy use of Mouse. I don't particularly like that.
set mouse=

" use the silver searcher as grep replacement
set grepprg=ag\ --nogroup\ --nocolor

set switchbuf=useopen

colorscheme base16-default-dark
" }}}

" Mappings {{{
let g:mapleader = ','
let g:maplocalleader = ','

let g:vebugger_leader = '+'

" Moving up or down respects visual wraps
nnoremap j gj
nnoremap k gk

" Highlight the last inserted text
nnoremap gV `[v`]

" I don't use the command line and this makes everything just that much less
" annoying.
map q: :q

" Save as sudo
cmap w!! w !sudo tee > /dev/null %

nnoremap <leader>w :w<CR>

" Use startify's session save mechanics
nnoremap <leader>S :SSave<CR>

" Tabularize shortcuts
nnoremap <S-T> :Tabularize /
nnoremap <S-T>. :Tabularize /\.<CR>
vnoremap <S-T> :Tabularize /
vnoremap <S-T>. :Tabularize /\.<CR>

" Manual trigger
let g:NumberToggleTrigger = '<C-m>'

function! SynStack()
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunction
nmap <C-L> :call SynStack()<CR>
" }}}

" Autocmds --- {{{
" Autocmds are rarely necessary. Use language specific configs in ftplugin/
" instead.

" Switch to absolute numbers in insert mode
augroup nmbrs
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" Plugin specific Settings --- {{{

" CtrlP --- {{{
" Use ag as CtrlP fuzzy searcher
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
" }}}

" Statusline (lightline) design {{{
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ 'component' : {
            \ 'readonly': '%{&readonly?"":""}',
            \ 'lineinfo': ' %3l:%-2v',
            \ 'arch': ' '
            \},
            \ 'component_function': {
            \ 'filetype': 'IconFiletype',
            \ 'fileformat': 'IconFileformat',
            \ 'git': 'FugitiveBranchStatus'
            \},
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': ''  },
            \ 'active': {
            \ 'left': [ [ 'arch' ],
            \           [ 'mode', 'paste' ],
            \           [ 'readonly', 'git', 'filename', 'modified' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \},
            \ 'inactive': {
            \ 'left': [ [ 'git', 'filename', 'modified' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ] ]
            \},
            \ 'tab': {
            \ 'active': [ 'tabnum', 'filename', 'bufnum', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ]
            \},
            \ 'tabline' : {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': []
            \}
            \}

function! IconFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! IconFileformat()
    return winwidth(0) > 70 ? WebDevIconsGetFileFormatSymbol() : ''
endfunction

function! FugitiveBranchStatus()
    if exists('*fugitive#head')
        let l:branch = fugitive#head()
        return l:branch !=# '' ? ' '.l:branch : ''
    endif
endfunction

" since this information is now provided by lightline:
set noshowmode

" }}}

" Binary!
augroup Binary
    au!
    au BufReadPre   *.pgm let &bin=1
    au BufReadPost  *.pgm if &bin | %!xxd
    au BufReadPost  *.pgm set ft=xxd | endif
    au BufWritePre  *.pgm if &bin | %!xxd -r
    au BufWritePre  *.pgm endif
    au BufWritePost *.pgm if &bin | %!xxd
    au BufWritePost *.pgm set nomod | endif
augroup END

" MiniBufExplorer --- {{{
nnoremap <Leader>o :MBEOpen<cr>
nnoremap <Leader>c :MBEClose<cr>
nnoremap <Leader>f :MBEFocus<cr>

" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

augroup mbe
    autocmd BufWinLeave * call clearmatches()
augroup END
" }}}

" Fugitive {{{
augroup fugitive
    autocmd BufReadPost fugitive:// set bufhidden=delete
augroup END
" }}}


" NERDTree ---- {{{
map <F2> :NERDTreeToggle<CR>
let g:webdevicons_enable_nerdtree = 0
let g:NERDTreeIndicatorMapCustom = {
            \ 'Modified'  : '',
            \ 'Staged'    : '',
            \ 'Untracked' : '',
            \ 'Renamed'   : '',
            \ 'Unmerged'  : '',
            \ 'Deleted'   : '',
            \ 'Dirty'     : '',
            \ 'Clean'     : '',
            \ 'Unknown'   : ''
            \ }
" }}}

" Tagbar --- {{{
map <F3> :Tagbar<CR>
" }}}

" Undotree --- {{{
map <F4> :UndotreeToggle
" }}}

" UltiSnips ---- {{{
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsListSnippets = '<c-l>'
" }}}

" Added so <c-j> works for me
nnoremap <C-space> <Plug>IMAP_JumpForward
"

" Multiple Cursors ---- {{{
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
" }}}

" Autoformat ---- {{{
noremap <F6> :Autoformat<CR>
" }}}

" Writing mode --- {{{
" Defaults
let g:goyo_width = 100
let g:limelight_default_coefficient = 0.7

" Make Goyo toggle Limelight
function! s:goyo_enter()
    nnoremap <F5> :Goyo!<CR>
    MBEClose
    Limelight
endfunction
function! s:goyo_leave()
    nnoremap <F5> :Goyo<CR>
    MBEOpen
    "Limelight!
endfunction

nnoremap <F5> :Goyo<CR>

augroup goyo
    au!
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END
" }}}


" Startify {{{
let g:startify_session_dir = '~/.local/share/nvim/sessions'
let g:startify_list_order = [
            \ ['    MRU:'],
            \ 'files',
            \ ['    Current Directory MRU:'],
            \ 'dir',
            \ ['    Bookmarks:'],
            \ 'bookmarks',
            \ ['    Saved Sessions:'],
            \ 'sessions',
            \ ['    Saved Commands:'],
            \ 'commands'
            \]
let g:startify_bookmarks = [{'r': '~/.config/nvim/init.vim'}]

let g:startify_commands = [
            \ {'u': ['Update Plugins', 'PlugUpdate']},
            \ ]
source ~/.local/share/nvim/site/plugin/kitty.vim
let g:startify_custom_header = kitty#kittysay()
" }}}

" Unite {{{
nnoremap <C-P> :Unite -start-insert file<CR>
" }}}

" Neomake {{{
let g:neomake_open_list = 0
let g:neomake_list_height = 10
let g:neomake_error_sign = {'text': ' ', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': ' ', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': ' ', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': ' ', 'texthl': 'NeomakeInfoSign'}

let g:neomake_vim_enabled_makers = []

hi NeomakeWarningSign guifg=#da9100
hi NeomakeMessageSign guifg=#daa520
hi NeomakeErrorSign   guifg=#e25822
hi NeomakeInfoSign    guifg=#c4c3d0
" }}}

" Some shortcuts I like:
" Make life easier ---- {{{
" Edit and source ~/.vimrc in a breeze
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Quickly put a word in double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
vnoremap <leader>* c**<C-R>"**<ESC>
" }}}

" Movement shortcuts ---- {{{
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" Switch buffers with Ctrl-Tab/Ctrl-Shift-tab
nnoremap <c-tab>   :MBEbn<cr>
nnoremap <c-s-tab> :MBEbp<CR>
" }}}

" Abbrevations ---- {{{
iabbrev waht what
iabbrev teh the
iabbrev adn and
iabbrev loacl local
iabbrev lenght length
" }}}

"}}}

" vim: foldmethod=marker
