# GB Game Builder
This is a simple example repository for building gameboy games using the Game Boy Developer Kit (GBDK).  
This repository also includes some example games to try out!

# Future improvements
 - [ ] Add Linux support

# Requirements
 - GBDK (Recommended: v3.2. Provided in the repository in '3rdparty')
 - BGB (Recommended: v1.5.8. Provided in the repository in '3rdparty')
 - [Optional] GBTD (Recommened: v2.2. Provided in the repository in '3rdparty')
 - [Optional] EZFlashJr Kernal (Recommened: Firmware v4 K1.04e. Provided in the repository in '3rdparty')

# Build
Some example games are provided in the 'examples' folder. To build one of these use the 'build.at' script in the 'scripts' folder providing the command line argument '--examples [NAME_OF_EXAMPLE]':
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

Run the emulator using the 'test.bat' in 'scripts' folder with the command line argument '--examples [NAME_OF_EXAMPLE]':
```
cd PATH_TO_REPO/scripts
test.bat --examples helloworld
```
Alternativly you can do this manually:
```
cd PATH_TO_REPO
3rdparty\bgb-1.5.8\bgb.exe -rom build\helloworld.gb
```

# Notes
## Useful links
**Programming Game Boy Games using GBDK ([link](https://videlais.com/2016/07/03/programming-game-boy-games-using-gbdk-part-1-configuring-programming-and-compiling/)):** Tips for programming and advice on the hardware  
**GBDK Playground ([link](https://github.com/mrombout/gbdk_playground)):** Game code examples

## Programming tips
 - Objects, as they might exist in other languages, aren’t in C. And you can’t use structs to mirror this functionality, either. Most of your code will be based on functions and arrays.
 - Whenever possible, use globals, too. Instead of defining a variable within a function, define it once and then, if possible after, re-use that same name as a way to cut down on calls to the stack.
 - Instead of using “int”, use “UINT8” at all times.
 - Other than in a few specific cases, most values will be in hexadecimal.