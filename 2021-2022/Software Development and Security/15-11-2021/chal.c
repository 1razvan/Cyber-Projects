#include<stdio.h>
void main(){
	char arr[2]={'\0','\0','8'};
	for (int i = 0; i<sizeof(arr); i++){
		if (i==sizeof(arr)-1){
			printf("%c\n",arr[i]);	
		}
	}
}


//127 0 8
