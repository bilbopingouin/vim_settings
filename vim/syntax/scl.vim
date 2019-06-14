" Created for modelica files
" Author: bilbopingouin (bilbopingouin@gmail.com)
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
syn match   sclComment	      '//.*$' contains=@Spell
syn region  sclComment	      start="(\*" end="\*)" contains=@Spell


" Language is not case sensitive
syn case ignore

" Function
syn keyword sclFuncError      END_FUNCTION END_FUNCTION_BLOCK

syn keyword sclFuncKey	      contained FUNCTION BEGIN END_FUNCTION FUNCTION_BLOCK END_FUNCTION_BLOCK
syn region  sclFunctionBlock  matchgroup=sclFuncKey start='FUNCTION' end='\zeBEGIN'  fold transparent
syn region  sclFunctionBlock  matchgroup=sclFuncKey start="BEGIN" end="END_FUNCTION" fold transparent

" Conditionals and Loops
syn keyword sclCondError      END_IF END_CASE CONTINUE EXIT

syn keyword sclCondKeys	      contained IF END_IF
syn keyword sclCondInKeys     contained THEN
syn region  sclCondStatement  fold transparent matchgroup=sclCondKeys start="\<IF\_s" end="\<END_IF\>" contains=sclCondInKeys,@sclInStatements

syn keyword sclCondKeys	      contained CASE END_CASE
syn keyword sclCondInKeys     contained OF ELSE
syn region  sclCondStatement  fold transparent matchgroup=sclCondKeys start="\<CASE\_s" end="\<END_CASE\>" contains=sclCondInKeys,@sclInStatements

syn keyword sclLoopInKeys     contained CONTINUE EXIT

syn keyword sclLoopError      END_FOR END_WHILE END_REPEAT

syn keyword sclLoopKeys	      contained FOR END_FOR
syn keyword sclLoopInKeys     contained TO BY DO
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<FOR\_s" end="\<END_FOR\>" contains=sclLoopInKeys,@sclInStatements

syn keyword sclLoopKeys	      contained WHILE END_WHILE
syn keyword sclLoopInKeys     contained DO
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<WHILE\_s" end="\<END_WHILE\>" contains=sclLoopInKeys,@sclInStatements

syn keyword sclLoopKeys	      contained REPEAT END_REPEAT
syn keyword sclLoopInKeys     contained UNTIL
syn region  sclLoopStatement  fold transparent matchgroup=sclLoopKeys start="\<REPEAT\_s" end="\<END_REPEAT\>" contains=sclLoopInKeys,@sclInStatements

" Meta Keys
syn keyword sclMetaKeys	      VERSION

" Strings
syn region  sclString	      start=+"+ skip=+\\"+ end=+"+
syn region  sclString	      start=+'+ skip=+\\'+ end=+'+

" Variables blocks
syn keyword sclVBlockError    END_CONST END_LABEL END_VAR

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

" Types
syn keyword sclVarTypes	VOID
syn keyword sclVarTypes	BOOL BYTE WORD DWORD
syn keyword sclVarTypes CHAR
syn keyword sclVarTypes INT DINT REAL
syn keyword sclVarTypes TIME DATE TIME_OF_DAY
syn keyword sclVarTypes DATE_AND_TIME DT STRING STRUCT

syn match   sclVarTypes "ARRAY\_s*\[[0-9\.,]*\]\_s*OF" nextgroup=sclVarTypes

" Signals names
syn match   sclVarName	contained "[a-zA-Z0-9_]\+"
syn match   sclVarSig	"#[^\ ]\+" contains=sclVarName
syn match   sclVarAss	"\w\+\_s*:=" contains=sclVarName
syn match   sclDeclSig	contained "\w\+\_s*:" nextgroup=sclVarTypes contains=sclVarName

" Operations
syn keyword sclLogicOp	AND OR NOT XOR
syn keyword sclArithOp  MOD DIV
syn keyword sclNumFunc	ABS SQR SQRT EXP EXPD LN LOG ACOS ASIN ATAN COS SIN TAN
syn keyword sclBitFunc	ROL ROR SHL SHR
syn keyword sclStrFunc	LEN CONCAT LEFT RIGHT MID INSERT DELETE REPLACE FIND EQ_STRNG NE_STRNG GE_STRNG LE_STRNG GT_STRNG LT_STRNG INT_TO_STRING STRING_TO_INT REAL_TO_STRING STRING_TO_REAL
syn keyword sclSelFunc	SEL MAX MIN LIMIT MUX
syn keyword sclCntFunc	S_CU S_CD S_CUD
syn keyword sclTimFunc	S_PULSE S_PEXT S_ODT S_ODTS S_OFFDT
syn keyword sclRndFunc	ROUND TRUNC

syn keyword sclConFunc	BOOL_TO_BYTE BOOL_TO_DWORD BOOL_TO_WORD BYTE_TO_DWORD BYTE_TO_WORD CHAR_TO_STRING DINT_TO_REAL INT_TO_DINT INT_TO_REAL WORD_TO_DWORD
syn keyword sclConFunc	BOOL_TO_INT BOOL_TO_DINT BYTE_TO_BOOL BYTE_TO_CHAR BYTE_TO_INT BYTE_TO_DINT
syn keyword sclConFunc	CHAR_TO_BYTE CHAR_TO_INT DATE_TO_DINT DINT_TO_DATE DINT_TO_WORD DINT_TO_INT
syn keyword sclConFunc	DINT_TO_TIME DINT_TO_TOD DINT_TO_BOOL DINT_TO_BYTE DINT_TO_STRING DINT_TO_WORD
syn keyword sclConFunc	DWORD_TO_BOOL DWORD_TO_BYTE DWORD_TO_DINT DWORD_DO_REAL DWORD_TO_WORD
syn keyword sclConFunc	DWORD_TO_INT INT_TO_CHAR INT_TO_WORD INT_TO_BOOL INT_TO_BYTE INT_TO_DWORD
syn keyword sclConFunc	INT_TO_STRING REAL_TO_DINT REAL_TO_DWORD REAL_TO_INT REAL_TO_STRING
syn keyword sclConFunc	STRING_TO_CHAR STRING_TO_INT STRING_TO_DINT STRING_TO_REAL TIME_TO_DINT
syn keyword sclConFunc	TOD_TO_DINT WORD_TO_BOOL WORD_TO_BYTE WORD_TO_INT WORD_TO_DINT WORD_TO_BLOCK_DB
syn keyword sclConFunc	BLOCK_DB_TO_WORD BCD_TO_INT WORD_BCD_TO_INT INT_TO_BCD INT_TO_BCD_WORD
syn keyword sclConFunc	BCD_TO_DINT DWORD_BCD_TO_DINT DINT_TO_BCD DINT_TO_BCD_DWORD

syn cluster sclOperations contains=sclLogicOp,sclArithOp,sclNumFunc,sclBitFunc,sclStrFunc,sclSelFunc,sclCntFunc,sclTimFunc,sclRndFunc,sclConFunc

" Nested variables
syn cluster sclInStatements contains=sclVarSig,sclComment,sclLoopStatement,sclCondStatement,@sclOperations
syn cluster sclInVarBlock  contains=sclDeclSig,sclVarTypes,sclComment

" -------------------------------------------------------------
syn case match


" -------------------------------------------------------------
" Sets the color scheme

hi def link sclComment	    Comment

hi def link sclString	    String

hi def link sclFuncKey	    PreProc

hi def link sclCondKeys	    sclStatements
hi def link sclCondInKeys   sclStatements
hi def link sclLoopKeys	    sclStatements
hi def link sclLoopInKeys   sclStatements

hi def link sclStatements   Statement

hi def link sclVarBlockKey  Statement

hi def link sclVarTypes	    Type

hi def link sclVarName	    sclVariable
hi def link sclVarSig	    sclVariable

hi def link sclVariable	    Identifier

hi def link sclLogicOp	    sclOperations
hi def link sclArithOp	    sclOperations
hi def link sclNumFunc	    sclOperations
hi def link sclBitFunc	    sclOperations
hi def link sclStrFunc	    sclOperations
hi def link sclSelFunc	    sclOperations
hi def link sclCntFunc	    sclOperations
hi def link sclTimFunc	    sclOperations
hi def link sclRndFunc	    sclOperations
hi def link sclConFunc	    sclOperations

hi def link sclOperations   Type

hi def link sclMetaKeys	    Special

hi def link sclFuncError    Error
hi def link sclCondError    Error
hi def link sclLoopError    Error
hi def link sclVBlockError  Error



" examples:
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

