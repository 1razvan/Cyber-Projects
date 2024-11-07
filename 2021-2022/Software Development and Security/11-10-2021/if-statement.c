#include <stdio.h>

char test(char x); // declaring function

int main(){
	printf("What is my favourite character? ");
        char word; //string declaration
        scanf("%c", &word); // input for string
	test(word); // calling function

}

char test(char x){
	const char y = 'a'; //declaring const
	if (y==x){ //compares y local char to parameter char
		printf("My favourite character is %c\n", y);
	}
	else{
		printf("That is not my favourite character!\n");
	}
}


