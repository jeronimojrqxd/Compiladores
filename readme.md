## Compiladores

Objetivo
Exercitar os conhecimentos na criação de scanners utilizando exclusivamente a ferramenta Lex.

Problema
Você deve implementar um scanner que faça a leitura de arquivos fontes na linguagem C. Seu scanner deve recuperar o tipo e o nome de cada variável e função, depois imprimir na tela um resumo da informação encontrada. 

Exemplo
Considere o seguinte código fonte em C, armazenado no arquivo newton.c.
#include
#include
float f(float x) {
  return x*log10(x) - 1.2;
}
float df(float x) {
  return log10(x) + 0.43429;
}
int main() {
  int itr, maxmitr;
  float h, x0, x1, allerr;
  printf("\nForneça x0, erro permitido e número máximo de iterações\n");
  scanf("%f %f %d", &x0, &allerr, &maxmitr);
  for (itr=1; itr<=maxmitr; itr++){
     h=f(x0)/df(x0);
     x1=x0-h;
     printf(" Na iteração %3d, x = %9.6f\n", itr, x1);
     if (fabs(h) < allerr) {
        printf("Após %3d iterações, raiz = %8.6f\n", itr, x1);
        return 0;
     }
     x0 = x1;
  }
  printf(" A solução esperada não converge ou as iterações não são suficientes\n");
  return 1;
}

Seu programa deve produzir a seguinte saída, ao ser construído usando o Lex:
$ lex identificadores.l
$ gcc lex.yy.c -o identificadores
$ ./identificadores newton.c
Variáveis Inteiras:
 itr maxmitr
Total de Variáveis Inteiras: 2
Variáveis Ponto Flutuante:
 x x h x0 x1 allerr
Total de Variáveis Ponto Flutuante: 6
Funções Inteiras:
 main
Total de Funções Inteiras: 1
Funções Ponto Flutuante:
 f df
Total de Funções Ponto Flutuante: 2

Observe que os parâmetros das funções também são avaliados e computados, mesmo que tenham o mesmo nome de outras variáveis. 
