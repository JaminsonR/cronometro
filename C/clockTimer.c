#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>

void myclock();
void timer(int num);
int main(void) 
{
	int option;
	printf("Select an option: \n1.-Clock\n2.-Timer\n\n"); //Print out menu
	scanf("%d",&option); 
	if (option==1){
		myclock();
	}
	else{
		int minute;
		printf("Input the amount of minutes to count: \n"); 
		scanf("%d",&minute);
		timer(minute);
	}
   return EXIT_SUCCESS; 
}

void timer(int min){	//timer function
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
	printf("Timer has been completed!!\n");
}

void myclock(){    	//clock function
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
       

