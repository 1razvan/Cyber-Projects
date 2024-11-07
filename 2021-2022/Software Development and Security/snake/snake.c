#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <time.h>
#include <ncurses.h>
#include <pthread.h>
#define row 20
#define col 40

int kbhit(void){
    int ch, r;
   
    // turn off getch() blocking and echo
    nodelay(stdscr, TRUE);
    noecho();
   
    // check for input
    ch = getch();
    if(ch == ERR){      // no input
            r = FALSE;	    
    } else {                // input
            r = TRUE;
            ungetch(ch);
    }
   
    // restore block and echo
    echo();
    nodelay(stdscr, FALSE);
    return(r);
}

void main (){

	char grid[row][col];	
	for (int i = 0; i < row; i++){
		for (int j = 0; j < col; j++){
			grid[i][j] = ' ';
		}
	}

	srand(time(NULL)); // initiate random number
	
	int appleFlag = 1;
	int appleY, appleX;
	
	int playerY = rand() % row; // row of player
	int playerX = rand() % col; // column of player

	grid[playerY][playerX] = '>'; // placing player on the grid with placeholder '>'

	initscr();

	WINDOW *mainwin = newwin(row+1, col+1, 0, 0);
	refresh();
	box(mainwin, 0, 0);

	wrefresh(mainwin);

	if ((mainwin = initscr()) == NULL){
		fprintf(stderr, "Error initialising ncurses.\n");
		exit(EXIT_FAILURE);
	}

	int points = 0;
	int continuous = 1;

	while (1){		
		if (appleFlag == 1){
			appleY = rand() % row; // row of apple
			appleX = rand() % col; // column of apple
			if (appleY == 0){
				appleY = 1;
			}
			if (appleX == 0){
				appleX = 1;
			}
			grid[appleY][appleX] = 'O';
			appleFlag = -1;
		}
		for (int i = 1; i < row; i++){
			for (int j = 1; j < col; j++){
				mvwprintw(mainwin, i, j, "%c", grid[i][j]);
			}
		}

		wrefresh(mainwin);
		
		mvwprintw(mainwin, 0, col+10, "Points: %d", points);
		refresh();		

		noecho(); 
		keypad(mainwin, 0);

		if (kbhit()){

			int keyCode = getch();			
			
			if (keyCode == 119){ // W
				continuous = 1;
			}
			if (keyCode == 97){ // A
				continuous = 2;
			}
			if (keyCode == 115){ // S
				continuous = 3;
			}
			if (keyCode == 100){ // D
				continuous = 4;
			}
		}

		if (continuous == 1){
			grid[playerY][playerX] = ' ';
			if (playerY == 1){
				playerY = row-1;
			} else {
				playerY -= 1;
			}
			grid[playerY][playerX] = '^';	
		}

		if (continuous == 2){
			grid[playerY][playerX] = ' ';
			if (playerX == 1){
				playerX = col-1;
			} else {
				playerX -= 1;
			}
			grid[playerY][playerX] = '<';
		}

		if (continuous == 3){
			grid[playerY][playerX] = ' ';
			if (playerY == row-1){
				playerY = 1;
			} else {
				playerY += 1;
			}
			grid[playerY][playerX] = 'v';
		}

		if (continuous == 4){
			grid[playerY][playerX] = ' ';
			if (playerX == col-1){
				playerX = 1;
			} else {
				playerX += 1;
			}
			grid[playerY][playerX] = '>';
		}

		if ((playerX == appleX) && (playerY == appleY)){
			points += 1;
			appleFlag = 1;
		}

		struct timespec ts = {0, 100000000};
		struct timespec rem;
		nanosleep(&ts, &rem);
	
		endwin();
		refresh();
		
	}

	endwin();
	refresh();

}

