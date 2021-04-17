flex lex.l
bison -d bison_parser.y
gcc lex.yy.c bison_parser.tab.c -lfl -o executabil.exe
./executabil.exe < test.py
