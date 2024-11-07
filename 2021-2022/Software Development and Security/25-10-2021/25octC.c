#include <stdio.h>

int main(){
	int x[5]={1,2,3,4,5};
	int len=sizeof(x)/sizeof(x[0]);
	for (int i=0; i<len; ++i){
		printf("%i",i);
	}
}
