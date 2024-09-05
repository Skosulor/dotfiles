if exists("b:current_syntax")
    finish
endif

" Define keywords
syn keyword mylangKeyword var

" Define logical operators
syn match mylangOperator /\&\&\|\|/
syn match mylangOperator /&&/
syn match mylangOperator /||/
syn match mylangOperator /&/
syn match mylangOperator /|/

" Define comments (// comment)
syn match mylangComment "//.*$"

" Define strings using double quotes
syn match mylangString /"[^"]*"/

" Highlight groups
hi link mylangKeyword Keyword
hi link mylangOperator Operator
hi link mylangComment Comment
hi link mylangString String

let b:current_syntax = "mathematical"
