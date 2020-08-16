#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdio.h>

UINT8 blob_x, blob_y, blob_size, screen_x, screen_y;

void main() {
    blob_x = 55, blob_y = 75, blob_size = 3;
    while(1) {
        if(joypad() & J_RIGHT) {
            blob_x++;
            plot(blob_x, blob_y, blob_size, SOLID);
            delay(10);
        }
        if(joypad() & J_LEFT) {
            blob_x--;
            plot(blob_x, blob_y, blob_size, SOLID);
            delay(10);
        }
        if(joypad() & J_UP) {
            blob_y--;
            plot(blob_x, blob_y, blob_size, SOLID);
            delay(10);
        }
        if(joypad() & J_DOWN) {
            blob_y++;
            plot(blob_x, blob_y, blob_size, SOLID);
            delay(10);
        }
        if (joypad() == J_B) { // Function to 'clear' the screen
			for (screen_x = 0; screen_x < 20; screen_x++) { // GB screen is 20 columns wide and 18 columns tall
				for (screen_y = 0; screen_y < 18; screen_y++) { 
					gotogxy(screen_x, screen_y);
					wrtchr(' '); // Use wrtchr to place a character when using the drawing library
				}
			}
		}
    }
}