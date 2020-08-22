#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdio.h>

UINT8 pen_x, pen_y, pen_colour, screen_x, screen_y;

UBYTE previous_KEYS = 0;
UBYTE keys = 0;

//performance delay to free up CPU
void performantDelay(UINT8 numloops)
{
    UINT8 i;
    for(i=0;i < numloops;i++)
    {   
        wait_vbl_done();
    }   
}

//joypad functions
void updateKeys()
{
    previous_KEYS = keys;
    keys = joypad();
}

INT8 keyPressed(INT8 K)
{
    return keys & (K);
}

INT8 keyTicked(INT8 K)
{
    return (keys & (K) && !(previous_KEYS & (K)));
}

INT8 keyReleased(INT8 K)
{
    return previous_KEYS & (K) && !(keys & (K));
}

void anyKey()
{
    keys;
}

void clear(){
    // clear the screen (side wipe)
    for (screen_x = 0; screen_x < 20; screen_x++) { // GB screen is 20 columns wide and 18 columns tall
        for (screen_y = 0; screen_y < 18; screen_y++) { 
            gotogxy(screen_x, screen_y);
            wrtchr(' '); // use wrtchr to place a character when using the drawing library
        }
    }
}

void main() {
    pen_x = 83, pen_y = 83, pen_colour = 3;

    // start screen (press start to continue)
    gotogxy(3,8); // set text start position
    gprintf("Press Start...");
    waitpad(J_START); // wait for start
    gotogxy(3,8); // reset text start position
    gprintf("              "); // clear message

    // game loop
    while(1) {
        updateKeys(); // check key presses
        // draw pixel if joykey pressed
        if (keyPressed(J_RIGHT) || keyPressed(J_LEFT) || keyPressed(J_UP) || keyPressed(J_DOWN)){
            // move based on joykey press
            if (keyPressed(J_RIGHT)){
                pen_x++;
            }
            if(keyPressed(J_LEFT)) {
                pen_x--;
            }
            if(keyPressed(J_UP)) {
                pen_y--;
            }
            if(keyPressed(J_DOWN)) {
                pen_y++;
            }
            plot(pen_x, pen_y, pen_colour, SOLID); // draw pixel
        }
        // change colour if 'A' is released
        if (keyReleased(J_A)) { 
            // change colors
            pen_colour++;
			if (pen_colour > 3)
				pen_colour = 1; //ignore colour 0 as this is the background colour
        }
        // change colour if 'B' is released
        if (keyReleased(J_B)) { 
            clear(); // clear the screen (side wipe)
		}
        // delay to control frame rate
        performantDelay(2);
    }
}