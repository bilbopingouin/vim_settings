" Created for modelica files
" Author: T. Le Bleis (tudi.lebleis@gmail.com)
" Original: 09.11.2015
" Modification: 09.11.2015
" -------------------------------------------------------------

" No backward compatibility
if version<700
  finish
endif

" -------------------------------------------------------------
" Customary check
if exists("b:current_syntax")
  finish
endif

" -------------------------------------------------------------
" Declare the current syntax
let b:current_syntax="scl"

" -------------------------------------------------------------
" Comments
syn match   sclComment	      '//.*$'
syn region  sclComment	      start="(\*" end="\*)"

hi def link sclComment	      Comment

"syn region  sclIf fold matchgroup=sclCond start='\<IF\_s' end="\_s*THEN\>" end="\<END_IF\>"

"syn keyword sclCond THEN ELSE

" Function
syn keyword sclFuncKey	      contained FUNCTION BEGIN END_FUNCTION
syn region  sclFunctionBlock  matchgroup=sclFuncKey start='FUNCTION' end='\zeBEGIN'  fold transparent
syn region  sclFunctionBlock  matchgroup=sclFuncKey start="BEGIN" end="END_FUNCTION" fold transparent

hi def link sclFuncKey	      PreProc

" Conditionals and Loops
syn keyword sclUnmatched      END_IF

hi def link sclUnmatched  Error

syn keyword sclCondKeys	      contained IF END_IF
syn keyword sclCondInKeys     contained THEN
syn region  sclCondStatement  fold transparent matchgroup=sclCondKeys start="\<IF\_s" end="\<END_IF\>" contains=sclCondInKeys,@sclInStatements

syn keyword sclCondKeys	      contained CASE END_CASE
syn keyword sclCondInKeys     contained OF ELSE
syn region  sclCondStatement  fold transparent matchgroup=sclCondKeys start="\<CASE\_s" end="\<END_CASE\>" contains=sclCondInKeys,@sclInStatements

hi def link sclCondKeys	      sclStatements
hi def link sclCondInKeys     sclStatements

syn keyword sclLoopInKeys     contained CONTINUE EXIT

syn keyword sclLoopKeys	      contained FOR END_FOR
syn keyword sclLoopInKeys     contained TO BY DO
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<FOR\_s" end="\<END_FOR\>" contains=sclLoopInKeys,@sclInStatements

syn keyword sclLoopKeys	      contained WHILE END_WHILE
syn keyword sclLoopInKeys     contained DO
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<WHILE\_s" end="\<END_WHILE\>" contains=sclLoopInKeys,@sclInStatements

syn keyword sclLoopKeys	      contained REPEAT END_REPEAT
syn keyword sclLoopInKeys     contained UNTIL
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<REPEAT\_s" end="\<END_REPEAT\>" contains=sclLoopInKeys,@sclInStatements

hi def link sclLoopKeys	      sclStatements
hi def link sclLoopInKeys     sclStatements

hi def link sclStatements     Statement

" Meta Keys
syn keyword sclMetaKeys	      VERSION

hi def link sclMetaKeys	      Special

" Strings
syn region  sclString	      start=+"+ skip=+\\"+ end=+"+
syn region  sclString	      start=+'+ skip=+\\'+ end=+'+

hi def link sclString	      String

" Variables blocks
syn keyword sclVarBlockKey    contained CONST END_CONST
syn keyword sclVarBlockKey    contained LABEL END_LABEL
syn keyword sclVarBlockKey    contained VAR END_VAR
syn keyword sclVarBlockKey    contained VAR_TEMP END_VAR
syn keyword sclVarBlockKey    contained VAR_INPUT END_VAR
syn keyword sclVarBlockKey    contained VAR_OUTPUT END_VAR
syn keyword sclVarBlockKey    contained VAR_IN_OUT END_VAR

syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<CONST\>" end="\<END_CONST\>" contains=@sclInVarBlock
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<LABEL\>" end="\<END_LABEL\>" contains=@sclInVarBlock 
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<VAR\>" end="\<END_VAR\>" contains=@sclInVarBlock 
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<VAR_TEMP\>" end="\<END_VAR\>" contains=@sclInVarBlock 
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<VAR_INPUT\>" end="\<END_VAR\>" contains=@sclInVarBlock 
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<VAR_OUTPUT\>" end="\<END_VAR\>" contains=@sclInVarBlock 
syn region  sclVarBlock	      fold transparent matchgroup=sclVarBlockKey start="\<VAR_IN_OUT\>" end="\<END_VAR\>" contains=@sclInVarBlock 

hi def link sclVarBlockKey Statement

" Types
syn case ignore
syn keyword sclVarTypes	VOID
syn keyword sclVarTypes	BOOL BYTE WORD DWORD
syn keyword sclVarTypes CHAR
syn keyword sclVarTypes INT DINT REAL
syn keyword sclVarTypes TIME DATE TIME_OF_DAY
syn keyword sclVarTypes DATE_AND_TIME DT STRING STRUCT

syn match   sclVarTypes "ARRAY\_s*\[[0-9\.,]*\]\_s*OF" nextgroup=sclVarTypes

hi def link sclVarTypes Type

" Signals names
syn match   sclVarName	contained "[a-zA-Z0-9_]\+"
syn match   sclVarSig	"#[^\ ]\+" contains=sclVarName
syn match   sclVarAss	"\w\+\_s*:=" contains=sclVarName
syn match   sclDeclSig	contained "\w\+\_s*:" nextgroup=sclVarTypes contains=sclVarName

hi def link sclVarName	sclVariable
hi def link sclVarSig	sclVariable

hi def link sclVariable	Identifier

" Operations
syn keyword sclLogicOp	AND OR NOT XOR
syn keyword sclArithOp  MOD DIV

hi def link sclLogicOp sclOperations
hi def link sclArithOp sclOperations

syn cluster sclOperations contains=sclLogicOp,sclArithOp

" Nested variables
syn cluster sclInStatements contains=sclVarSig,sclComment,sclLoopStatement,sclCondStatement,@sclOperations
syn cluster sclInVarBlock  contains=sclDeclSig,sclVarTypes,sclComment

"
"" Control Statements
"syn keyword sclCondBoolOperators  AND OR contained
"syn match   sclCondition  ".*" contains=sclCondBoolOperators
"
"
"syn keyword sclCtlKeys	  IF END_IF
"syn keyword sclCtlKeys1	  THEN ELSE ELSIF contained
"syn keyword sclCtlKeys	  CASE OF END_CASE
"syn keyword sclCtlKeys	  FOR TO BY DO END_FOR
"syn keyword sclCtlKeys	  WHILE END_WHILE
"syn keyword sclCtlKeys	  REPEAT UNTIL END_REPEAT
"
"
"syn region  sclCtlStat	 start="IF"	end="END_IF"	  fold contains=sclCtlKeys1
"syn region  sclCtlStat	 start="FOR.*DO"	end="END_FOR"	  fold transparent
"syn region  sclCtlStat	 start="CASE"		end="END_CASE"	  fold transparent
"syn region  sclCtlStat1	 start="WHILE.*DO"	end="END_WHILE"	  fold transparent
"syn region  sclCtlStat	 start="REPEAT.*UNTIL"	end="END_REPEAT"  fold transparent
"
"
"
"" Constants and variables
"syn keyword sclVarType	   Void Bool Int Real Byte Char String Word Dword Dint S5time TIME Date Time_Of_Day Date_And_Time
"syn keyword sclVarType	   VOID BOOL INT REAL BYTE CHAR STRING WORD DWORD DINT S5TIME TIME DATE TIME_OF_DAY DATE_AND_TIME
"syn match   sclVarType	   'ARRAY\ *\[[0-9,\.]*\]\ *OF'
"
"" Declaration Sections
"syn keyword sclVarBlock	   VAR_INPUT VAR_OUTPUT END_VAR
"syn region sclVarBlock	  start='VAR'	      end='END_VAR'   fold transparent
"syn region sclVarBlock	  start='CONST'	      end='END_CONST' fold transparent
"syn region sclVarBlock	  start='LABEL'	      end='END_LABEL' fold transparent
"syn region sclVarBlock	  start='VAR_TEMP'    end='END_VAR'   fold transparent
"syn region sclVarBlock	  start='VAR_OUTPUT'  end='END_VAR'   fold transparent
"syn region sclVarBlock	  start='VAR_INPUT'   end='END_VAR'   fold transparent
"syn region sclVarBlock	  start='VAR_IN_OUT'  end='END_VAR'   fold transparent
"
"syn region  sclString      start='"' skip='\\"' end='"'
"syn region  sclString      start='\'' skip='\\\'' end='\''
"
"syn match   sclSignal	   '#[a-z]*'
"

" -------------------------------------------------------------

" -------------------------------------------------------------
" Sets the color scheme

" hi def link modelicaKeyword   Special
" hi def link modelicaString    String
" hi def link modelicaAnnot     Comment
" hi def link modelicaKeyType   Type
" hi def link modelicaConnect   Statement
" hi def link modelicaImpLib    PreProc
" hi def link modelicaModType   Identifier
" hi def link modelicaModType   Constant
" hi modelicaFirstBrace ctermfg=1
" hi modelicaSecondBrace ctermfg=2
" hi modelicaThirdBrace ctermfg=3
" hi modelicaFourthBrace ctermfg=4
" hi modelicaKeyMod ctermfg=1
" hi modelicaModName ctermfg=2
" hi modelicaKeyPProc ctermfg=3
"hi def link sclString    String
"hi def link sclComment   Comment
"
"hi def link sclCtlKeys Statement
"hi def link sclCtlKeys1 Statement
"
"hi def link sclFuncKey   Statement
"
"hi def link sclMetaKeys	 PreProc
"
"hi def link sclVarType	 Type
"hi def link sclVarBlock	 Statement
"
"hi def link sclSignal	 Constant
"
"hi def link sclCond	Special
