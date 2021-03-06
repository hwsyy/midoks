%{
// Copyright (c) 2011 CZ.NIC z.s.p.o. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// blame: jnml, labs.nic.cz


package main

import (
    "bufio"
    "log"
    "fmt"
)

type yylexer struct{
    src     *bufio.Reader
    buf     []byte
    token   int
    empty   bool
    current byte
}

func newLexer(src *bufio.Reader) (y *yylexer) {
    y = &yylexer{src: src}
    if b, err := src.ReadByte(); err == nil {
        y.current = b
    }
    return
}

func (y *yylexer) getc() byte {
    if y.current != 0 {
        y.buf = append(y.buf, y.current)
    }
    y.current = 0
    if b, err := y.src.ReadByte(); err == nil {
        y.current = b
    }
    return y.current
}

func (y yylexer) Error(e string) {
    log.Fatal(e)
}


func (y *yylexer) Lex(lval *yySymType) int {
    // var err error
    c := y.current
    if y.empty {
        c, y.empty = y.getc(), false
    }
%}

%yyc c
%yyn c = y.getc()


LNUM    [0-9]+
DNUM    ([0-9]*"."[0-9]+)|([0-9]+"."[0-9]*)
EXPONENT_DNUM   (({LNUM}|{DNUM})[eE][+-]?{LNUM})
HNUM    "0x"[0-9a-fA-F]+
BNUM    "0b"[01]+
LABEL   [a-zA-Z_\x80-\xff][a-zA-Z0-9_\x80-\xff]*
WHITESPACE [ \n\r\t]+
TABS_AND_SPACES [ \t]*
TOKENS [;:,.\[\]()|^&+-/*=%!~$<>?@]
ANY_CHAR [^]
NEWLINE ("\r"|"\n"|"\r\n")

%%
    y.buf = y.buf[:0]   // The code before the first rule executed before every scan cycle (rule #0 / state 0 action)

[ \t\n\r]+

exit                    fmt.Printf("TOKEN:%q\n", y.buf)
                        return T_EXIT
die                     fmt.Printf("TOKEN:%q\n", y.buf)
function                fmt.Printf("TOKEN:%q\n", y.buf)
const                   fmt.Printf("TOKEN:%q\n", y.buf)
return                  fmt.Printf("TOKEN:%q\n", y.buf)
yield{WHITESPACE}from[\^a-zA-Z0-9_\x80-\xff] 
                        fmt.Printf("TOKEN:%q\n", y.buf)
yield                   fmt.Printf("TOKEN:%q\n", y.buf)
try                     fmt.Printf("TOKEN:%q\n", y.buf)
catch                   fmt.Printf("TOKEN:%q\n", y.buf)
finally                 fmt.Printf("TOKEN:%q\n", y.buf)
throw                   fmt.Printf("TOKEN:%q\n", y.buf)
if                      fmt.Printf("TOKEN:%q\n", y.buf)
elseif                  fmt.Printf("TOKEN:%q\n", y.buf)
endif                   fmt.Printf("TOKEN:%q\n", y.buf)
else                    fmt.Printf("TOKEN:%q\n", y.buf)
while                   fmt.Printf("TOKEN:%q\n", y.buf)
endwhile                fmt.Printf("TOKEN:%q\n", y.buf)
do                      fmt.Printf("TOKEN:%q\n", y.buf)
for                     fmt.Printf("TOKEN:%q\n", y.buf)
endfor                  fmt.Printf("TOKEN:%q\n", y.buf)
foreach                 fmt.Printf("TOKEN:%q\n", y.buf)
endforeach              fmt.Printf("TOKEN:%q\n", y.buf)
declare                 fmt.Printf("TOKEN:%q\n", y.buf)
enddeclare              fmt.Printf("TOKEN:%q\n", y.buf)
instanceof              fmt.Printf("TOKEN:%q\n", y.buf)
as                      fmt.Printf("TOKEN:%q\n", y.buf)
switch                  fmt.Printf("TOKEN:%q\n", y.buf)
endswitch               fmt.Printf("TOKEN:%q\n", y.buf)
case                    fmt.Printf("TOKEN:%q\n", y.buf)
default                 fmt.Printf("TOKEN:%q\n", y.buf)
break                   fmt.Printf("TOKEN:%q\n", y.buf)
continue                fmt.Printf("TOKEN:%q\n", y.buf)
goto                    fmt.Printf("TOKEN:%q\n", y.buf)
echo                    fmt.Printf("TOKEN:%q\n", y.buf)
print                   fmt.Printf("TOKEN:%q\n", y.buf)
class                   fmt.Printf("TOKEN:%q\n", y.buf)
interface               fmt.Printf("TOKEN:%q\n", y.buf)
trait                   fmt.Printf("TOKEN:%q\n", y.buf)
extends                 fmt.Printf("TOKEN:%q\n", y.buf)
implements              fmt.Printf("TOKEN:%q\n", y.buf)

new                     fmt.Printf("TOKEN:%q\n", y.buf)
clone                   fmt.Printf("TOKEN:%q\n", y.buf)
var                     fmt.Printf("TOKEN:%q\n", y.buf)

eval                    fmt.Printf("TOKEN:%q\n", y.buf)
include                 fmt.Printf("TOKEN:%q\n", y.buf)
include_once            fmt.Printf("TOKEN:%q\n", y.buf)
require                 fmt.Printf("TOKEN:%q\n", y.buf)
require_once            fmt.Printf("TOKEN:%q\n", y.buf)

namespace               fmt.Printf("TOKEN:%q\n", y.buf)
use                     fmt.Printf("TOKEN:%q\n", y.buf)

insteadof               fmt.Printf("TOKEN:%q\n", y.buf)
global                  fmt.Printf("TOKEN:%q\n", y.buf)
isset                   fmt.Printf("TOKEN:%q\n", y.buf)
empty                   fmt.Printf("TOKEN:%q\n", y.buf)
__halt_compiler         fmt.Printf("TOKEN:%q\n", y.buf)
static                  fmt.Printf("TOKEN:%q\n", y.buf)
abstract                fmt.Printf("TOKEN:%q\n", y.buf)
final                   fmt.Printf("TOKEN:%q\n", y.buf)
private                 fmt.Printf("TOKEN:%q\n", y.buf)
protected               fmt.Printf("TOKEN:%q\n", y.buf)
public                  fmt.Printf("TOKEN:%q\n", y.buf)
unset                   fmt.Printf("TOKEN:%q\n", y.buf)
list                    fmt.Printf("TOKEN:%q\n", y.buf)
array                   fmt.Printf("TOKEN:%q\n", y.buf)
callable                fmt.Printf("TOKEN:%q\n", y.buf)


\+\+                    fmt.Printf("TOKEN:%q\n", y.buf)
\-\-                    fmt.Printf("TOKEN:%q\n", y.buf)
===                     fmt.Printf("TOKEN:%q\n", y.buf)
!==                     fmt.Printf("TOKEN:%q\n", y.buf)
==                      fmt.Printf("TOKEN:%q\n", y.buf)
(!=|<>)                 fmt.Printf("TOKEN:%q\n", y.buf)
\<\=\>                  fmt.Printf("TOKEN:%q\n", y.buf)
\<\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\>\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\+\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\-\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\*\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\*\*                    fmt.Printf("TOKEN:%q\n", y.buf)
\*\*\=                  fmt.Printf("TOKEN:%q\n", y.buf)
\/\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\.\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\%\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\<\<\=                  fmt.Printf("TOKEN:%q\n", y.buf)
\>\>\=                  fmt.Printf("TOKEN:%q\n", y.buf)
\&\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\|\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\^\=                    fmt.Printf("TOKEN:%q\n", y.buf)
\|\|                    fmt.Printf("TOKEN:%q\n", y.buf)

\&\&                    fmt.Printf("TOKEN:%q\n", y.buf)
OR                      fmt.Printf("TOKEN:%q\n", y.buf)
AND                     fmt.Printf("TOKEN:%q\n", y.buf)
XOR                     fmt.Printf("TOKEN:%q\n", y.buf)
\<\<                    fmt.Printf("TOKEN:%q\n", y.buf)
\>\>                    fmt.Printf("TOKEN:%q\n", y.buf)
{TOKENS}                fmt.Printf("TOKEN:%q\n", y.buf)

{                       fmt.Printf("TOKEN:%q\n", y.buf)
\${                     fmt.Printf("TOKEN:%q\n", y.buf)
}                       fmt.Printf("TOKEN:%q\n", y.buf)
{LABEL}[[}]             fmt.Printf("TOKEN-LABEL2:%q\n", y.buf)



{BNUM}                  fmt.Printf("TOKEN-BNUM:%q\n", y.buf)
{LNUM}                  fmt.Printf("TOKEN-LNUM:%q\n", y.buf)
{HNUM}                  fmt.Printf("TOKEN-HNUM:%q\n", y.buf)
{DNUM}|{EXPONENT_DNUM}  fmt.Printf("TOKEN-HNUM:%q\n", y.buf)

__CLASS__               fmt.Printf("TOKEN:%q\n", y.buf)
__TRAIT__               fmt.Printf("TOKEN:%q\n", y.buf)
__FUNCTION__            fmt.Printf("TOKEN:%q\n", y.buf)
__METHOD__              fmt.Printf("TOKEN:%q\n", y.buf)
__LINE__                fmt.Printf("TOKEN:%q\n", y.buf)
__FILE__                fmt.Printf("TOKEN:%q\n", y.buf)
__DIR__                 fmt.Printf("TOKEN:%q\n", y.buf)
__NAMESPACE__           fmt.Printf("TOKEN:%q\n", y.buf)




->                      fmt.Printf("TOKEN:%q\n", y.buf)
=>                      fmt.Printf("TOKEN:%q\n", y.buf)

\${LABEL}\-\>[a-zA-Z_\x80-\xff]      
                        fmt.Printf("TOKEN:%q\n", y.buf)
\${LABEL}\[             fmt.Printf("TOKEN:%q\n", y.buf)
\${LABEL}               fmt.Printf("TOKEN:%q\n", y.buf)
{LABEL}                 fmt.Printf("TOKEN:%q\n", y.buf)

{TOKENS}|[{}"`]         fmt.Printf("TOKEN:%q\n", y.buf)

\#|\/\/          
                        for {
                            c = y.getc()
                            switch c {
                                case '\n':
                                    y.token = T_COMMENT
                                    //fmt.Printf("TOKEN:%q,pos:%d\n", y.buf,y.current)
                                    goto label_loop
                                default:
                                    continue
                            }
                        }
                        label_loop:

(\/\*|\/\*\*){WHITESPACE}

                        for {
                            c = y.getc()
                            if ( c == '*' ){
                                c = y.getc()
                                if ( c == '/' ){  
                                    y.getc()
                                    fmt.Printf("TOKEN-SS:%q,pos:%d\n", y.buf,y.current)
                                    break
                                }
                            }
                        }

::                      fmt.Printf("TOKEN:%q\n", y.buf)
\\                      fmt.Printf("TOKEN:%q\n", y.buf)
\.\.\.                  fmt.Printf("TOKEN:%q\n", y.buf)
\?\?                    fmt.Printf("TOKEN:%q\n", y.buf)

({TABS_AND_SPACES}(int|integer){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(real|double|float){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(string|binary){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(array){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(object){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(bool|boolean){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)
({TABS_AND_SPACES}(unset){TABS_AND_SPACES})
                        fmt.Printf("TOKEN:%q\n", y.buf)

\<\?\=                  fmt.Printf("TOKEN:%q\n", y.buf)
\<\?php                 fmt.Printf("TOKEN:%q\n", y.buf)
\?>                     fmt.Printf("TOKEN:%q\n", y.buf)

[ \n\r\t\\\'\#]         fmt.Printf("TOKEN:%q\n", y.buf)

.                       fmt.Printf("char:%q\n", y.buf)
\0                      fmt.Printf("end\n")
                        y.token = END
                        return 0

%%
    y.empty = true
    return int(y.token)
}
