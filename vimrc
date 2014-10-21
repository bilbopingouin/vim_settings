"This file allows to set up some useful options of vim


" This is specifically for the configuration on the EEE PC... if I could include another file...
if $LANG == 'ja_JP.EUC-JP'
  " echo "Running Japanese"
  :se term=builtin_ansi
  
  map OQ	<F2>
  map OR	<F3>
  imap OQ	<F2>
  imap OR	<F3>
  
  " for end/home keys
  " to know the code, type in edit mode C-v and then the key
  map OH <Home>
  map OF <End>
  imap OH <Home>
  imap OF <End>
  
  " for PageUp/PageDown
  " to know the code, type C-k and then the key
  map [6~ <PageDown>
  map [5~ <PageUp>
  imap [6~ <PageDown>
  imap [5~ <PageUp>
  "map <PageUp> <C-U>
  "map <PageDown> <C-D>
endif

"Indent with respects with C programming
":se cindent
  "Keep the linux standart (when using other editors: less, a2ps...)
:se tabstop=8
  "Make it using spaces in indenting: so that it looks reasonnable 
  "(8 spaces being much too large).
:se softtabstop=2
:se shiftwidth=2
:se noet

"See colours of the syntax
if &t_Co > 1
	syntax enable
endif

"Set the status line
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"Show positions of the cursor within the file
:se ruler

"For backspace to delete the previous character
set backspace=indent,eol,start

"Not cutting the end of the words
:se lbr

"Japanese characters
if has("multi_byte")
"set encoding=utf-8                   " how vim shall represent characters internally
"setglobal fileencoding=utf-8         " empty is also OK (defaults to same as 'encoding'). Or you may want to set one of the ucs encodings (which
				     " may use less disk space if you use only "alphabetic" scripts such as Latin, Greek, Cyrillic, Hebrew or Arabic, and
				     " not "ideographic" scripts like Chinese, Japanese or Korean. With the ucs encodings it is usually better
"set bomb                             " to also set 'bomb' on ('byte-order-mark" option, irrelevant for utf-8 but not for ucs)
"set termencoding=iso-8859-15	     " or whatever is appropriate to your locale (iso-8859-15 is Latin1 + Euro currency sign)
"set fileencodings=ucs-bom,iso-8859-15,iso-8859-3,utf-8
				     " or whatever is appropriate to the kinds of files you want to edit
				     " 'fileencodings' defines the heuristic to set 'fillencoding' (local to buffer) when reading an existing file. The first one that matches will be used.
				     " ucs-bom is "ucs with byte-order-mark"; it must not come after ucs-8 if you want it to be used
"else
"echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

"In "replace" mode, one utf character (one or more data bytes) replaces one utf character (which need not use the same number of bytes)
"In "normal" mode, ga shows the character under the cursor as text, decimal, octal and hex; g8 shows which byte(s) is/are used to represent it
"In "insert" or "replace" mode,
"	 - any character defined on your keyboard can be entered the usual way (even with dead keys if you have them, e.g. âêîôû  äëïöü)
"	 - any character which has a "digraph" (there are a huge lot of them, see :dig after setting enc=utf-8) can be entered with a Ctrl-K prefix
"	 - any utf character at all can be entered with a Ctrl-V prefix, either <Ctrl-V> u aaaa or <Ctrl-V> U bbbbbbbb, with 0 <= aaaa <= FFFF, or 0 <= bbbbbbbb <= 7FFFFFFF

"	Unicode can be used to create html "body text", at least for Netscape 6 and probably for IE; but on my machine it doesn't display properly as "title text" (i.e., between <title></title> tags in the <head> part).

"	Gvim will display it properly if you have the fonts for it, provided that you set 'guifont' to some fixed-width font which has the glyphs you want to use (Courier New is OK for French, German, Greek, Russian and more, but I'm not sure about Hebrew or Arabic; its glyphs are of a more "fixed" width than those of, e.g. Lucida Console: the latter can be annoying if you need bold Cyrillic writing).

" Check spell in US English, type V
map <F2> :w<enter>:!ispell % <enter>:e!<enter><enter>
" in UK English, type F2
map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
"map V :w<enter>:!ispell -d british % <enter>:e!<enter><enter>
" in French, type F3
map <F3> :w<enter>:!ispell -d french % <enter>:e!<enter><enter>

" Search ignoring case
:se ignorecase

" Compile and show result in a split screen
map <F7> :w<enter>:tabnew<enter>:r!make<enter>

" When incrementing, numbers starting with 0x are recognised as hexa and the ones starting with 0 as octal.
" Since I never work with octal numbers and that I sometimes defined decimal starting from 0, I set the 
" formats as 
:se nrformats=hex
" also possible are 'octal' and 'alpha'.

" Some abbreviations. Particularly useful for mails.
:ab MfG Mit freundlichen Gruessen
":ab TLB Tudi Le Bleis

" Twitvim
let twitvim_browser_cmd = 'iceweasel'
let twitvim_count = 50

" un/comment in Visual
au FileType vim	    let b:comment_leader = '" '
au FileType c,css   let b:comment_leader = '// '
au FileType cpp     let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex	    let b:comment_leader = '% '
au FileType vhdl    let b:comment_leader = '-- '
au FileType python  let b:comment_leader = '# '
au FileType ruby    let b:comment_leader = '# '
au FileType javascript    let b:comment_leader = '// '


noremap ,c : <C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap ,u : <C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" Search visually selected text
:vmap * y/<C-R>"<CR>
:vmap # y?<C-R>"<CR>
