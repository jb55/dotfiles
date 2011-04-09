" Settings {{{
set ts=2
set shiftwidth=2
set expandtab
set ai
set background=dark
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

" gvim fonts
if has("gui_running")
  set gfn=Monaco:h12
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

map <Leader>n :tnext<CR>
map <Leader>p :tprev<CR>
map <C-N> :cn<CR>
map <C-P> :cN<CR>
map <Leader>y :Lodgeit<CR>
map <Leader>e ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(snippets_dir, &filetype)<CR>

map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %

nnoremap x "_x
nnoremap X "_X

" }}}

" Plugin Options {{{

" MiniBufExl {{{
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" }}}

" VimClojure {{{
let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!
" }}}

" Supertab {{{
let g:SuperTabDefaultCompletionType = "context"
" }}}

" }}}

" Autocommands {{{
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent
au BufRead,BufNewFile *.c,*.cpp,*.h set cino=(0
au BufRead,BufNewFile *.clay set syn=clay
au BufRead,BufNewFile *.clay set syntax=clay
au BufRead,BufNewFile *.clj set syntax=clojure
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.do set syn=sh
au BufRead,BufNewFile *.galaxy set syn=galaxy
au BufRead,BufNewFile *.glsl set syntax=glsl
au BufRead,BufNewFile *.gnu set syn=gnuplot
au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.json set ft=json
au BufRead,BufNewFile *.java set ts=4
au BufRead,BufNewFile *.java set sw=4
au BufRead,BufNewFile *.material set syn=ogre3d_material
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=pdc
au BufRead,BufNewFile *.rs set syn=rust
au BufRead,BufNewFile *.swig set syn=swig
au BufRead,BufNewFile *.thrift set syn=thrift
au BufRead,BufNewFile *.xsl let g:xml_syntax_folding = 1
au BufRead,BufNewFile *.xsl set foldmethod=syntax
au BufRead,BufNewFile *.xsl set syn=xml
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile wscript set syn=python
" }}}

function! PlaySound()
" silent! exec '!afplay ~/audio/typewriter_keystroke.wav &'
endfunction
autocmd CursorMovedI * call PlaySound()

" Tabular bindings

if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

function! ReloadSnippets( snippets_dir, ft )
    if strlen( a:ft ) == 0
        let filetype = "_"
    else
        let filetype = a:ft
    endif

    call ResetSnippets()
    call GetSnippets( a:snippets_dir, filetype )
endfunction

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a


function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
