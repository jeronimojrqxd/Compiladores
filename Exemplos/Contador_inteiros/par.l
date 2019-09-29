inteiro [0-9]

%{
	#include <iostream>
	using namespace std;
	int cont = 0;
	string inteiros;
%}


%%

{inteiro}* { 
	cont++ ;
	inteiros += yytext;
	inteiros += " ";	

}

. ;
%%


int main(){
	yylex();
	cout << "Quantidade de inteiros: " << cont << endl;
	cout << "Inteiros: " << inteiros << endl;
}
