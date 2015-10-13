" Make Y behave like C and D
nnoremap Y y$

" Make cw behave like dw and yw
" NOTE: This causes some weird behaviour for end-of-line edge cases:
"       https://asciinema.org/a/9843
onoremap <silent> w :execute 'normal! '.v:count1.'w'<CR>
