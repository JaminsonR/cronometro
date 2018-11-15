#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

void reloj();
void temporizador(int num);
int main(void) 
{
	int numero;
	printf("Ingrese una opcion: \n1.-Reloj\n2.-Temporizador\n"); 
	scanf("%d",&numero); 
	if (numero==1){
		reloj();
	}
	else{
		int minuto;
		printf("Ingrese minutos: "); 
		scanf("%d",&minuto);
		temporizador(minuto);
	}
   return EXIT_SUCCESS; 
}

void temporizador(int min){
	int s;
	int m;
	int h;
	s=m=h=0;

	 while (m < min){ 
      		if (s == 60){ 
         		m++; 
         		s = 0; 
      		} 

      		if (m == 60){ 
         		h++; 
        	 	m = 0; 
      		} 
      
      	printf("%02d:%02d:%02d\n", h, m, s); 
      	sleep(1.5); 
      	s++; 
   	} 
}

void reloj(){
	int s;
        int m;
        int h;
       
	for(h=0; h<24; h++){
		for(m=0; m<60; m++){
                	for(s=0; s<60; s++){
        			printf("%02d:%02d:%02d\n", h, m, s); 
        			sleep(1.5); 
        }
        }        
        }	
} 
       

