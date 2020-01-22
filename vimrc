set nocompatible
source $VIMRUNTIME/defaults.vim
syntax on " Fix csv plugin error
" 设置编码
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,ucs-bom,cp936
set termencoding=utf-8
set ffs=unix,dos
" 设置Tab键的宽度{{{
set autoindent
set smartindent
set expandtab " Tab转空格
set tabstop=4 " 统一缩进为4
set shiftwidth=4 "自动缩进长度
set softtabstop=4
func! SetTab()
    setlocal sw=2
    setlocal ts=2
    setlocal sts=2
endfunc
autocmd FileType javascript,html,htmldjango,css,xml,scss,vue call SetTab()
"}}}
func! JSFold()
    setlocal foldmethod=syntax
    setlocal foldenable
    setlocal foldlevel=2
endfunc
autocmd FileType vue call JSFold()
autocmd FileType kivy setlocal commentstring=#\ %s
set termguicolors
" set nowrap "不自动折行
set mouse=a
" set nu
set showcmd
" 设置备份，自动保存等{{{
"set nobackup
"set nowritebackup
set autowrite
set autoread
set undofile
set swapfile
set backup
set undodir=$HOME/.vim_temp/
set directory=$HOME/.vim_temp/
set backupdir=$HOME/.vim_temp/
"}}}
set cursorcolumn
set cursorline
let g:indentLine_concealcursor=""
let g:indentLine_conceallevel=1

set foldmethod=marker
" 设置手动折叠保存{{{
" set foldenable
" au BufWinLeave * if argc() != 0 |silent mkview|endif
" au BufWinEnter * silent loadview
" autocmd BufRead *
"    \   if expand('%') != '' && &buftype !~ 'nofile'
"    \|      silent loadview
"    \|  endif
"}}}
colorscheme NeoSolarized
set background=dark
set updatetime=700
"Keyboard Shortcuts{{{
" for i in range(97,122)
"   let c = nr2char(i)
"   exec "map \e".c." <M-".c.">"
"   exec "map! \e".c." <M-".c.">"
" endfor
if winwidth('%') > 60
    set nu
    exec 'pa undotree'
    if has("gui_running")
        map <F5> :call RunProWin()<CR>
        imap <F5> <Esc>:call RunProWin()<CR>
        set lines=25 columns=86
    else
        map <F5> :call RunProLinux()<CR>
        imap <F5> <Esc>:call RunProLinux()<CR>
    endif
    imap <C-v> <Esc>"+pa
    map <C-s> :w<CR>
    imap <C-s> <Esc>:w<CR>
    imap <C-z> <ESC><C-z>
    let mapleader=","
    map <leader>v :e $HOME/.vim/vimrc<CR>
    map <leader>s :source $HOME/.vim/vimrc<CR>
    map <leader>a :let g:ale_fix_on_save=1<CR>
    map <leader>f :silent !autopep8 -i % && isort %<CR>
else
    let mapleader="~"
    imap <leader>'' ``<Left>
    imap <leader>'p ```python<CR><CR>```<Up>
    map <leader>r :call RunProLinux()<CR>
    imap <leader>r <Esc>:call RunProLinux()<CR>
    map <leader>f :w<CR>
endif
imap jj <Esc>
map <space>= mLggVG='L
map <space>s :w<CR>
"}}}
"GUI menu ZH fix{{{
if has("gui_running")
    set langmenu=zh_CN.UTF-8          "设置菜单语言
    source $VIMRUNTIME/delmenu.vim    "导入删除菜单脚本，删除乱码的菜单
    source $VIMRUNTIME/menu.vim       "导入正常的菜单脚本
    language messages zh_CN.utf-8     "设置提示信息语言
endif"}}}
" 设置gitgutter颜色{{{
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn ctermbg=0
"}}}
" 设置缩进参考线颜色{{{
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
"}}}
let g:pymode_rope_completion = 0
" 处理预览窗口{{{
"set completeopt-=preview
autocmd InsertLeave * pclose
set previewheight=9
au BufEnter ?* call PreviewHeightWorkAround()
func! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc
"}}}
" Vim-airline设置{{{
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
" " function! AirlineInit()
" "     let g:airline#extensions#branch#enabled = 1
" "     let g:airline_section_b = airline#section#create(['branch'])
" " endfunction
" " autocmd User AirlineAfterInit call AirlineInit()
" let g:airline_section_x = ''
" let g:airline_section_y = ''
let g:airline_section_z = '%2l/%L☰%2v'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"}}}
" 隐藏warning,error{{{
let g:airline#extensions#default#section_truncate_width = {
            \ 'warning': 60,
            \ 'error': 60,
            \ 'x': 60,
            \ 'y': 60}
"}}}
" 设置Airline模式别名{{{
let g:airline_mode_map = {
            \ 'c': 'C',
            \ 'n': 'N',
            \ 'V': 'V',
            \ 'i':'I'}
"}}}
" 回到上次退出位置{{{
"au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\""
" 简单版本
au BufReadPost * exe "normal! g`\""
"}}}
" NERDTree快捷键，自动打开{{{
map <F2> :NERDTreeToggle<CR>
" autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"}}}
"Quickly Run{{{
func! RunProWin()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %< && %<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< && %<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        exec "!bash %"
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'go'
        exec "!go run %"
    endif
endfunc

func! RunProLinux()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %< && time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< && time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc

"}}}
" ALE设置{{{
let g:ale_lint_on_text_changed=0
let g:ale_linters = {
            \   'python': ['flake8', 'pyflakes', 'pylint'],
            \}
let g:ale_fixers = {
            \   'python': ['autopep8', 'yapf', 'isort'],
            \}
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 0
" ~~在编辑其他人的项目时，手动关闭ALE~~
" 不如手动开启
let g:ale_fix_on_save = 0
if has("gui_running")
    let g:ale_set_signs=0
    let g:ale_set_balloons=1
endif
"}}}
" html自动js,css补全{{{
au FileType html setlocal omnifunc=MyHTMLComplete
function! MyHTMLComplete(findstart, base)
    for id in synstack(line('.'), col('.'))
        let lang_type=synIDattr(id, 'name')
        if lang_type =~? 'javascript'
            return javascriptcomplete#CompleteJS(a:findstart,a:base)
            break
        elseif lang_type =~? 'css'
            return csscomplete#CompleteCSS(a:findstart,a:base)
            break
        elseif lang_type =~? 'html'
            return htmlcomplete#CompleteTags(a:findstart,a:base)
            break
        endif
    endfor
endfunction"}}}
"UltiSnips Setup{{{
if has("python3")
    exec 'pa vim-snippets'
    exec 'pa ultisnips'
    let g:UltiSnipsExpandTrigger="<leader>q"
    let g:UltiSnipsJumpForwardTrigger="<c-p>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
    " exec 'pa completor.vim'
    "" Tab behavior Setup{{{
    "" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
    "" dictionary, source files, and completor to find matching words to complete.

    "" Note: usual completion is on <C-n> but more trouble to press all the time.
    "" Never type the same word twice and maybe learn a new spellings!
    "" Use the Linux dictionary when spelling is in doubt.
    "function! Tab_Or_Complete() abort
    "  " If completor is already open the `tab` cycles through suggested completions.
    "  if pumvisible()
    "    return "\<C-N>"
    "  " If completor is not open and we are in the middle of typing a word then
    "  " `tab` opens completor menu.
    "  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    "    return "\<C-R>=completor#do('complete')\<CR>"
    "  else
    "    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    "    " action.
    "    return "\<Tab>"
    "  endif
    "endfunction

    "" Use `tab` key to select completions.  Default is arrow keys.
    "inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    "" Use tab to trigger auto completion.  Default suggests completions as you type.
    "" let g:completor_auto_trigger = 0
    "inoremap <expr> <Tab> Tab_Or_Complete()
    ""}}}
else
    exec 'pa VimCompletesMe'
endif"}}}
