#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <time.h>
#include <ncurses.h>
#include <pthread.h>
#include <string.h>

void pGrid(int r, int c, char g[r][c]){
	for (int i=0; i<r;i++){
		for (int j=0; j<c; j++){
			printf("%c",g[i][j]);
		}
	}
}

void genApple(int r, int c, char g[r][c], int *appleX, int *appleY){
	int X = rand() % r; // row of apple
	int Y = rand() % c; // column of apple
	
	*appleX = X;
	*appleY = Y;

	g[X][Y]='O'; // place 'O' as an apple placeholder
}

void* moving(void* arg){

	struct timespec ts={0, 500000000};
	struct timespec rem;
	nanosleep(&ts, &rem);
	
	switch(kC){
		case 119: // w, up
			arr[pX][pY]=' ';
			pY += 1;
			arr[pX][pY]='^';
		case 97: // a, left
			arr[pX][pY]=' ';
			pX -= 1;
			arr[pX][pY]='<';
		case 115: // s, down
			arr[pX][pY]=' ';
			pY -= 1;
			arr[pX][pY]='V';
		case 100: // d, right
			arr[pX][pY]=' ';
			pX += 1;
			arr[pX][pY]='>';
	}
}

void main (){

	WINDOW * mainwin;

	if ( (mainwin = initscr()) == NULL){
		fprintf(stderr, "Error initialising ncurses.\n");
		exit(EXIT_FAILURE);
	}

	struct winsize size;
	ioctl(STDOUT_FILENO, TIOCGWINSZ, &size);
	
	int row = size.ws_row;
	int col = size.ws_col;
		
	char grid[row][col];

	for (int i=0; i<row;i++){
		for (int j=0; j<col; j++){
			grid[i][j]=' ';
		}
	}


	srand(time(NULL)); // initiate random number
	
	int appleX, appleY;
	int appleFlag= 1;

	if (appleFlag == 1){
		genApple(row, col, grid, &appleX, &appleY);
		appleFlag = -1;
	}

	int playerX = rand () % row; // row of player
	int playerY = rand () % col; // column of player

	grid[playerX][playerY]='>'; // placing player on the grid with placeholder '>'
	
	while (1){
		pGrid(row,col,grid); // print grid with function
		noecho(); 
		keypad(mainwin,0);
		int keyCode=getch();
		//printf("%d",keyCode); //w is 119; a is 97; s in 115; d is 100
		
		struct MovingParam
		{
			int kC;
			char arr;
			int pX;
			int pY;
		};

		struct MovingParam mov;
		
		mov.kC = keyCode;
		strcpy(arr,grid);
		mov.pX = playerX;
		mov.pY = playerY;



		pthread_t thread_id;
		pthread_create(&thread_id, NULL, &moving, &mov);
		pthread_join(thread_id, NULL);
	}


	delwin(mainwin);
	endwin();
	refresh();


}

