" vim: foldmethod=marker:

"if 0 | endif

filetype plugin indent on

" Settings 
set modeline
set modelines=1
set nocp
set ts=2
set shiftwidth=2
set expandtab
set ai
set hlsearch
set hidden
set nowrap
set ruler
set colorcolumn=80
set t_Co=16
highlight ColorColumn ctermbg=8
set relativenumber
set dir=~/.vim/tmp
exe 'set t_kB=' . nr2char(27) . '[Z'
set vb t_vb=
syntax on

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

set clipboard+=unnamedplus

" gvim fonts
" if has("gui_running")
"   colorscheme molokai
" else
"   set t_Co=256
"   set clipboard=unnamed
"   colorscheme base16-onedark
" endif

" 

" Mappings 

"call arpeggio#map('i', '', 0, 'fd', '<Esc>')
"let g:arpeggio_timeoutlen = 100
"let mapleader = "\<SPACE>"
"let maplocalleader = "\<SPACE>"
let mapleader = "\\"
let maplocalleader = "\\"

" digraphs

nmap Q :qa<CR>

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
map <F4> :call RCmd("make")<CR>
map <F5> :make<CR>
map <F6> :call RCmd("make test")<CR>
map <F7> :call RCmd("make deploy")<CR>

nmap <Leader>nr "nyiW:call RCmd("npm repo <C-r>n")<CR>

map <C-j> kddpkJ
map <Leader>] :tnext<CR>
map <Leader>[ :tprev<CR>
map <S-l> :cn<CR>
map <S-h> :cN<CR>
map <C-n> :lnext<CR>
map <C-p> :lprev<CR>
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
map <Leader>a :%s/\ at\ /\r\ at\ /g<CR>

" Replace whitespace before and after commas
map <Leader>, :%s/\s\+,/,/g<CR>:%s/,\s\+/,/g<CR>

map <Leader>y :Lodgeit<CR>
nmap <Leader>C :ccl<CR>
nmap <Leader>vs vip:sort<CR>
nmap <Leader>xda ma:%s/\s\+$//g<CR>`a
nmap <Leader>rr :call ReloadSnippets(&filetype)<CR>
map <Leader><Leader>x :silent %!xmllint --encode UTF-8 --format -<CR>
vmap <Leader><Leader>x :!xmllint --encode UTF-8 --format -<CR>
vmap <Leader><Leader>j !jade -p % -o "{ prettyprint: true }"<CR>

"map <Leader>cr :!newclay % && ./main<CR>

cmap w!! %!sudo tee > /dev/null %

" I never use ctrl-b anyways
nmap <C-b> <C-a>

" Tabular bindings
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

" Plugin Options 

let g:SuperTabDefaultCompletionType = "context"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:haddock_browser="open"

let g:gitgutter_enabled = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1

let g:Powerline_symbols = 'fancy'

let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let g:clj_highlight_builtins=1 " Highlight Clojure's builtins
let g:clj_paren_rainbow=1      " Rainbow parentheses'!

let g:SuperTabDefaultCompletionType = "context"

let g:clang_complete_copen = 1
let g:clang_snippets = 1
let g:clang_use_library = 1

let g:syntastic_loc_list_height=3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_coffee_coffeelint_conf = '~/.coffeelintrc'
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_haskell_checkers = []
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = '~/.eslintrc'
let g:syntastic_warning_symbol='⚠'

let g:EasyMotion_leader_key = '<Leader>'

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|\.hg\|\.svn\|\.redo\|dist\|cabal-dev\|lib-cov'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_switch_buffer=0

" fix gitgutter color
highlight clear SignColumn

" Linux style C


if exists("g:loaded_linuxsty")
    finish
endif
let g:loaded_linuxsty = 1

set wildignore+=*.ko,*.mod.c,*.order,modules.builtin

augroup linuxsty
    autocmd!

    autocmd FileType c,cpp call s:LinuxConfigure()
    autocmd FileType diff setlocal ts=8
    autocmd FileType kconfig setlocal ts=8 sw=8 sts=8 noet
    autocmd FileType dts setlocal ts=8 sw=8 sts=8 noet
augroup END

function s:LinuxConfigure()
    let apply_style = 0

    if exists("g:linuxsty_patterns")
        let path = expand('%:p')
        for p in g:linuxsty_patterns
            if path =~ p
                let apply_style = 1
                break
            endif
        endfor
    else
        let apply_style = 1
    endif

    if apply_style
        call s:LinuxCodingStyle()
    endif
endfunction

command! LinuxCodingStyle call s:LinuxCodingStyle()

function! s:LinuxCodingStyle()
    call s:LinuxFormatting()
    call s:LinuxKeywords()
    call s:LinuxHighlighting()
endfunction

function s:LinuxFormatting()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
    setlocal textwidth=80
    setlocal noexpandtab

    setlocal cindent
    setlocal cinoptions=:0,l1,t0,g0,(0
endfunction

function s:LinuxKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
    syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
endfunction

function s:LinuxHighlighting()
    highlight default link LinuxError ErrorMsg

    syn match LinuxError / \+\ze\t/     " spaces before tab
    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more

    " Highlight trailing whitespace, unless we're in insert mode and the
    " cursor's placed right after the whitespace. This prevents us from having
    " to put up with whitespace being highlighted in the middle of typing
    " something
    autocmd InsertEnter * match LinuxError /\s\+\%#\@<!$/
    autocmd InsertLeave * match LinuxError /\s\+$/
endfunction

" Autocommands 

augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg2 --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg2 --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

"au BufEnter *.hs compiler ghc
au BufRead,BufNewFile *.nix set syn=nix
au BufRead,BufNewFile *.nix set filetype=nix
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
au BufRead,BufNewFile *.md,*.mkd,*.markdown set ft=markdown
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
au BufWritePost,FileWritePost ~/.Xdefaults,~/.Xresources silent! !xrdb -load % >/dev/null 2>&1
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
au BufRead,BufNewFile wscript set syn=python
" 

" Commands 

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

" Wipe buffers with no files
function! s:WipeBuffersWithoutFiles()
    let bufs=filter(range(1, bufnr('$')), 'bufexists(v:val) && '.
                                          \'empty(getbufvar(v:val, "&buftype")) && '.
                                          \'!filereadable(bufname(v:val))')
    if !empty(bufs)
        execute 'bwipeout' join(bufs)
    endif
endfunction
command! WipeNoFiles call s:WipeBuffersWithoutFiles()

" 

runtime! config/*.vim
