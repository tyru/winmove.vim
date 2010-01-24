" vim:foldmethod=marker:fen:
scriptencoding utf-8

" NEW BSD LICENSE {{{
"   Copyright (c) 2009, tyru
"   All rights reserved.
"
"   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
"
"       * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
"       * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
"       * Neither the name of the tyru nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
"
"   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" }}}
" DOCUMENT {{{1
"==================================================
" Name: WinMove
" Version: 0.0.2
" Author:  tyru <tyru.exe@gmail.com>
" Last Change: 2010-01-24.
"
" Change Log: {{{2
"   0.0.0: Initial upload.
"   0.0.1: my e-mail address was wrong :-p
"   0.0.2: Allow range before mappings
"          e.g.: '10<Up>' moves gVim window to the upper 10 times
" }}}2
"
" Description:
"   Move your gVim from mappings.
"
" Usage:
"   MAPPING:
"       <Up>        move your gVim up.
"       <Right>     move your gVim right.
"       <Down>      move your gVim down.
"       <Left>      move your gVim left.
"
"   GLOBAL VARIABLES:
"       g:wm_move_up (default:'<Up>')
"           if empty string, no mapping is defined.
"
"       g:wm_move_right (default:'<Right>')
"           if empty string, no mapping is defined.
"
"       g:wm_move_down (default:'<Down>')
"           if empty string, no mapping is defined.
"
"       g:wm_move_left (default:'<Left>')
"           if empty string, no mapping is defined.
"
"       g:wm_move_x (default:20)
"           gVim use this when move left or right.
"
"       g:wm_move_y (default:15)
"           gVim use this when move up or down.
"
"
"==================================================
" }}}1

" INCLUDE GUARD {{{1
if exists('g:loaded_winmove') && g:loaded_winmove != 0
    finish
endif
let g:loaded_winmove = 1
" }}}1

" NOTE: THIS PLUGIN CAN'T WORK IN TERMINAL.
if ! has('gui_running')
    finish
endif

" SAVING CPO {{{1
let s:save_cpo = &cpo
set cpo&vim
" }}}1

" GLOBAL VARIABLES {{{1
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
" }}}1

" FUNCTION DEFINITION {{{1

func! s:MoveTo( dest )
    let winpos = { 'x':getwinposx(), 'y':getwinposy() }
    let repeat = v:count1

    if a:dest == '>'
        let winpos['x'] = winpos['x'] + g:wm_move_x * repeat
    elseif a:dest == '<'
        let winpos['x'] = winpos['x'] - g:wm_move_x * repeat
    elseif a:dest == '^'
        let winpos['y'] = winpos['y'] - g:wm_move_y * repeat
    elseif a:dest == 'v'
        let winpos['y'] = winpos['y'] + g:wm_move_y * repeat
    endif

    execute 'winpos' winpos['x'] winpos['y']
endfunc

" }}}1

" MAPPING {{{1
let s:mappings = {
    \ '^': g:wm_move_up,
    \ '>': g:wm_move_right,
    \ 'v': g:wm_move_down,
    \ '<': g:wm_move_left
\ }
for key in keys(s:mappings)
    if s:mappings[key] != ""
        execute 'nnoremap'
                    \ '<silent>'
                    \ s:mappings[key]
                    \ printf(':<C-u>call <SID>MoveTo(%s)<CR>', string(key))
    endif
endfor
unlet s:mappings
" }}}1

" RESTORE CPO {{{1
let &cpo = s:save_cpo
" }}}1

