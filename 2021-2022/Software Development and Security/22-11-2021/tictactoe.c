#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define clear() printf("\e[1;1H\e[2J")

void prGrid(char *grid[3][3])
{
 		clear();

		printf("           |           |           \n");
                printf("     %s     |     %s     |     %s     \n",grid[0][0],grid[0][1],grid[0][2]);
                printf("           |           |           \n");
                printf("-----------------------------------\n");
                printf("           |           |           \n");
                printf("     %s     |     %s     |     %s      \n",grid[1][0],grid[1][1],grid[1][2]);
                printf("           |           |           \n");
                printf("-----------------------------------\n");
                printf("           |           |           \n");
                printf("     %s     |     %s     |     %s      \n",grid[2][0],grid[2][1],grid[2][2]);

                printf("           |           |           \n");

}

int main () 
{
	char *grid[3][3];
	
	int i, j;

	for (i=0;i<3;i++){
		for (j=0;j<3;j++){
			grid[i][j]=" ";
		}
	}

	prGrid(grid);
	
	printf("You are X.\n");

	int win = -1;
	while(win == -1)
	{
		int xFlg = 1;
		while (xFlg==1)
		{
			printf("Enter the row: ");
			int row;
			scanf("%i",&row);

			int col;
			printf("\nEnter the column: ");
			scanf("%i",&col);
			
			if (strcmp(grid[row][col]," ")==0)
			{
				grid[row][col]="\033[0;31mX\033[0m";
				xFlg=-1;
				prGrid(grid);
			}
		}
		
		
		srand(time(NULL));
	
		int flg = 1;
		while (flg==1)
		{
			int oRow = rand()%3;
			int oCol = rand()%3;

			if (strcmp(grid[oRow][oCol]," ")==0)
			{
				grid[oRow][oCol]="\033[0;33mO\033[0m";
				flg=-1;
				prGrid(grid);
			}
		}

		if ((grid[0][0]=="\033[0;31mX\033[0m") && (grid[0][1]=="\033[0;31mX\033[0m") && (grid[0][2]=="\033[0;31mX\033[0m")){
			win=1;
		}
		if ((grid[1][0]=="\033[0;31mX\033[0m") && (grid[1][1]=="\033[0;31mX\033[0m") && (grid[1][2]=="\033[0;31mX\033[0m")){               
                        win=1;
                }
		if ((grid[2][0]=="\033[0;31mX\033[0m") && (grid[2][1]=="\033[0;31mX\033[0m") && (grid[2][2]=="\033[0;31mX\033[0m")){
                        win=1;
                }
		if ((grid[0][0]=="\033[0;31mX\033[0m") && (grid[1][0]=="\033[0;31mX\033[0m") && (grid[2][0]=="\033[0;31mX\033[0m")){
                        win=1;
                }
		if ((grid[0][1]=="\033[0;31mX\033[0m") && (grid[2][1]=="\033[0;31mX\033[0m") && (grid[3][1]=="\033[0;31mX\033[0m")){
                        win=1;
                }
		if ((grid[0][2]=="\033[0;31mX\033[0m") && (grid[1][2]=="\033[0;31mX\033[0m") && (grid[2][2]=="\033[0;31mX\033[0m")){
                        win=1;
                }
		if ((grid[0][0]=="\033[0;31mX\033[0m") && (grid[1][1]=="\033[0;31mX\033[0m") && (grid[2][2]=="\033[0;31mX\033[0m")){
                        win=1;
                }
		if ((grid[0][2]=="\033[0;31mX\033[0m") && (grid[1][1]=="\033[0;31mX\033[0m") && (grid[2][0]=="\033[0;31mX\033[0m")){
                        win=1;
                }
	}
}
