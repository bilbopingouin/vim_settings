" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
autoload/ttagecho.vim	[[[1
188
" ttagecho.vim
" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-10-28.
" @Last Change: 2009-08-09.
" @Revision:    0.0.210

if &cp || exists("loaded_ttagecho_autoload")
    finish
endif
let loaded_ttagecho_autoload = 1


let s:echo_constraints = ''
let s:echo_index       = -1
let s:echo_tags        = []


" :def: function! ttagecho#Expr(rx, ?many_lines=0, ?bang=0, ?compact=0)
" Return a string representing the tags matching rx.
function! ttagecho#Expr(rx, ...) "{{{3
    let many_lines = a:0 >= 1 ? a:1 : 0
    let bang       = a:0 >= 2 ? a:2 : 0
    let compact    = a:0 >= 3 ? a:3 : 0
    let constraint = a:rx . bang
    " TLogVAR a:rx, many_lines, bang, compact
    if s:echo_constraints != constraint
	    let s:echo_constraints = constraint
        let s:echo_index       = -1
        let s:echo_tags = tlib#tag#Collect({'name': a:rx}, bang, 0)
	endif
    if !empty(s:echo_tags)
        let max_index    = len(s:echo_tags)
        let s:echo_index = (s:echo_index + 1) % max_index
        " TLogVAR tag
        if many_lines != 0
            let lines = len(s:echo_tags)
            if many_lines < 0
                let not_compact = lines > 1
                let many_lines = -many_lines
            else
                let not_compact = 1
            endif
            if many_lines > 0 && many_lines < lines
                let lines = many_lines
                let extra = '...'
            else
                let extra = ''
            endif
            " TLogVAR many_lines, lines
            let rv = map(range(lines), 's:FormatTag(v:val + 1, max_index, s:echo_tags[v:val], not_compact, compact)')
            if !empty(extra)
                call add(rv, extra)
            endif
            return join(rv, "\n")
        else
            let tag = s:echo_tags[s:echo_index]
            return s:FormatTag(s:echo_index + 1, max_index, tag, many_lines, compact)
        endif
    endif
    return ''
endf


function! s:FormatName(tag) "{{{3
    if exists('*TTagechoFormat_'. &filetype)
        let name = TTagechoFormat_{&filetype}(a:tag)
    else
        let name = tlib#tag#Format(a:tag)
    endif
    " TLogVAR a:tag, name
    return name
endf


function! s:FormatTag(index, max_index, tag, many_lines, compact) "{{{3
    let name = s:FormatName(a:tag)
    let wd = a:compact && !a:many_lines ? '' : '-'. eval(g:ttagecho_tagwidth)
    " TLogVAR a:compact, a:many_lines, a:max_index, wd
    let fmt  = '%s: %'. wd .'s | %s'
    if a:max_index == 1
        let rv = printf(fmt, a:tag.kind, name, fnamemodify(a:tag.filename, ":t"))
    else
        let rv = printf('%0'. len(a:max_index) .'d:'. fmt, a:index, a:tag.kind, name, fnamemodify(a:tag.filename, ":t"))
    endif
    return rv
endf


function! s:WordRx(word) "{{{3
    let rv = '\V\C\^'. escape(a:word, '\')
    if !g:ttagecho_matchbeginning
        let rv .= '\$'
    endif
    return rv
endf


" Echo the tag(s) matching rx.
function! ttagecho#Echo(rx, many_lines, bang) "{{{3
    " TLogVAR a:rx, a:many_lines, a:bang
    let expr = ttagecho#Expr(a:rx, a:many_lines, a:bang)
    if empty(expr)
        redraw
        " echo
    else
        redraw
        echohl Type
        if a:many_lines != 0
            echo expr
        else
            echo tlib#notify#TrimMessage(expr)
            " call tlib#notify#Echo(expr)
            " echo strpart(expr, 0, &columns - &fdc - 10)
        endif
        echohl NONE
    endif
endf


" Echo one match for the tag under cursor.
function! ttagecho#EchoWord(bang) "{{{3
    " TLogVAR a:bang
    call ttagecho#Echo('\V\C\^'. expand('<cword>') .'\$', 0, a:bang)
endf


" Echo all matches for the tag under cursor.
function! ttagecho#EchoWords(bang) "{{{3
    " TLogVAR a:bang
    call ttagecho#Echo('\V\C\^'. expand('<cword>') .'\$', -1, a:bang)
endf


" Echo the tag in front of an opening round parenthesis.
function! ttagecho#OverParanthesis(mode) "{{{3
    let line = getline('.')
    let scol = col('.') - 1
    let char = line[scol]
    if char == ')'
        let view = winsaveview()
        call searchpair('(', '', ')', 'bW')
        let scol = col('.') - 1
        call winrestview(view)
    endif
    " TLogVAR scol
    let line = strpart(line, 0, scol)
    let chrx = s:GetCharRx() .'\+$'
    let text = matchstr(line, chrx)
    " TLogVAR char, chrx, text, line
    if &showmode && a:mode == 'i' && g:ttagecho_restore_showmode != -1 && &cmdheight == 1
        let g:ttagecho_restore_showmode = 1
        " TLogVAR g:ttagecho_restore_showmode
        set noshowmode
    endif
    " TLogDBG 'Do the echo'
    call ttagecho#Echo(s:WordRx(text), 0, 0)
endf


" Return tag information for the tag under the mouse pointer (see 'balloonexpr')
function! ttagecho#Balloon() "{{{3
    " TLogVAR v:beval_lnum, v:beval_col
    let line = getline(v:beval_lnum)
    let chrx = s:GetCharRx()
    let text = matchstr(line, chrx .'*\%'. v:beval_col .'c'. chrx .'*')
    " TLogVAR text
    let balloon = ttagecho#Expr(s:WordRx(text), -eval(g:ttagecho_balloon_limit), 0, 1)
    if !empty(balloon)
        return balloon
    elseif exists('b:ttagecho_bexpr') && !empty(b:ttagecho_bexpr)
        return eval(b:ttagecho_bexpr)
    else
        return ''
    endif
endf


function! s:GetCharRx() "{{{3
    let chrx = tlib#var#Get('ttagecho_char_rx', 'wb', '')
    if empty(chrx)
        let chrx = get(g:ttagecho_char_rx, 'vim', '\w')
    endif
    " TLogVAR chrx
    return chrx
endf

plugin/ttagecho.vim	[[[1
161
" ttagecho.vim -- Show current tag information
" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-10-28.
" @Last Change: 2009-08-09.
" @Revision:    0.5.135
" GetLatestVimScripts: 2055 0 ttagecho.vim

if &cp || exists("loaded_ttagecho")
    finish
endif
if !exists('g:loaded_tlib') || g:loaded_tlib < 25
    runtime plugin/02tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 25
        echoerr 'tlib >= 0.25 is required'
        finish
    endif
endif
let loaded_ttagecho = 5

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:ttagecho_parentheses_patterns')
    " If hookcursormoved (vimscript #) is installed, display tag 
    " information when moving over parantheses for these filetypes.
    " :read: let g:ttagecho_parentheses_patterns = [] "{{{2
    let g:ttagecho_parentheses_patterns = [
                \ '*.c',
                \ '*.h',
                \ '*.java',
                \ '*.js',
                \ '*.php',
                \ '*.rb',
                \ '*.vim',
                \ ]
endif


if !exists('g:ttagecho_char_rx')
    " Regexps to match keyword characters (in case you don't want to 
    " change iskeyword.
    " :read: let g:ttagecho_char_rx = {} "{{{2
    let g:ttagecho_char_rx = {
                \ 'vim': '\(\w\|#\)',
                \ }
endif


if !exists('g:ttagecho_balloon_patterns')
    " Set 'balloonexpr' for buffers that match these patterns.
    let g:ttagecho_balloon_patterns = g:ttagecho_parentheses_patterns  "{{{2
    " let g:ttagecho_balloon_patterns = ['*'] "{{{2
endif


if !exists('g:ttagecho_restore_showmode')
    " If 'showmode' is set, |ttagecho#OverParanthesis()| will 
    " temporarily unset the option when triggered in insert mode. The 
    " original value will be restored on the next CursorHold(I) events.
    " Set this variable to -1, if you don't want this to happen. In this 
    " case you might need to set 'cmdheight' to something greater than 
    " 1.
    let g:ttagecho_restore_showmode = 0 "{{{2
endif


if !exists('g:ttagecho_balloon_limit')
    " The number of items to be displayed in the balloon popup. It will be 
    " evaluated with |eval()|, which is why it can also be a vim expression.
    let g:ttagecho_balloon_limit = '&lines * 2 / 3'   "{{{2
endif


if !exists('g:ttagecho_tagwidth')
    " The width of the tag "column". It will be evaluated with |eval()|, which 
    " is why it can also be a vim expression.
    let g:ttagecho_tagwidth = '&co / 3'  "{{{2
endif


if !exists('g:ttagecho_matchbeginning')
    " If true, match only the beginning of a tag (i.e. don't add '$' to 
    " the regexp).
    let g:ttagecho_matchbeginning = 0   "{{{2
endif


augroup TTagecho
    autocmd!
    if exists('loaded_hookcursormoved')
        for s:pattern in g:ttagecho_parentheses_patterns
            exec 'autocmd BufNewFile,BufReadPost,FileType '. s:pattern .' call hookcursormoved#Register("parenthesis_round_open", "ttagecho#OverParanthesis")'
            exec 'autocmd BufNewFile,BufReadPost,FileType '. s:pattern .' call hookcursormoved#Register("parenthesis_round_close", "ttagecho#OverParanthesis")'
            exec 'autocmd InsertLeave '. s:pattern .' if g:ttagecho_restore_showmode == 1 | set showmode | echo | endif'
        endfor
        if has('balloon_eval')
            for s:pattern in g:ttagecho_balloon_patterns
                exec 'autocmd BufNewFile,BufReadPost,FileType '. s:pattern .' if &bexpr != "ttagecho#Balloon()" | let b:ttagecho_bexpr = &bexpr | endif'
                exec 'autocmd BufNewFile,BufReadPost,FileType '. s:pattern .' setlocal ballooneval bexpr=ttagecho#Balloon()'
            endfor
        endif
        unlet s:pattern
    endif
augroup END


" :display: TTagecho[!] [TAGS_RX]
" Show the tag in the echo area. If invoked repeatedly, this command 
" will loop through matching tags.
command! -bang -nargs=1 -bar TTagecho call ttagecho#Echo(<q-args>, 0, !empty('<bang>'))

" :display: TTagechoAll[!] [TAGS_RX]
" Show all matches.
command! -bang -nargs=1 -bar TTagechoAll call ttagecho#Echo(<q-args>, -1, !empty('<bang>'))

" :display: TTagechoWord[!]
" Show information for the word under cursor.
command! -bang TTagechoWord call ttagecho#EchoWord(!empty('<bang>'))

" :display: TTagechoWords[!]
" Show all matches for the word under cursor.
command! -bang TTagechoWords call ttagecho#EchoWords(!empty('<bang>'))


let &cpo = s:save_cpo
unlet s:save_cpo

finish
CHANGES:
0.1
- Initial release

0.2
- Customize display: g:ttagecho_tagwidth
- g:ttagecho_matchbeginning
- Check for has('balloon_eval')
- Restore showmode only on InsertLeave events (not on CursorHold(I) events).

0.3
- Check only opening parentheses (require hookcursormoved 0.5)
- Use [bg]:tlib_tags_extra if defined.
- Require tlib >= 0.20
- g:ttagecho_substitute became g:tlib_tag_substitute
- Removed support for: [bg]:ttagecho_more_tags (use [bg]:tlib_tags_extra 
instead)

0.4
- Adapt for hookcursormoved >= 0.7

0.5
- Make sure tlib is loaded even if it is installed in a different rtp-directory (thanks to ... sorry, cannot find the e-mail)
- Use tlib#notify#TrimMessage() (thanks to Erik Falor)

0.6
- NEW: g:ttagecho_char_rx: custom keyword char regexp
- Always use compact style when there is only one tag that matches and if many_lines < 0
- Find the right keyword, when the current line contains more than one

doc/ttagecho.txt	[[[1
148
*ttagecho.txt*      Show current tag information (echo area or balloon)
                    Author: Tom Link, micathom at gmail com

This plugin is similar to echofunc (vimscript #1735) to which it owes 
much inspiration and two lines of code. It displays some information 
about the tag under the cursor or mouse pointer either in the echo area 
or as balloon help (see |g:ttagecho_balloon_patterns|). If there are 
more than one tags that match, you can loop through the tags by invoking 
the respective commands repeatedly.

If hookcursormoved (vimscript #2037, version >= 0.4) is installed, for 
certain filetypes (see |g:ttagecho_parentheses_patterns|) it will 
display the information in the echo area also if the cursor moves over a 
round parenthesis.

If you don't like the default format for the tags, you can define the 
function TTagechoFormat_{&filetype}(a:tag) that should return some nicely 
formatted information.


-----------------------------------------------------------------------
Install~

Edit the vba file and type: >

    :so %

See :help vimball for details. If you have difficulties or use vim 7.0, 
please make sure, you have the current version of vimball (vimscript 
#1502) installed.

Suggested maps (to be set in ~/.vimrc): >
    noremap <Leader>g+ :TTagechoWord<cr>
    noremap <Leader>g* :TTagechoWord!<cr>
    noremap <Leader>g? :TTagechoWords!<cr>


========================================================================
Contents~

        g:ttagecho_parentheses_patterns ... |g:ttagecho_parentheses_patterns|
        g:ttagecho_char_rx ................ |g:ttagecho_char_rx|
        g:ttagecho_balloon_patterns ....... |g:ttagecho_balloon_patterns|
        g:ttagecho_restore_showmode ....... |g:ttagecho_restore_showmode|
        g:ttagecho_balloon_limit .......... |g:ttagecho_balloon_limit|
        g:ttagecho_tagwidth ............... |g:ttagecho_tagwidth|
        g:ttagecho_matchbeginning ......... |g:ttagecho_matchbeginning|
        :TTagecho ......................... |:TTagecho|
        :TTagechoAll ...................... |:TTagechoAll|
        :TTagechoWord ..................... |:TTagechoWord|
        :TTagechoWords .................... |:TTagechoWords|
        ttagecho#Expr ..................... |ttagecho#Expr()|
        ttagecho#Echo ..................... |ttagecho#Echo()|
        ttagecho#EchoWord ................. |ttagecho#EchoWord()|
        ttagecho#EchoWords ................ |ttagecho#EchoWords()|
        ttagecho#OverParanthesis .......... |ttagecho#OverParanthesis()|
        ttagecho#Balloon .................. |ttagecho#Balloon()|


========================================================================
plugin/ttagecho.vim~

                                                    *g:ttagecho_parentheses_patterns*
g:ttagecho_parentheses_patterns (default: [])
    If hookcursormoved (vimscript #) is installed, display tag 
    information when moving over parantheses for these filetypes.

                                                    *g:ttagecho_char_rx*
g:ttagecho_char_rx             (default: {})
    Regexps to match keyword characters (in case you don't want to 
    change iskeyword.

                                                    *g:ttagecho_balloon_patterns*
g:ttagecho_balloon_patterns    (default: g:ttagecho_parentheses_patterns)
    Set 'balloonexpr' for buffers that match these patterns.

                                                    *g:ttagecho_restore_showmode*
g:ttagecho_restore_showmode    (default: 0)
    If 'showmode' is set, |ttagecho#OverParanthesis()| will 
    temporarily unset the option when triggered in insert mode. The 
    original value will be restored on the next CursorHold(I) events.
    Set this variable to -1, if you don't want this to happen. In this 
    case you might need to set 'cmdheight' to something greater than 
    1.

                                                    *g:ttagecho_balloon_limit*
g:ttagecho_balloon_limit       (default: '&lines * 2 / 3')
    The number of items to be displayed in the balloon popup. It will be 
    evaluated with |eval()|, which is why it can also be a vim expression.

                                                    *g:ttagecho_tagwidth*
g:ttagecho_tagwidth            (default: '&co / 3')
    The width of the tag "column". It will be evaluated with |eval()|, which 
    is why it can also be a vim expression.

                                                    *g:ttagecho_matchbeginning*
g:ttagecho_matchbeginning      (default: 0)
    If true, match only the beginning of a tag (i.e. don't add '$' to 
    the regexp).

                                                    *:TTagecho*
TTagecho[!] [TAGS_RX]
    Show the tag in the echo area. If invoked repeatedly, this command 
    will loop through matching tags.

                                                    *:TTagechoAll*
TTagechoAll[!] [TAGS_RX]
    Show all matches.

                                                    *:TTagechoWord*
TTagechoWord[!]
    Show information for the word under cursor.

                                                    *:TTagechoWords*
TTagechoWords[!]
    Show all matches for the word under cursor.


========================================================================
autoload/ttagecho.vim~

                                                    *ttagecho#Expr()*
ttagecho#Expr(rx, ?many_lines=0, ?bang=0, ?compact=0)
    Return a string representing the tags matching rx.

                                                    *ttagecho#Echo()*
ttagecho#Echo(rx, many_lines, bang)
    Echo the tag(s) matching rx.

                                                    *ttagecho#EchoWord()*
ttagecho#EchoWord(bang)
    Echo one match for the tag under cursor.

                                                    *ttagecho#EchoWords()*
ttagecho#EchoWords(bang)
    Echo all matches for the tag under cursor.

                                                    *ttagecho#OverParanthesis()*
ttagecho#OverParanthesis(mode)
    Echo the tag in front of an opening round parenthesis.

                                                    *ttagecho#Balloon()*
ttagecho#Balloon()
    Return tag information for the tag under the mouse pointer (see 'balloonexpr')



vim:tw=78:fo=tcq2:isk=!-~,^*,^|,^":ts=8:ft=help:norl:
