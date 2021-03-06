" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword terraSection connection output provider variable
syn keyword terraValueBool true false on off yes no

""" resource

syn keyword terraResourceTypeBI RESOURCES
syn keyword terraDataSourceTypeBI DATA_SOURCES

syn keyword terraTodo         contained TODO FIXME XXX BUG
syn cluster terraCommentGroup contains=terraTodo
syn region  terraComment      start="/\*" end="\*/" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="#" end="$" contains=@terraCommentGroup,@Spell

syn match  terraResource        /\<resource\>/ nextgroup=terraResourceTypeStr skipwhite
syn region terraResourceTypeStr start=/"/ end=/"/ contains=terraResourceTypeBI
                              \ nextgroup=terraResourceName skipwhite
syn region terraResourceName    start=/"/ end=/"/
                              \ nextgroup=terraResourceBlock skipwhite

syn match  terraDataSource        /\<data\>/ nextgroup=terraDataSourceTypeStr skipwhite
syn region terraDataSourceTypeStr start=/"/ end=/"/ contains=terraDataSourceTypeBI
                                  \ nextgroup=terraDataSourceName skipwhite
syn region terraDataSourceName    start=/"/ end=/"/
                                  \ nextgroup=terraDataSourceBlock skipwhite
""" provider
syn match  terraProvider      /\<provider\>/ nextgroup=terraProviderName skipwhite
syn region terraProviderName  start=/"/ end=/"/ nextgroup=terraProviderBlock skipwhite

""" misc.
syn match terraValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match terraValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match	terraBraces	       "[{}\[\]]"

syn region terraValueString  start=/\\\@<!"/    end=/\\\@<!"/    contains=terraStringInterp
syn region terraStringInterp matchgroup=terraBrackets start=/\${/  end=/}/ contained
                           \ contains=terraStringInterp

hi def link terraComment           Comment
hi def link terraTodo              Todo
hi def link terraBrackets          Operator
hi def link terraProvider          Structure
hi def link terraBraces            Delimiter
hi def link terraProviderName      String
hi def link terraResource          Structure
hi def link terraResourceName      String
hi def link terraResourceTypeBI    Tag
hi def link terraResourceTypeStr   String
hi def link terraDataSource        Structure
hi def link terraDataSourceName    String
hi def link terraDataSourceTypeBI  Tag
hi def link terraDataSourceTypeStr String
hi def link terraSection           Structure
hi def link terraStringInterp      Identifier
hi def link terraValueBool         Boolean
hi def link terraValueDec          Number
hi def link terraValueHexaDec      Number
hi def link terraValueString       String

let b:current_syntax = "terraform"
