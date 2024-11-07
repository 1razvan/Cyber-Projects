#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <limits.h>
#define MAX_NAME_SZ 256
int main(){
	while (1){
		char *inp = malloc(MAX_NAME_SZ);
		if (inp == NULL) {
			printf("No memory\n");
			return 1;
		}
	// making shell line show user@hostname <path>
		char cwd[PATH_MAX];
		getcwd(cwd,sizeof(cwd));
		char hostname[PATH_MAX];
		gethostname(hostname,sizeof(hostname));
		char user[PATH_MAX];
		getlogin_r(user,sizeof(user));
	// printing the shell line described above
	        printf("\033[1;32m%s@%s\033[0m:",user, hostname);
		printf("\033[1;34m%s\033[0m",cwd);
		printf("$ ");
	//handling input
		fgets(inp, MAX_NAME_SZ, stdin);
		if ((strlen(inp) > 0) && (inp[strlen(inp)-1] == '\n')){
				inp[strlen(inp)-1]='\0';
		} //change new line to null at the end of the input
		if (strcmp(inp,"exit")==0){
			return 0;			
			exit(0);
		} //if exit is called, exit shell
	// separating the shell input by space, tokenizing them
		char delim[] = " ";
		char *ptr = strtok(inp, delim);
		char *exec_args[10];
		int i,j,k;
	// making all ten spaces in the array (null)
		for (i=0; i<10; i++){
			exec_args[i]="(null)";
		}
	// overwriting the null spaces with input tokens
		int count = 0;
		while(ptr != NULL){
			exec_args[count]=ptr;
			count+=1;
			ptr = strtok(NULL, delim);
		}
		int flag = -1;
		for (k=0; k<10; k++){ 
			if ((exec_args[k]=="(null)") && (flag==-1)) {
				flag=k;
			}
		} // when the commands end and it reaches a null, change the flag to the index position
	//changing directories
	//if just cd is typed, go to the home directory of the host
	//else, do as the cd command does per usual
		if ((strcmp(exec_args[0],"cd")==0) && (strcmp(exec_args[1],"(null)")==0)){
			char dir[PATH_MAX] = "/home/";
			strcat(dir,user);
			chdir(dir);
	 	}				
	 	if ((strcmp(exec_args[0],"cd")==0) && (strcmp(exec_args[1],"(null)")!=0)){
			if (chdir(exec_args[flag-1]) != 0){
				perror("chdir() failed");
			}else{
				chdir(exec_args[flag-1]);
			}		
		}
	// forking the parent process into children to process the input
		int pid=fork();
		if (pid<0){
			printf("ERROR!");
			exit(1);
		}
		if (pid==0){
			if (flag == 1){ // index position one is null, means there is a command in position zero, therefore there is only the root command, i.e. cd, ls, cat	
        	        	execlp(exec_args[0], exec_args[0],  NULL);
	                        exit(0);
	                }
			if (flag == 2){
                      		execlp(exec_args[0], exec_args[0], exec_args[flag-1], NULL);
	                        exit(0);
        	        }
			if (flag == 3){
				execlp(exec_args[0], exec_args[0], exec_args[flag-2], exec_args[flag-1], NULL);
				exit(0);
			}
			if (flag == 4){
                	        execlp(exec_args[0], exec_args[0], exec_args[flag-3], exec_args[flag-2], exec_args[flag-1], NULL);
				exit(0);
			}
 		        if (flag == 5){
	                        execlp(exec_args[0], exec_args[0], exec_args[flag-4], exec_args[flag-3], exec_args[flag-2], exec_args[flag-1], NULL);
        	        	exit(0);
			}
			if (flag == 6){
        	                execlp(exec_args[0], exec_args[0], exec_args[flag-5], exec_args[flag-4], exec_args[flag-3], exec_args[flag-2], exec_args[flag-1], NULL);
       	        		exit(0); 
			}
		} else {
			wait(0);
		}
		free(inp);
	}
}
