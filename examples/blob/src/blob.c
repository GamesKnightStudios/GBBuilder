#include <gb/gb.h>
#include <gb/drawing.h>
#include <stdio.h>
#include "blob_sprite.c"

UINT8 blob_x, blob_y;

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
    blob_x = 83, blob_y = 83;
    
    // start screen (press start to continue)
    gotogxy(3,8); // set text start position
    gprintf("Press Start...");
    waitpad(J_START); // wait for start
    gotogxy(3,8); // reset text start position
    gprintf("              "); // clear message

    // load blob sprite
    SPRITES_8x8;
    set_sprite_data(0, 0, blob);
    set_sprite_tile(0, 0);
    move_sprite(0, blob_x, blob_y); // set blob sprite inital position
    SHOW_SPRITES; // display sprites
    
    // game loop
    while(1) {
        updateKeys(); // check key presses
        // move sprite if joykey pressed
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
            move_sprite(0, blob_x, blob_y); // move sprite
        }
        // delay to control frame rate
        performantDelay(2);
    }
}