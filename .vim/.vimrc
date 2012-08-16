set nocp

call pathogen#infect()

syntax on
filetype plugin indent on

" Settings {{{
set ts=2
set shiftwidth=2
set expandtab
set ai
set hlsearch
set hidden
set nowrap
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
  set gfn=Monaco:h12
  set antialias
else
  set t_Co=256
  set clipboard=unnamed
  colorscheme wombat256
endif

" }}}

" Mappings {{{

let mapleader = "\\"
let maplocalleader = "\\"

" digraphs

" lambda λ
imap <C-j> <C-k>l*

" right arrow →
imap <C-l> <C-k>->

" left arrow ←
imap <C-g> <C-k><-

" left arrow ←
imap <C-o> <C-k>Ob

nnoremap <F10> :set invpaste paste?<CR>
imap <F10> <C-O><F10>
set pastetoggle=<F10>
nmap <F9> :TagbarToggle<CR>
map <F8> :make tags<CR>
map <F12> :TlistToggle<CR>
map <F11> :NERDTreeToggle<CR>
map <F3> "yyiw:grep -r <C-R>y *<CR>
map <F3> :silent make \| redraw! \| cc<CR>
map <F4> :call RCmd("make")<CR>
map <F6> :make<CR>
map <F6> :!make deploy<CR>

map <C-S-j> kddpkJ
map <Leader>] :tnext<CR>
map <Leader>[ :tprev<CR>
map <S-l> :cn<CR>
map <S-h> :cN<CR>
map <Leader>a :%s/\ at\ /\r\ at\ /g<CR>

map <Leader>y :Lodgeit<CR>
nmap <Leader>r ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(&filetype)<CR>
map <Leader><Leader>x :silent %!xmllint --encode UTF-8 --format -<CR>
vmap <Leader><Leader>j !jade -p % -o "{ prettyprint: true }"<CR>

map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %
cmap c! call RCmd("")<Left><Left>
cmap g! call GRCmd("")<Left><Left>

cmap wg w<CR>:!git commit % -m ""<Left>
cmap wag wa<CR>:!git commit -am ""<Left>

nnoremap x "_x
nnoremap X "_X

" Tabular bindings
if exists(":Tabularize")
  nmap <Leader>== :Tabularize /=<CR>
  vmap <Leader>== :Tabularize /=<CR>
  nmap <Leader>=, :Tabularize /,<CR>
  vmap <Leader>=, :Tabularize /,<CR>
  nmap <Leader>=<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>=<Bar> :Tabularize /<Bar><CR>
  nmap <Leader>=:: :Tabularize /::<CR>
  vmap <Leader>=:: :Tabularize /::<CR>
  nmap <Leader>=: :Tabularize /:\zs<CR>
  vmap <Leader>=: :Tabularize /:\zs<CR>
endif

" }}}

" Plugin Options {{{

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!

let g:SuperTabDefaultCompletionType = "context"

let g:clang_complete_copen = 1
let g:clang_snippets = 1
let g:clang_use_library = 1

set wildignore+=*/.git/*,*/.hg/*,/.svn/*,*/.redo/*

let g:syntastic_javascript_checker = 'jshint'

let g:EasyMotion_leader_key = '<Leader>'

let g:ctrlp_custom_ignore = 'node_modules$'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_switch_buffer=0

" }}}

" Autocommands {{{
au BufRead,BufNewFile *.c,*.cpp,*.h set cindent
au BufRead,BufNewFile *.c,*.cpp,*.h set cino=(0
au BufRead,BufNewFile *.clay set syn=clay
au BufRead,BufNewFile *.clj set syntax=clojure
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.do set syn=sh
au BufRead,BufNewFile *.galaxy set syn=galaxy
au BufRead,BufNewFile *.glsl set syntax=glsl
au BufRead,BufNewFile *.gnu set syn=gnuplot
au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.hx set syn=haxe
au BufRead,BufNewFile *.java set sw=4
au BufRead,BufNewFile *.java set ts=4
au BufRead,BufNewFile *.json set ft=json
au BufRead,BufNewFile *.less set syn=less
au BufRead,BufNewFile *.ll set syn=llvm
au BufRead,BufNewFile *.ly set syn=bn
au BufRead,BufNewFile *.material set syn=ogre3d_material
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=pdc
au BufRead,BufNewFile *.mirah set syn=mirah
au BufRead,BufNewFile *.moon set syn=moon
au BufRead,BufNewFile *.rkt set syn=racket
au BufRead,BufNewFile *.rs set syn=rust
au BufRead,BufNewFile *.scala set syn=scala
au BufRead,BufNewFile *.swig set syn=swig
au BufRead,BufNewFile *.td set syn=tablegen
au BufRead,BufNewFile *.thrift set syn=thrift
au BufRead,BufNewFile *.x set syn=alex
au BufRead,BufNewFile *.xsl let g:xml_syntax_folding = 1
au BufRead,BufNewFile *.xsl set foldmethod=syntax
au BufRead,BufNewFile *.xsl set syn=xml
au BufRead,BufNewFile *.y set syn=bnf
au BufRead,BufNewFile *.y.pp set syn=happy
au BufRead,BufNewFile *.yaml set syn=yaml
au BufRead,BufNewFile *.yml set syn=yaml
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile wscript set syn=python
" }}}

function! PlaySound()
" uncomment to annoy coworkers
" silent! exec '!afplay ~/audio/typewriter_keystroke.wav &'
endfunction
autocmd CursorMovedI * call PlaySound()

function! RCmd(cmd)
  :silent! exe '!echo "cd ' . getcwd() . ' && ' . a:cmd . '" > /tmp/cmds'
  :redraw!
endfunction

function! GRCmd(cmd)
  :call RCmd("git --no-pager " . a:cmd)
endfunction
