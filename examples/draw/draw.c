#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdio.h>

UINT8 blob_x, blob_y, blob_colour, screen_x, screen_y;
UINT8 key_a_released;

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

void main() {
    blob_x = 75, blob_y = 75, blob_colour = 3;
    key_a_released = 0;
    while(1) {
        updateKeys();
        if (keyPressed(J_RIGHT) || keyPressed(J_LEFT) || keyPressed(J_UP) || keyPressed(J_DOWN)){
            if (keyPressed(J_RIGHT)){
                blob_x++;
            }
            if(keyPressed(J_LEFT)) {
                blob_x--;
            }
            if(keyPressed(J_UP)) {
                blob_y--;
            }
            if(keyPressed(J_DOWN)) {
                blob_y++;
            }
            plot(blob_x, blob_y, blob_colour, SOLID);
        }
        if (keyReleased(J_A)) { // Change colors
            blob_colour++;
			if (blob_colour > 3)
				blob_colour = 1;
        }
        if (keyReleased(J_B)) { // Function to 'clear' the screen
			for (screen_x = 0; screen_x < 20; screen_x++) { // GB screen is 20 columns wide and 18 columns tall
				for (screen_y = 0; screen_y < 18; screen_y++) { 
					gotogxy(screen_x, screen_y);
					wrtchr(' '); // Use wrtchr to place a character when using the drawing library
				}
			}
		}
        performantDelay(2);
    }
}