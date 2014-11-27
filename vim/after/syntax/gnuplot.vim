" Get the strings to be recognised as strings and not as comments
" Author: T. Le Bleis
" Language: gnuplot
" Original Date: 19.11.2014

syn region gnuplotString start='"' skip='\\"' end='"'


hi def link gnuplotString String
