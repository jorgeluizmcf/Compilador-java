%%
// Define a classe gerada pelo JFlex
%class Scanner
%unicode
%cup

// Estados de comentário
%state COMMENT

%%

// Palavras-chave
"if"      { return new Symbol(sym.IF); }
"else"    { return new Symbol(sym.ELSE); }
"while"   { return new Symbol(sym.WHILE); }
"return"  { return new Symbol(sym.RETURN); }

// Identificadores (variáveis e funções)
[a-zA-Z_][a-zA-Z0-9_]* { return new Symbol(sym.IDENTIFIER, yytext()); }

// Constantes (números inteiros e reais)
[0-9]+                 { return new Symbol(sym.INT_LITERAL, Integer.parseInt(yytext())); }
[0-9]+"."[0-9]+        { return new Symbol(sym.FLOAT_LITERAL, Float.parseFloat(yytext())); }

// Operadores
"+"    { return new Symbol(sym.PLUS); }
"-"    { return new Symbol(sym.MINUS); }
"*"    { return new Symbol(sym.MULTIPLY); }
"/"    { return new Symbol(sym.DIVIDE); }
"=="   { return new Symbol(sym.EQUALS); }
"!="   { return new Symbol(sym.NOT_EQUALS); }

// Delimitadores
";"    { return new Symbol(sym.SEMICOLON); }
","    { return new Symbol(sym.COMMA); }
"{"    { return new Symbol(sym.LCURLY); }
"}"    { return new Symbol(sym.RCURLY); }
"("    { return new Symbol(sym.LPAREN); }
")"    { return new Symbol(sym.RPAREN); }

// Comentários
"//".*                   { /* Ignora comentários de linha única */ }
"/*"                    { yybegin(COMMENT); }
<COMMENT>"*/"           { yybegin(YYINITIAL); }
<COMMENT>.|\n           { /* Ignora caracteres dentro de comentários */ }

// Espaços em branco
[ \t\r\n]+              { /* Ignora espaços, tabulações e quebras de linha */ }

// Caracteres inválidos
.                       { System.err.println("Caractere inválido: " + yytext()); }

