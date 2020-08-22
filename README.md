# GB Game Builder
This is a simple example repository for building gameboy games using the Game Boy Developer Kit (GBDK).  
This repository also includes some example games to try out!

# Additional packages
The following packages are provided in this repository in the '3rdparty' folder:
 - GameBoy Developers Kit (Recommended: v3.2)
 - BGB GameBoy Emulator (Recommended: v1.5.8)
 - Gameboy Tile Designer (Recommened: v2.2)
 - EZFlashJr Kernal (Recommened: Firmware v4 K1.04e)

# Build
Some example games are provided in the 'examples' folder. To build one of these use the 'build.at' script in the 'scripts' folder providing the command line argument '--example [EXAMPLE_NAME]':
```
cd PATH_TO_REPO/scripts
build.bat --example helloworld
```
Alternativly you can do this manually:
```
cd PATH_TO_REPO
mkdir build
cd build
..\3rdparty\gbdk-3.2\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o helloworld.gb ..\examples\helloworld\helloworld.c
```
This will build the app to a build folder in this repository.  
The 'helloworld.gb' file in this build folder is the gameboy game that has just been compiled. 

# Run
## Emulator
You can use the .gb file generated on a gameboy cartridge however it's advised to test it out in an emulator. Provided in the repository is a download script to download BGB a game boy emulator. If you ran the 'download_3rdparty.bat' eariler then you can find this in 3rdparty\bgb in the repository.

Run the emulator using the 'test.bat' in 'scripts' folder with the command line argument '--example [EXAMPLE_NAME]':
```
cd PATH_TO_REPO/scripts
test.bat --example helloworld
```
Alternativly you can do this manually:
```
cd PATH_TO_REPO
3rdparty\bgb-1.5.8\bgb.exe -rom build\helloworld.gb
```

## EZ Flash Jr
You can flash the .gb file generated to a gameboy cartridge. This is easiest with EZ Flash Jr [link](http://www.ezflash.cn/product/ezflash-junior/).  
This has a removable micro-SD slot to easily load game files. 
### Prepare the micro-SD card
EZ Flash recommends using the SanDisk Ultra 32 GB microSDHC which MUST be formated FAT32, cluster size 32KB.  
In Windows do this by right clicking the SD card once inserted and selecting 'Format'. Select the correct format options in the dialog and then click 'Start'.  
Now the SD is ready, copy the files in '3rdparty/EZFlashJr-FW4-K1.04e' onto the SD card.  
### Update EZ Flash Firmware
The files in this repository use Firmware v4 K1.04e. This should be the latest firmware from EZ Flash. Check for updates [here](http://www.ezflash.cn/product/ezflash-junior/).  
To update the firmware copy the 'Update_FWX.gb' and 'ezgb.bat' file from the latest firmware onto the SD card. (Where X is the firmware version)
Remove the SD card and insert it into the cartridge.  
Turn on the game boy which should load the EZ startup menu. Select 'Update_FWX.bg' from the menu.  
The screen may flicker in the upgrade progress, it is normal. The progress will cost 10+ seconds. The screen goes normal when upgrade is done. Power off your console as prompted. **WARNING: DO NOT press the reset button!**  
Power up your console. Check the FW version in the HELP tab by press SELECT, if the FW version displaying FW0, you have to do the update progress again until the FW version change to FW4.  Full charged batteries will help to prevent the upgrade failing.
You can delete the 'Update_FW[X].gb' file from the SD card once you have tested it worked. **Note: Do not delete the ezgb.dat file**
### Load game
Copy the .gb file onto the SD card. Remove the SD card and insert it into the EZ Flash Jr cartridge.  
Select the game from the EZ Flash menu. The gameboy will restart and load the game.  

# Notes
## Useful links
**Programming Game Boy Games using GBDK ([link](https://videlais.com/2016/07/03/programming-game-boy-games-using-gbdk-part-1-configuring-programming-and-compiling/)):** Tips for programming and advice on the hardware  
**GBDK Playground ([link](https://github.com/mrombout/gbdk_playground)):** Game code examples

## Programming tips
 - Objects, as they might exist in other languages, aren’t in C. And you can’t use structs to mirror this functionality, either. Most of your code will be based on functions and arrays.
 - Whenever possible, use globals, too. Instead of defining a variable within a function, define it once and then, if possible after, re-use that same name as a way to cut down on calls to the stack.
 - Instead of using “int”, use “UINT8” at all times.
 - Other than in a few specific cases, most values will be in hexadecimal.

# Future improvements
 - [ ] Add Linux support