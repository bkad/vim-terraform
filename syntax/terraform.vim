" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword terraSection connection output provider variable
syn keyword terraValueBool true false on off yes no

""" resource

" find . -name "resource_*.go" -not -name "resource_*_test.go" -not -name "resource_provider.go" | sed 's/.*\/resource_//; s/\.go$//'
syn keyword terraResourceTypeBI
          \ aws_autoscaling_group           aws_security_group
          \ aws_db_instance                 aws_subnet
          \ aws_db_security_group           aws_vpc
          \ aws_eip                         cloudflare_record
          \ aws_elb                         consul_keys
          \ aws_instance                    digitalocean_domain
          \ aws_internet_gateway            digitalocean_droplet
          \ aws_launch_configuration        digitalocean_record
          \ aws_route53_record              dnsimple_record
          \ aws_route53_zone                heroku_addon
          \ aws_route_table                 heroku_app
          \ aws_route_table_association     heroku_domain
          \ aws_s3_bucket                   heroku_drain
          \
          \ contained

syn keyword terraTodo         contained TODO FIXME XXX BUG
syn cluster terraCommentGroup contains=terraTodo
syn region  terraComment      start="/\*" end="\*/" contains=@terraCommentGroup,@Spell
syn region  terraComment      start="#" end="$" contains=@terraCommentGroup,@Spell

syn match  terraResource        /resource/ nextgroup=terraResourceTypeStr skipwhite
syn region terraResourceTypeStr start=/"/ end=/"/ contains=terraResourceTypeBI
                              \ nextgroup=terraResourceName skipwhite
syn region terraResourceName    start=/"/ end=/"/
                              \ nextgroup=terraResourceBlock skipwhite
syn region terraResourceBlock   start=/{/ end=/}/ fold
                              \ contains=@terraConfigItem,@terraComment

""" provider
syn match  terraProvider      /provider/ nextgroup=terraProviderName skipwhite
syn region terraProviderName  start=/"/ end=/"/ nextgroup=terraProviderBlock skipwhite
syn region terraProviderBlock start=/{/ end=/}/ fold contains=@terraConfigItem

""" misc.
syn match terraAssignment    "\<[a-z][a-z0-9_-]*\>" contained skipwhite
                             \ nextgroup=terraAssignmentOp
syn match terraAssignmentOp  "=" nextgroup=@terraValue skipwhite
syn match terraValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match terraValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"

syn region terraValueString  start=/"/    end=/"/    contains=terraStringInterp
syn region terraStringInterp matchgroup=terraBrackets start=/\${/  end=/}/ contained

syn cluster terraConfigItem contains=terraAssignment
syn cluster terraBlock      contains=terraProviderBlock,terraResourceBlock
syn cluster terraValue      contains=terraValueBool,terraValueDec,
                                    \terraValueHexaDec,terraValueString

hi def link terraComment           Comment
hi def link terraTodo              Todo
hi def link terraAssignment        Identifier
hi def link terraAssignmentOp      Operator
hi def link terraBrackets          Operator
hi def link terraProvider          Structure
hi def link terraProviderBlock     Delimiter
hi def link terraProviderName      String
hi def link terraResource          Structure
hi def link terraResourceBlock     Delimiter
hi def link terraResourceName      String
hi def link terraResourceTypeBI    Tag
hi def link terraResourceTypeStr   String
hi def link terraSection           Structure
hi def link terraStringInterp      Identifier
hi def link terraValueBool         Boolean
hi def link terraValueDec          Number
hi def link terraValueHexaDec      Number
hi def link terraValueString       String

let b:current_syntax = "terraform"
