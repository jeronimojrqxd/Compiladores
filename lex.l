digito [0-9]
letter [A-Za-z]

%{
	#include <iostream>
	#include <vector>
	#include <string>
	#include <stdio.h>
	#include <sstream>
	using namespace std;

	int ffcont, ficont, vfcont, vicont;
	string ffaux, fiaux, vfaux, viaux, ffaux2, pf, pi;
	vector<string> vet_func_float;
	vector<string> vet_func_int;
	vector<string> vet_var_int;
	vector<string> vet_var_float;
	vector<string> vet_par_float;
	vector<string> vet_par_int;
	

%}


%%


float[ |\t]{letter}({letter}|{digito}|"_")*" "*"(" {
	ffcont++;
	ffaux += yytext;
	ffaux += " "; 
}

int[ |\t]{letter}({letter}|{digito}|"_")*" "*"(" {
	ficont++;
	fiaux += yytext;
	fiaux += " ";
}

int[ |\t]+{letter}({letter}|{digito}|,|" "|"_")*";" {
	viaux += yytext;
}

float[ |\t]+{letter}({letter}|{digito}|","|" "|"_")*";" {
	vfaux += yytext;
}


float" "{letter}({letter}|{digito}|","|" "|";"|"_")* {
	pf += yytext;
	pf += " ";
}

int" "{letter}({letter}|{digito}|","|" "|";"|"_")* {
	pi += yytext;
	pi += " ";
	
}

. ;

%%



vector<string> tratar_funcao(int n, string tipo){
    string token, t;
    vector<string> vet;
    stringstream ss(tipo);
    
    while(getline(ss, token, '(')){
        vet.push_back(token);
    }
    token.clear();

    for(int i = 0; i < (int) vet.size(); i++){
        t = vet[i];
        for(int j = n; j < (int)t.length(); j++){
            token += t[j]; 
        }
        vet[i] = token;
        token.clear();
    }
	return vet;
}

vector<string> tratar_variavel(int n, string tipo){
    string token, aux;
    vector<string> generico;
  
   for(int i = n; i < (int)tipo.size()-1; i++){
       if(viaux[i] != ' ')
            aux += tipo[i];
   }

    stringstream ss(aux);

    while(getline(ss, token, ',')){
        generico.push_back(token);
    }
	return generico;
}

vector<string> parametro(string tipo){
 	vector<string> vet;
	string token, token2;
    
	if(tipo == "float"){
	    for(int i = 0; i <(int) pf.size(); i++){
		if((pf[i] == 'f') && (pf[i+1] == 'l') && (pf[i+2] == 'o') && (pf[i+3] == 'a') && (pf[i+4] == 't')){
		    i += 5;
		}
		token += pf[i];
	    }
	}else if(tipo == "int"){
		for(int i = 0; i <(int) pi.size(); i++){
			if((pi[i] == 'i') && (pi[i+1] == 'n') && (pi[i+2] == 't')){
		    i += 3;
		}
		token += pi[i];
	    }
	
	}

    
    for(int i = 0; i < (int)token.size(); i++){
	while(token[i] != ' '){
		token2 += token[i];
		i++;
		if(token[i] == ' '){
			token2 += ' ';
			break;	
		}		
	}
    }
	stringstream ss(token2);
    while(getline(ss, token2, ' ')){
        vet.push_back(token2);
    }

    token2.clear();
    string aux;

    for(int i = 0; i < (int)vet.size(); i++){
        aux = vet[i];
        for(int j = 0; j < (int)aux.size(); j++){
            if(aux[j] != ' ')
                token2 += aux[j];
        }
        vet[i] = token2;
        token2.clear();
    }
	return vet;
 }

void show(vector<string> vet){
	for(int i = 0; i < (int) vet.size(); i++){
		cout << vet[i] << " ";
	}
}


int main(){
	yylex();
	

	vet_func_int = tratar_funcao(4, fiaux);
	vet_func_float = tratar_funcao(6, ffaux);
	vet_var_int = tratar_variavel(4, viaux);
	vet_var_float = tratar_variavel(6, vfaux);
	
	if(pi.size() > 4)
 		vet_par_int = parametro("int");
	
	if(pf.size() > 6)
 		vet_par_float = parametro("float");
	
	  	
	cout << "Variáveis Inteiras:" << endl;
	show(vet_par_int);
	show(vet_var_int);
	cout << "\nTotal de Variáveis Inteiras: "<< vet_var_int.size() + vet_par_int.size() << endl << endl;

	cout << "Variáveis Ponto Flutuante:" << endl;
	show(vet_par_float);
	show(vet_var_float);
	cout << "\nTotal de Variáveis Ponto Flutuante: " << vet_var_float.size() + vet_par_float.size()  << endl << endl;

	cout << "Funções Inteiras:" << endl;
	show(vet_func_int);
	cout << "\nTotal de Funções Inteiras: " << ficont << endl << endl;

	cout << "Funções de Ponto Flutuante:" << endl;
	show(vet_func_float);
	cout << "\nTotal de Funções Ponto Flutuante: " << ffcont << endl << endl;

	
		
	return(0);
}
