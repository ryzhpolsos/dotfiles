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
noremap <C-`> :call OpenTerminal('cmd', v:true)<CR>
noremap <F2> :call OpenTerminal('cmd', v:true)<CR>
noremap <F5> :call OpenTerminal(&makeprg, v:false)<CR>

noremap <Up> :echo "Use k"<CR>
noremap <Down> :echo "Use j"<CR>
noremap <Left> :echo "Use h"<CR>
noremap <Right> :echo "Use l"<CR>
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

set backup
set backupdir=~/vimfiles/backup//
set directory=~/vimfiles/swap//
set undodir=$~/vimfiles/undo//

let g:OmniSharp_highlighting = 3

call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'
    Plug 'joshdick/onedark.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
    Plug 'nickspoons/vim-sharpenup'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'quramy/tsuquyomi'
    Plug 'kelwin/vim-smali'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'tpope/vim-commentary'
    Plug 'Vimjas/vim-python-pep8-indent'
    Plug 'davidhalter/jedi-vim'
    " Plug 'sheerun/vim-polyglot'
    Plug 'Raimondi/delimitMate'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'alvan/vim-closetag'
    Plug 'pprovost/vim-ps1'
    Plug 'vimsence/vimsence'
    Plug 'xavierd/clang_complete'
    Plug 'bfrg/vim-cpp-modern'
    " Plug 'vim-scripts/Windows-PowerShell-Syntax-Plugin'
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
        " let &makeprg = 'python3 ''' . expand('%p') ''''
    elseif &filetype == 'html' || &filetype == 'css'
        let &makeprg = 'bash ~/live-server.sh ''' . expand('%:p:h') . ''''
    elseif &filetype == 'ps1'
        let g:ale_enabled = 0
    endif
endfunction

function! OpenTerminal(termcmd, autoClose)
    let l:cmd = a:autoClose ? a:termcmd : "cmd /c " . a:termcmd . " & pause>nul"
    execute "horizontal terminal ++close ++kill=hup" l:cmd
    wincmd J
    resize 12
endfunction

autocmd BufNewFile,BufRead * call s:makeprg()
autocmd VimEnter,TabNew * :NERDTree | :wincmd H | :vertical resize 32 | :wincmd w
"autocmd User OmniSharpReady,OmniSharpProjectUpdated :OmniSharpHighlight
"autocmd BufReadPost *.cs :echo "hello"

autocmd QuitPre * call <sid>TermForceCloseAll()
function! s:TermForceCloseAll() abort
    let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    for t in term_bufs
            execute "bd! " t
    endfor
endfunction

augroup ColorschemePreferences
    autocmd!
    " These preferences clear some gruvbox background colours, allowing transparency
    autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
    " Link ALE sign highlights to similar equivalents without background colours
    autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
    autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
    autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

let s:using_snippets=0

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

let g:ale_linters = { 'cs': ['OmniSharp'], 'python': ['all'], 'c': ['gcc'] }
let g:ale_fixers = {'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace'], 'c': [] }
" }}}

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
" }}}

" Sharpenup: {{{
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :OmniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>os'

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
    autocmd!
    autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update() | :OmniSharpHighlight
augroup END
" }}}

" Lightline: {{{
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\     'right': [
\         ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\         ['lineinfo'], ['percent'],
\         ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\     ]
\ },
\ 'inactive': {
\     'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\     'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\     'linter_checking': 'lightline#ale#checking',
\     'linter_infos': 'lightline#ale#infos',
\     'linter_warnings': 'lightline#ale#warnings',
\     'linter_errors': 'lightline#ale#errors',
\     'linter_ok': 'lightline#ale#ok'
    \    },
    \ 'component_type': {
    \     'linter_checking': 'right',
    \     'linter_infos': 'right',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'right'
\    }
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
" }}}

" OmniSharp: {{{
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
    let g:OmniSharp_popup_options = {
    \ 'winblend': 30,
    \ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
    \ 'border': 'rounded'
    \}
else
    let g:OmniSharp_popup_options = {
    \ 'highlight': 'Normal',
    \ 'padding': [0],
    \ 'border': [1],
    \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
    \ 'borderhighlight': ['ModeMsg']
    \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

if s:using_snippets
    let g:OmniSharp_want_snippet = 1
endif

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" }}}

let g:vimsence_client_id = '439476230543245312'
let g:vimsence_small_text = 'Vim'
let g:vimsence_small_image = 'vim'
let g:vimsence_editing_details = 'Editing: {}'
let g:vimsence_editing_state = 'Working on: {}'
let g:vimsence_file_explorer_text = 'In NERDTree'
let g:vimsence_file_explorer_details = 'Looking for files'
" let g:vimsence_custom_icons = {}

let g:clang_library_path='C:\Program Files\LLVM\bin\libclang.dll'
