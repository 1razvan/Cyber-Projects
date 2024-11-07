#include <stdio.h>
#include <math.h>

int bin_search(int *arr,int lb, int ub, int x){

	int mid=floor((lb+ub)/2);

	if (x==arr[mid]){
		return mid;
	}

	else if (x<arr[mid] && lb < mid){
		return bin_search(arr,lb, mid-1, x);
	}
	
	else if (x>arr[mid] && ub > mid){
		return bin_search(arr,mid+1, ub, x);
	}
	else {
		return -1;
	}
}

int main(){

	int nums[12]={1,2,12,15,16,27,38,49,50,61,82,97};

	for (int z=0;z<12;z++){
		printf("%d ",nums[z]);
	}

	printf("\n");

	int srch;

	printf("Enter your search: ");
	scanf("%d", &srch);

 	int ans=bin_search(nums,0,sizeof(nums) / sizeof(nums[0]),srch);
	
	if (ans!=-1){
		printf("Your search was found in position: %d \n",ans);
	}
	else {
		printf("Your search was not found. \n");
	}
}

