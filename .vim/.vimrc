" Settings {{{
set ts=2
set shiftwidth=2
set expandtab
set ai
set t_Co=256
set hlsearch
set hidden
set nowrap
set nocp
set ruler
set colorcolumn=81
set relativenumber
set dir=~/.vim/tmp
exe 'set t_kB=' . nr2char(27) . '[Z'
set vb t_vb=

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" gvim fonts
if has("gui_running")
  set gfn=ProFont:h9
  set noantialias
else
endif

colorscheme wombat256

syntax on
filetype plugin on
" }}}

" Mappings {{{

let mapleader = "\\"
let maplocalleader = "\\"

nnoremap <F10> :set invpaste paste?<CR>
imap <F10> <C-O><F10>
set pastetoggle=<F10>
map <F8> :!ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++
map <F12> :TlistToggle<CR>
map <F11> :NERDTreeToggle<CR>
map <F2> :set syn=
map <F3> "yyiw:grep -r <C-R>y *<CR>
map <F4> :vs<CR>:vs<CR><F11><C-W>l<C-W>84\|<C-W>l<C-W>84\|<C-W>l
map <F5> :make -j4<CR>
map <F6> :!redo deploy<CR>

map <A-n>n :tnext<CR>
map <A-p>p :tprev<CR>
map <C-n> :cn<CR>
map <C-p> :cN<CR>
map <Leader>a :%s/\ at\ /\r\ at\ /g<CR>

map <Leader>y :Lodgeit<CR>
map <Leader>e ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(&filetype)<CR>
vmap <Leader>fx !xmllint --format -<CR>
vmap <Leader>fj !jade -o "{ prettyprint: true }"<CR>

map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %

nnoremap x "_x
nnoremap X "_X

nnoremap <ESC> :noh<CR><ESC>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" }}}

" Plugin Options {{{

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!

let g:SuperTabDefaultCompletionType = "context"

let g:clang_complete_copen = 1
let g:clang_snippets = 1

" }}}

" Autocommands {{{
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent
au BufRead,BufNewFile *.c,*.cpp,*.h set cino=(0
au BufRead,BufNewFile *.clay set syn=clay
au BufRead,BufNewFile *.clay set syn=clay
au BufRead,BufNewFile *.clay set syntax=clay
au BufRead,BufNewFile *.clj set syntax=clojure
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.do set syn=sh
au BufRead,BufNewFile *.galaxy set syn=galaxy
au BufRead,BufNewFile *.glsl set syntax=glsl
au BufRead,BufNewFile *.gnu set syn=gnuplot
au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.java set sw=4
au BufRead,BufNewFile *.java set ts=4
au BufRead,BufNewFile *.json set ft=json
au BufRead,BufNewFile *.material set syn=ogre3d_material
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=pdc
au BufRead,BufNewFile *.mirah set syn=mirah
au BufRead,BufNewFile *.moon set syn=moon
au BufRead,BufNewFile *.rkt set syn=racket
au BufRead,BufNewFile *.rs set syn=rust
au BufRead,BufNewFile *.scala set syn=scala
au BufRead,BufNewFile *.swig set syn=swig
au BufRead,BufNewFile *.thrift set syn=thrift
au BufRead,BufNewFile *.xsl let g:xml_syntax_folding = 1
au BufRead,BufNewFile *.xsl set foldmethod=syntax
au BufRead,BufNewFile *.xsl set syn=xml
au BufRead,BufNewFile *.yaml set syn=yaml
au BufRead,BufNewFile *.yml set syn=yaml
au BufRead,BufNewFile *.y set syn=bnf
au BufRead,BufNewFile *.ly set syn=bn
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile wscript set syn=python
" }}}

function! PlaySound()
" uncomment to annoy coworkers
" silent! exec '!afplay ~/audio/typewriter_keystroke.wav &'
endfunction
autocmd CursorMovedI * call PlaySound()

" Tabular bindings
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>: :Tabularize /:\zs<CR>
  vmap <Leader>: :Tabularize /:\zs<CR>
endif

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

