#include <stdio.h>
#include <stddef.h>
#include <math.h>

int main(){
	int arr[12] = {1,2,12,15,16,27,38,49,50,61,82,97};
	
	for (int i=0; i<12; i++){
		printf("%d ",arr[i]);
	}

	printf("\n");
	
	int search;
	int lb = 0;
	size_t ub = sizeof(arr) / sizeof(arr[0]);
	int mid;	
	int pos = -1;
	printf("Enter your search number: ");
	scanf("%d", &search);
	while (lb<=ub && pos==-1){
		mid=floor((lb+ub)/2);
//		printf("lb: %d \n ub: %ld \n mid: %d \n",lb,ub,mid);
		if (search < arr[mid]){
			ub=mid-1;
		}
		if (search > arr[mid]){
			lb=mid+1;
		}
                if (search == arr[mid]){
                        pos=mid;
                }
	}
	if (pos!=-1){
		printf("The item was found in position: %d \n", pos);
	}
	else{
		printf("The item was not found.\n");
	}
}
