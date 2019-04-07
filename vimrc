set nocompatible
" 设置编码
set encoding=utf-8
set fileencodings=utf-8,gb18030,gbk,ucs-bom,cp936
set termencoding=utf-8
" 设置Tab键的宽度{{{
set autoindent
set smartindent
set tabstop=4 " 统一缩进为4
set shiftwidth=4 "自动缩进长度
set expandtab " Tab转空格
set softtabstop=4
"}}}
" set nowrap "不自动折行
set mouse=a
" set nu
set showcmd
" 设置备份，自动保存等{{{
"set nobackup
"set nowritebackup
set autowrite
set undofile
set swapfile
set backup
set undodir=~/.vim_temp/
set directory=~/.vim_temp/
set backupdir=~/.vim_temp/
"}}}
set cursorcolumn
set cursorline

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
set updatetime=700

" 设置gitgutter颜色{{{
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn ctermbg=0
"}}}
" 设置缩进参考线颜色{{{
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
"}}}
" VimCompletesMe设置{{{
" 不指定omni,使vcm自动尝试字典补全等
" autocmd FileType python let b:vcm_tab_complete = 'omni'
autocmd FileType vim let b:vcm_tab_complete = 'vim'
au FileType python setlocal complete+=k~/.vim/words/python.txt
"}}}
" 处理预览窗口{{{
"set completeopt-=preview
autocmd CompleteDone * pclose
set previewheight=9
au BufEnter ?* call PreviewHeightWorkAround()
func PreviewHeightWorkAround()
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
" " 隐藏warning,error{{{
let g:airline#extensions#default#section_truncate_width = {
    \ 'warning': 80,
    \ 'error': 80,
    \ 'x': 80,
    \ 'y': 80}
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
map <C-n> :NERDTreeToggle<CR>
" autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"}}}
"Quickly Run{{{
let mapleader="~"
map <leader>r :call RunPro()<CR>
imap <leader>r <Esc>:call RunPro()<CR>
func! RunPro()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!termux-open-url %{getcwd()}/%"
    elseif &filetype == 'go'
"       exec "!go build %<"
        exec "!time go run %"
    endif
endfunc
"}}}
" ALE设置{{{
" let g:ale_open_list = 1
" let g:ale_list_window_size = 3
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" let g:ale_loclist_msg_format = '%s'
" let g:ale_echo_msg_format = '%s'
let g:ale_linters = {
\   'python': ['yapf', 'pyflakes', 'pylint'],
\}
let g:ale_fixers = {
\   'python': ['autopep8', 'yapf', 'isort'],
\}
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
"}}}