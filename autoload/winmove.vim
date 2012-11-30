" vim:foldmethod=marker:fen:
scriptencoding utf-8

" CHECK AVAILABILITY {{{

" See plugin/winmove.vim for requirements.
try
    if !exists('g:loaded_winmove') || !g:loaded_winmove
        runtime! plugin/winmove.vim
    endif
catch
    finish
endtry

" }}}

" SAVING CPO {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


" FUNCTION DEFINITION {{{

function! winmove#to_up()
    call s:MoveTo('^')
endfunction

function! winmove#to_right()
    call s:MoveTo('>')
endfunction

function! winmove#to_down()
    call s:MoveTo('v')
endfunction

function! winmove#to_left()
    call s:MoveTo('<')
endfunction

function! s:MoveTo(dest)
    if has('gui_running')
        let winpos = { 'x':getwinposx(), 'y':getwinposy() }
    else
        redir => out | silent! winpos | redir END
        let mpos = matchlist(out, '^[^:]\+: X \(-\?\d\+\), Y \(-\?\d\+\)')
        if len(mpos) == 0 | return | endif
        let winpos = { 'x':mpos[1], 'y':mpos[2] }
    endif
    let repeat = v:count1

    if a:dest == '>'
        let winpos['x'] = winpos['x'] + g:wm_move_x * repeat
    elseif a:dest == '<'
        let winpos['x'] = winpos['x'] - g:wm_move_x * repeat
    elseif a:dest == '^'
        let winpos['y'] = has("gui_macvim") ?
              \ winpos['y'] + g:wm_move_y * repeat :
              \ winpos['y'] - g:wm_move_y * repeat
    elseif a:dest == 'v'
        let winpos['y'] = has("gui_macvim") ?
              \ winpos['y'] - g:wm_move_y * repeat :
              \ winpos['y'] + g:wm_move_y * repeat
    endif
    if winpos['x'] < 0 | let winpos['x'] = 0 | endif
    if winpos['y'] < 0 | let winpos['y'] = 0 | endif

    execute 'winpos' winpos['x'] winpos['y']
endfunction

" }}}


" RESTORE CPO {{{
let &cpo = s:save_cpo
" }}}

