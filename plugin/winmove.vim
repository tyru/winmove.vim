" vim:foldmethod=marker:fen:
scriptencoding utf-8

" CHECK AVAILABILITY {{{

" NOTE: Delay the a load of this script until VimEnter.
" Because :winpos raised an error on gVim (Windows)
" while loading this script at startup.
augroup winmove
    autocmd!
    autocmd VimEnter * let s:delayed = 1 | source <sfile>
augroup END
if !exists('s:delayed')
    finish
endif

" THIS PLUGIN WORK ON TERMINAL ALSO.
try
    silent winpos
catch /^Vim\%((\a\+)\)\=:E188/
    " echoerr 'winmove: your Vim does not support :winpos'
    finish
endtry
" }}}

" INCLUDE GUARD {{{
if exists('g:loaded_winmove') && g:loaded_winmove
    finish
endif
let g:loaded_winmove = 1
" }}}
" SAVING CPO {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


" GLOBAL VARIABLES {{{
if ! exists('g:wm_move_up')
    let g:wm_move_up = '<Up>'
endif
if ! exists('g:wm_move_right')
    let g:wm_move_right = '<Right>'
endif
if ! exists('g:wm_move_down')
    let g:wm_move_down = '<Down>'
endif
if ! exists('g:wm_move_left')
    let g:wm_move_left = '<Left>'
endif
if ! exists('g:wm_move_x')
    let g:wm_move_x = 20
endif
if ! exists('g:wm_move_y')
    let g:wm_move_y = 15
endif
" }}}

" MAPPING {{{
nnoremap <silent> <Plug>(winmove-up)     :<C-u>call winmove#to_up()<CR>
nnoremap <silent> <Plug>(winmove-right)  :<C-u>call winmove#to_right()<CR>
nnoremap <silent> <Plug>(winmove-down)   :<C-u>call winmove#to_down()<CR>
nnoremap <silent> <Plug>(winmove-left)   :<C-u>call winmove#to_left()<CR>

if g:wm_move_up != ''
    execute 'nmap' g:wm_move_up '<Plug>(winmove-up)'
endif
if g:wm_move_right != ''
    execute 'nmap' g:wm_move_right '<Plug>(winmove-right)'
endif
if g:wm_move_down != ''
    execute 'nmap' g:wm_move_down '<Plug>(winmove-down)'
endif
if g:wm_move_left != ''
    execute 'nmap' g:wm_move_left '<Plug>(winmove-left)'
endif
" }}}


" RESTORE CPO {{{
let &cpo = s:save_cpo
" }}}

