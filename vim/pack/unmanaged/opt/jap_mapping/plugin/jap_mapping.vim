"==============================================================================
" Deals with file encoding and Japanese input layout
"==============================================================================
" Author: bilbopingouin
" Original date: 24.10.2014
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  none           -- comment
"==============================================================================
" Note
"   This is a historical components and I do not use anymore. But may be useful
"  at some future time.
"==============================================================================



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


