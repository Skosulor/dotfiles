if exists("b:current_syntax")
    finish
endif

" Define keywords (add 'if' and 'else' to the list)
syn keyword mathematicalKeyword var if else while

" Define logical operators
syn match mathematicalOperator /\&\&\|\|/
syn match mathematicalOperator /or/
syn match mathematicalOperator /and/
syn match mathematicalOperator /&/
syn match mathematicalOperator /|/

" Define comments (// comment)
syn match mathematicalComment "//.*$"

" Define strings using double quotes
syn match mathematicalString /"[^"\\]*\(\\.[^"\\]*\)*/

" Highlight groups
hi link mathematicalKeyword Keyword
hi link mathematicalOperator Operator
hi link mathematicalComment Comment
hi link mathematicalString String

let b:current_syntax = "mathematical"
