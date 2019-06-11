import java_cup.runtime.*;

%%
%class Lexer
%unicode
%line
%column
%cup

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

%}
Boolean = (T | F)
SecureType = (H | L)
Letter = [A-Za-z]
Digit = [0-9]
Punctuation = [\"#%\'\-\.\/:&;<>\?()@\[\]\*\+\,\\\^_`{}]
Character = '{Letter}' | '{Digit}' | '{Punctuation}' 
Denominator = {Digit}{Digit}* //zero can be a denominator 
Integer = 0|[1-9]{Digit}*
Float = {Integer}(\.{Digit}*)?
Rational = ({Integer}_){Digit}"/"{Denominator} | {Integer}"/"{Denominator}
Number = {Integer} | {Float} | {Rational} 
EOL = \r|\n|\r\n //end of line
IdentifierChar = {Letter} | {Digit} | _
Identifier = {Letter}({IdentifierChar})*
SingleCommentChar = [^\r\n]
Whitespace     = {EOL} | [ \t]
String = \"([^\"])*\" //cant identify strings with quotes in them
MultiLineComment = "/#" [^#]* "#/"
SingleLineComment = "#" {SingleCommentChar}* {EOL}?
Comment = {MultiLineComment} | {SingleLineComment}

%%

<YYINITIAL> {
    ";"                {return symbol(sym.SEMICOLON);}
    ":"                {return symbol(sym.COLON);}
    ":="               {return symbol(sym.ASSIGN);}
    "="                {return symbol(sym.EQ);}
    "!="               {return symbol(sym.NOTEQ);}
    "&&"               {return symbol(sym.AND);}
    "||"               {return symbol(sym.OR);}
    "!"                {return symbol(sym.NOT);}
    ","                {return symbol(sym.COMMA);}
    "+"                {return symbol(sym.PLUS);}
    "-"                {return symbol(sym.MINUS);}
    "*"                {return symbol(sym.MULTIPLY);}
    "/"                {return symbol(sym.DIVIDE);}
    "^"                {return symbol(sym.UPARROW);}
    "::"               {return symbol(sym.CONCATONATION);}
    "."                {return symbol(sym.DOT);}
    "len"              {return symbol(sym.LENGTH);} 
    "int"              {return symbol(sym.INTTYPE);}
    "char"             {return symbol(sym.CHARTYPE);}
    "rat"              {return symbol(sym.RATTYPE);}
    "float"            {return symbol(sym.FLOATTYPE);}
    "seq"              {return symbol(sym.SEQUENCETYPE);}
    "bool"             {return symbol(sym.BOOLTYPE);}
    "main"             {return symbol(sym.MAIN);}
    "top"              {return symbol(sym.TOP);}
    "in"               {return symbol(sym.IN);}
    "alias"            {return symbol(sym.ALIAS);}
    "then"             {return symbol(sym.THEN);}
    "else"             {return symbol(sym.ELSE);}
    "read"             {return symbol(sym.READ);}
    "print"            {return symbol(sym.PRINT);}
    "return"           {return symbol(sym.RETURN);}
    "break"            {return symbol(sym.BREAK);}
    "if"               {return symbol(sym.IF);}
    "fi"               {return symbol(sym.FI);}
    "loop"             {return symbol(sym.LOOP);}
    "pool"             {return symbol(sym.POOL);}
    "tdef"             {return symbol(sym.TYPEDEFINITION);}
    "fdef"             {return symbol(sym.FUNCTIONDEFINITION);}
    "("                {return symbol(sym.LPAREN);}
    ")"                {return symbol(sym.RPAREN);}
    "{"                {return symbol(sym.LBRACE);}
    "}"                {return symbol(sym.RBRACE);}
    "["                {return symbol(sym.LBRACKET);}
    "]"                {return symbol(sym.RBRACKET);}
    "<="               {return symbol(sym.LTEQ);}
    ">="               {return symbol(sym.GTEQ);}
    "<"                {return symbol(sym.LT);}
    ">"                {return symbol(sym.GT);}    
    {Boolean}          {return symbol(sym.BOOLEAN);}
    {SecureType}       {return symbol(sym.SECURETYPE);}
    {Character}        {return symbol(sym.CHARACTER);}
    {String}           {return symbol(sym.STRING);}
    {Number}           {return symbol(sym.NUMBER);}
    {Identifier}       {return symbol(sym.IDENTIFIER);}
    {Comment}          {} //does nothing
    {Whitespace}       {} //does nothing 
}

[^]  {
  System.out.println("file:" + (yyline+1) +
    ":0: Error: Invalid input '" + yytext()+"'");
  return symbol(sym.SYNTAXERROR);
}
