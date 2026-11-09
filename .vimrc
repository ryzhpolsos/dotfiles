set nocompatible
set mouse=a

set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,э',яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Э\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\<,Ю\>,Ё\~

noremap <C-c> "+y
noremap! <C-c> <C-o>"+y
noremap <C-v> "+p
noremap! <C-v> <C-o>"+p

noremap <C-s> :w<Enter>

noremap <C-q> :tabclose<CR>
noremap <S-Tab> :tabnext<CR>
noremap <Tab> <C-w>w
noremap <C-`> :call OpenTerminal(expand("$SHELL"))<CR>
noremap <F2> :call OpenTerminal(expand("$SHELL"))<CR>
noremap <F3> :TagbarToggle<CR>
noremap <F5> :call OpenTerminal(&makeprg)<CR>

tnoremap <F1> <C-w>N
inoremap <F1> <C-x><C-o>

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set noruler
set backspace=indent,eol,start
set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off
set textwidth=0
set nofoldenable

for dir in ['~/.vim/backup', '~/.vim/swap', '~/.vim/undo']
    let dir = expand(dir)

    if !isdirectory(dir)
        call mkdir(dir)
    endif
endfor

set backup
set backupcopy=yes
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

call plug#begin()
    " Base plugins {
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        Plug 'dense-analysis/ale'
    " }

    " Bars, tabs, etc {
        Plug 'itchyny/lightline.vim'
        Plug 'maximbaz/lightline-ale'
        Plug 'halkn/lightline-lsp'
        Plug 'preservim/nerdtree'
        Plug 'gcmt/taboo.vim'
        Plug 'preservim/tagbar'
        Plug 'godlygeek/tabular'
    " }
    
    " Autocomplete, format, etc {
        Plug 'ctrlpvim/ctrlp.vim'
        Plug 'alvan/vim-closetag'
        Plug 'Raimondi/delimitMate'
        Plug 'tpope/vim-commentary'
    " }

    " Language support {
        Plug 'OmniSharp/omnisharp-vim'
        Plug 'pangloss/vim-javascript'
        Plug 'leafgarland/typescript-vim'
        Plug 'quramy/tsuquyomi'
        Plug 'davidhalter/jedi-vim'
        Plug 'Vimjas/vim-python-pep8-indent'
        Plug 'vim-perl/vim-perl', { 'for': 'perl' }
        Plug 'preservim/vim-markdown'
        Plug 'kelwin/vim-smali'
        Plug 'pprovost/vim-ps1'
        Plug 'bfrg/vim-cpp-modern'
    " }
    
    " Appearance {
        Plug 'joshdick/onedark.vim'
    " }

    " Debug {
        Plug 'puremourning/vimspector'
    " }
call plug#end()

colorscheme onedark

let g:Makeprg = ''
function! g:Makeprg(makeprg)
    let g:Makeprg = a:makeprg
    let &makeprg = a:makeprg
endfunction

function! s:makeprg()
    if g:Makeprg != ''
        let &makeprg = g:Makeprg
    elseif &filetype == 'cs'
        let &makeprg = 'dotnet run'
    elseif &filetype == 'c' || &filetype == 'h' || &filetype == 'cpp'
        let &makeprg = 'make'
        let g:ale_enabled = 0
    elseif &filetype == 'python'
        let &makeprg = 'python3 ''' . expand('%p') ''''
    elseif &filetype == 'html' || &filetype == 'css'
        let &makeprg = 'bash ~/live-server.sh ''' . expand('%:p:h') . ''''
    elseif &filetype == 'ps1'
        let g:ale_enabled = 0
    endif
endfunction

function! OpenTerminal(termcmd)
    execute 'horizontal terminal ++close ++kill=hup' a:termcmd
    wincmd J
    resize 12
endfunction

autocmd BufNewFile,BufRead * call s:makeprg()
autocmd VimEnter,TabNew * :NERDTree | :wincmd H | :vertical resize 32 | :wincmd w

autocmd BufRead *.md setlocal conceallevel=2

if executable('perlnavigator')
    autocmd User lsp_setup call lsp#register_server({
    \   'name': 'perlnavigator',
    \   'cmd': ['perlnavigator', '--stdio'],
    \   'env': {
    \       'PERL5LIB': getcwd() . '/lib'
    \   },
    \   'allowlist': ['perl'],
    \ })
endif

if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
    \   'name': 'clangd',
    \   'cmd': ['clangd'],
    \   'allowlist': ['c']
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
    autocmd!

    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

autocmd QuitPre * call <sid>TermForceCloseAll()
function! s:TermForceCloseAll() abort
    let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    for t in term_bufs
        execute 'bd! ' t
    endfor
endfunction

augroup ColorschemePreferences
    autocmd!
    autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE

    autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
    autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
    autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

augroup OmniSharpIntegrations
    autocmd!
    autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END

let s:using_snippets = 0

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

let g:ale_linters = {
\   'cs': ['OmniSharp'],
\   'python': ['all'],
\   'c': ['clangd']
\ }

let g:ale_fixers = {
\   'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clangd']
\ }

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0

let g:OmniSharp_highlighting = 3
let g:OmniSharp_server_use_net6 = 1

let g:taboo_tab_format = " %N %f %m "
let g:taboo_modified_tab_flag = '+'

let g:vim_markdown_conceal=1 
" \         ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],

let g:lightline = {
\   'colorscheme': 'onedark',
\   'active': {
\       'right': [
\         ['lsp_errors', 'lsp_warnings', 'lsp_ok'],
\         ['lineinfo'], ['percent'],
\         ['fileformat', 'fileencoding', 'filetype']
\       ]
\   },
\   'inactive': {
\       'right': []
\   },
\   'component_expand': {
\       'linter_checking': 'lightline#ale#checking',
\       'linter_infos': 'lightline#ale#infos',
\       'linter_warnings': 'lightline#ale#warnings',
\       'linter_errors': 'lightline#ale#errors',
\       'linter_ok': 'lightline#ale#ok',
\       'lsp_warnings': 'lightline_lsp#warnings',
\       'lsp_errors': 'lightline_lsp#errors',
\       'lsp_ok': 'lightline_lsp#ok'
\   },
\   'component_type': {
\       'linter_checking': 'right',
\       'linter_infos': 'right',
\       'linter_warnings': 'warning',
\       'linter_errors': 'error',
\       'linter_ok': 'right',
\       'lsp_warnings': 'warning',
\       'lsp_errors': 'error',
\       'lsp_ok': 'right'
\   }
\ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

let g:OmniSharp_popup_position = 'peek'

let g:OmniSharp_popup_options = {
\   'highlight': 'Normal',
\   'padding': [0],
\   'border': [1],
\   'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\   'borderhighlight': ['ModeMsg']
\ }

let g:OmniSharp_popup_mappings = {
\   'sigNext': '<C-n>',
\   'sigPrev': '<C-p>',
\   'pageDown': ['<C-f>', '<PageDown>'],
\   'pageUp': ['<C-b>', '<PageUp>']
\ }

if s:using_snippets
    let g:OmniSharp_want_snippet = 1
endif

let g:OmniSharp_highlight_groups = {
\   'ExcludedCode': 'NonText'
\ }

call system('touch ~/.vim/trusted.txt')

let trusted_dirs = readfile(expand('~/.vim/trusted.txt'))
let local_vimrc = getcwd() . '/.vimrc'

if filereadable(local_vimrc) && ($TRUSTED || index(trusted_dirs, getcwd()) >= 0)
    execute 'source' local_vimrc
endif

command Trust call system('echo $PWD >> ~/.vim/trusted.txt')
