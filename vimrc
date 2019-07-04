set nocompatible
source $VIMRUNTIME/defaults.vim
" 设置编码
set encoding=utf-8
set fileencodings=utf-8,gb18030,gbk,ucs-bom,cp936
set termencoding=utf-8
" 设置Tab键的宽度{{{
set autoindent
set smartindent
set expandtab " Tab转空格
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ai
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
autocmd FileType javascript,html,css,xml set ai
autocmd FileType javascript,html,css,xml set sw=2
autocmd FileType javascript,html,css,xml set ts=2
autocmd FileType javascript,html,css,xml set sts=2
" set tabstop=4 " 统一缩进为4
" set shiftwidth=4 "自动缩进长度
" set softtabstop=4
"}}}
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
let g:indentLine_conceallevel=0

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

if winwidth('%') > 60
    set nu
    exec 'pa undotree'
    map <F5> :call RunPro()<CR>
    imap <F5> <Esc>:call RunPro()<CR>
    imap <C-v> <Esc>"+pa
    map <C-S> :ALEFix<CR>
else
    let mapleader="~"
    imap <leader>'' ``<Left>
    imap <leader>'p ```python<CR><CR>```<Up>
    map <leader>r :call RunPro()<CR>
    imap <leader>r <Esc>:call RunPro()<CR>
    map <leader>f :ALEFix<CR>
endif

if has("gui_running")
    set langmenu=zh_CN.UTF-8                 "设置菜单语言
    source $VIMRUNTIME/delmenu.vim    "导入删除菜单脚本，删除乱码的菜单
    source $VIMRUNTIME/menu.vim          "导入正常的菜单脚本
    language messages zh_CN.utf-8          "设置提示信息语言
endif
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
autocmd FileType html let b:vcm_tab_complete = 'omni'
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
map <C-n> :NERDTreeToggle<CR>
" autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"}}}
"Quickly Run{{{
func! RunPro()
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
if has("python3")
    exec 'pa vim-snippets'
    exec 'pa ultisnips'
    let g:UltiSnipsExpandTrigger="<c-z>"
    let g:UltiSnipsJumpForwardTrigger="<c-p>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
endif
