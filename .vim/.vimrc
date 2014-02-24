" vim: foldmethod=marker:

set modeline
set modelines=1

set nocp

let g:gitgutter_enabled = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1

syntax on
filetype plugin indent on

call pathogen#infect()

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
  colorscheme wombat
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
imap <C-d>j <C-k>l*
" approx equal ≅
imap <C-d>a <C-k>?=
" subset ⊆
imap <C-d>s <C-k>(_
" element of ∈
imap <C-d>e <C-k>(-
" right arrow →
imap <C-d>l <C-k>->
" left arrow ←
imap <C-d>h <C-k><-
" compose ∘
imap <C-d>o <C-k>Ob

nnoremap <F10> :set invpaste paste?<CR>
imap <F10> <C-O><F10>
set pastetoggle=<F10>
nmap <F9> :TagbarToggle<CR>
map <F8> :make tags<CR>
map <F12> :TlistToggle<CR>
map <F11> :NERDTreeToggle<CR>
map <F2> :exec ":!hasktags -x -c --ignore src"<CR><CR>
map <F3> :silent make \| redraw! \| cc<CR>
map <F4> :call RCmd("make")<CR>
map <F5> :make<CR>
map <F6> :call RCmd("npm test")<CR>
map <F7> :call RCmd("make deploy")<CR>

map <C-j> kddpkJ
map <Leader>] :tnext<CR>
map <Leader>[ :tprev<CR>
map <S-l> :cn<CR>
map <S-h> :cN<CR>
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
map <Leader>a :%s/\ at\ /\r\ at\ /g<CR>

" Replace whitespace before and after commas
map <Leader>, :%s/\s\+,/,/g<CR>:%s/,\s\+/,/g<CR>

map <Leader>y :Lodgeit<CR>
nmap <Leader>C :ccl<CR>
nmap <Leader>r ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(&filetype)<CR>
map <Leader><Leader>x :silent %!xmllint --encode UTF-8 --format -<CR>
vmap <Leader><Leader>j !jade -p % -o "{ prettyprint: true }"<CR>

"map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %
cmap c! call RCmd("")<Left><Left>
cmap g! call RCmd("git --no-pager ")<Left><Left>
cmap t! Tabularize /
cmap <Leader>c call RCmd("./create_component  default")<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
cmap <Leader>j call RCmd("./create_component  view")<Left><Left><Left><Left><Left><Left><Left>

cmap Agg Ag -G $<Left>
cmap Agc Ag -G coffee$ ""<Left>
cmap Agh Ag -G hs$ ""<Left>
cmap Agj Ag -G jade$ ""<Left>
cmap Agk Ag -G js$ ""<Left>
cmap Agl Ag -G less$ ""<Left>

nnoremap x "_x
nnoremap X "_X

" Tabular bindings
nmap <Leader>== :Tabularize /=<CR>
vmap <Leader>== :Tabularize /=<CR>
nmap <Leader>=, :Tabularize /,<CR>
vmap <Leader>=, :Tabularize /,<CR>
cmap <Leader>t Tabularize /
nmap <Leader>=<Bar> :Tabularize /<Bar><CR>
vmap <Leader>=<Bar> :Tabularize /<Bar><CR>
nmap <Leader>=:: :Tabularize /::<CR>
vmap <Leader>=:: :Tabularize /::<CR>
nmap <Leader>=: :Tabularize /:\zs<CR>
vmap <Leader>=: :Tabularize /:\zs<CR>

" }}}

" Plugin Options {{{

" neosnippet key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/snippets/snippets'

let g:Powerline_symbols = 'fancy'

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!

let g:SuperTabDefaultCompletionType = "context"

let g:clang_complete_copen = 1
let g:clang_snippets = 1
let g:clang_use_library = 1

let g:syntastic_javascript_checker = 'jshint'
let g:syntastic_haskell_checkers = []

let g:EasyMotion_leader_key = '<Leader>'

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|\.hg\|\.svn\|\.redo\|dist\|cabal-dev'
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
au BufRead,BufNewFile *.ts set syn=typescript
au BufRead,BufNewFile *.ebnf set syn=ebnf
au BufRead,BufNewFile *.bnf set syn=bnf
au BufRead,BufNewFile *.ts set filetype=typescript
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

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

highlight clear SignColumn " fix gitgutter color
