set nocompatible
source $VIMRUNTIME/defaults.vim
syntax on " Fix csv plugin error
" set nowrap "不自动折行
set mouse=a
set showcmd
set cursorcolumn
set cursorline
set foldmethod=marker
set updatetime=700
set nu
let g:indentLine_concealcursor=""
let g:indentLine_conceallevel=1

autocmd InsertLeave * pclose
autocmd FileType kivy setlocal commentstring=#\ %s
" 设置编码{{{
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,ucs-bom,cp936
set termencoding=utf-8
set ffs=unix,dos
"}}}
"GUI menu ZH fix{{{
if has("gui_running")
    set langmenu=zh_CN.UTF-8          "设置菜单语言
    source $VIMRUNTIME/delmenu.vim    "导入删除菜单脚本，删除乱码的菜单
    source $VIMRUNTIME/menu.vim       "导入正常的菜单脚本
    language messages zh_CN.utf-8     "设置提示信息语言
endif
"}}}
" 设置Tab键的宽度{{{
set autoindent
set smartindent
set expandtab " Tab转空格
setlocal tabstop=4 " 统一缩进为4
setlocal shiftwidth=4 "自动缩进长度
setlocal softtabstop=4
func! SetTab()
    setlocal sw=2
    setlocal ts=2
    setlocal sts=2
endfunc
autocmd FileType javascript,html,htmldjango,css,xml,scss,vue call SetTab()
"}}}
" Vue fold{{{
func! JSFold()
    setlocal foldmethod=syntax
    setlocal foldenable
    setlocal foldlevel=2
endfunc
autocmd FileType vue call JSFold()
"}}}
" Enable true color 启用终端24位色{{{
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark " Terminal Compatible
let g:solarized_italics=0  " 斜体中文很难受
colorscheme solarized8
"}}}
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
" Shortcut keys{{{
map <F5> :call RunProLinux()<CR>
imap <F5> <Esc>:call RunProLinux()<CR>
let mapleader=";"
map <leader>s :w<CR>
imap <leader>s <Esc>:w<CR>
imap <leader><leader> <Esc>
vmap <leader><leader> <Esc>
map <space>v :e $HOME/.vim/vimrc<CR>
map <space>s :source $HOME/.vim/vimrc<CR>
map <space>= mLggVG='L
map <space>f :PymodeLintAuto<CR>
"}}}
" 设置缩进参考线颜色{{{
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
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
    elseif &filetype == 'javascript'
        exec "!time node %"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc
"}}}
" ALE设置{{{
let g:ale_lint_on_text_changed=0
let g:ale_linters = {
            \   'python': ['flake8', 'pyflakes', 'pylint'],
            \   'javascript': ['eslint'],
            \}
let g:ale_fixers = {
            \   'python': ['autopep8', 'yapf', 'isort'],
            \   'javascript': ['prettier', 'eslint'],
            \   'vue': ['prettier', 'eslint'],
            \}
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 0
" ~~在编辑其他人的项目时，手动关闭ALE~~
" 不如手动开启
let g:ale_fix_on_save = 0
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
let g:pymode_rope_completion = 0
let g:UltiSnipsExpandTrigger="<leader>q"
let g:UltiSnipsJumpForwardTrigger="<c-p>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
