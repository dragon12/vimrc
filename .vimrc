set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'altercation/vim-colors-solarized'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'ivanov/vim-ipython'

" web browser
Bundle 'mjbrownie/browser.vim.git'

" non github repos
" ...

filetype plugin indent on     " required!

" 
"
" my settings
"
"
let mapleader=","
syn on 
set number
"set autochdir "auto change the cwd to the file's dir

" tab-related stuff
set tabstop=4
set shiftwidth=4
set expandtab

set term=xterm-256color

" more subtle popup colors 
if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold    
endif

" reopen file at last position
" Uncomment the following to have Vim jump to the last position when                                                       
" " reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set wildmode=longest,list,full
set wildmenu

set hlsearch " search highlighting

"map ctrl-<> to ctrl-W<>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

"map alt-j/k to scrolling the other window in a 2-window split
nmap <Esc>j <c-w>l<c-f><c-w>p
nmap <Esc>k <c-w>l<c-b><c-w>p
"nmap <Esc>f <c-w>l<c-f><c-w>p
"nmap <Esc>b <c-w>l<c-b><c-w>p

"map jj to exit insert mode
:imap jj <Esc>

"this function maps Alt-down and Alt-Up to move other window
"" put in your ~/.vimrc
fun! ScrollOtherWindow(dir)
    if a:dir == "down"
        let move = "\<C-E>"
    elseif a:dir == "up"
        let move = "\<C-Y>"
    endif
    exec "normal \<C-W>p" . move . "\<C-W>p"
endfun

"nmap <silent> <Esc>j :call ScrollOtherWindow("down")<CR>
"nmap <silent> <Esc>k :call ScrollOtherWindow("up")<CR>


" Turn on and off the lint error pane
function! ToggleErrors()
    PymodeLintAuto
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        PymodeLint
    endif
endfunction

" better start/session options
Bundle 'mhinz/vim-startify'
let g:startify_session_dir = '~/.vim_sessions'
let g:startify_session_persistence = 1 "auto-save sessions before exiting (doesn't save buffers)
let g:startify_restore_position = 1

" completion etc for python
Bundle 'davidhalter/jedi-vim'
let g:jedi#goto_assignments_command = "<F2>"

" tagbar for opening python taglist window
Bundle 'majutsushi/tagbar'
let g:tagbar_left = 1
nnoremap <silent> <leader>l :TagbarOpenAutoClose<CR>

" running unit tests
Bundle 'nvie/vim-pyunit.git'
let PyUnitCmd = 'nosetests -vv --exe --with-machineout'
"let PyUnitCmd = 'nosetests -vv --exe'

" fast file-search using <leader>t
Bundle 'git://git.wincent.com/command-t.git'
"
" End my settings
"

syn on
augroup vimrc_autocmds
	autocmd!
	" highlight characters past column 120
	autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
	autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    autocmd FileType python noremap <F3> :<C-u>call ToggleErrors()<CR>
    autocmd FileType python IPython
augroup END

augroup python_autocmds
augroup END


" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2


" NerdTree
map <F4> :NERDTreeToggle<CR>

"Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator
" modes)
" ]]            Jump on next class or function (normal, visual, operator
" modes)
" [M            Jump on previous class or method (normal, visual, operator
" modes)
" ]M            Jump on next class or method (normal, visual, operator modes)


let g:pymode_rope = 0
"
" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore = "W391"  " Ignore blank line at end of file

" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_unmodified = 1
"
" Support virtualenv
let g:pymode_virtualenv = 1
"
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
"
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" Don't autofold code
let g:pymode_folding = 0


