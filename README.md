# GB Hello World
This is a simple example repository for building gameboy games using the Game Boy Developer Kit (GBDK)

# Future improvements
 - [ ] Add Linux support

# Known issues
 - GBDK must be placed in a path with a short path location. This is due a 74 character limit when refrencing files. This is fixed by placing gbdk in 'C:\gbdk'. This is issue is identified with the following error when building: 
 ```
 [LONGPATH]/gbdk/lib/small/asxxxx/gb/cr.: cannot open.
 ```

# Requirements
 - GBDK (Recommended: v2.85-3. Script provided in 3rdparty folder to quickly download the recommended version)
 - BGB (Recommended: 1.5.8. Script provided in 3rdparty folder to quickly download the latest version)

# Build
Download and extract GBDK to a short path on your machine (e.g. 'C:\gbdk'). Or use the automatic script 'download_3rdparty.bat' in 'scripts' folder. This will automatically download and extract GBDK to 'C:\gbdk'. This must be run as admin to be allowed access to create 'C:\gbdk' folder.
Build gameboy hello world code using GBDK. The helloworld example is 
This can be done using the automatic build script 'build.bat' provided in 'scripts' folder. This assumes the GBDK location is 'C:\gbdk'. Or manually using the command line:
```
cd PATH_TO_REPO
mkdir build
cd build
C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o helloworld.o ..\games\helloworld\helloworld.c
C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o helloworld.gb helloworld.o
```
This will build the app to a build folder in this repository.  
The 'helloworld.gb' file in this build folder is the gameboy game that has just been compiled. 

# Run
## Emulator
You can use the .gb file generated on a gameboy cartridge however it's advised to test it out in an emulator. Provided in the repository is a download script to download BGB a game boy emulator. If you ran the 'download_3rdparty.bat' eariler then you can find this in 3rdparty\bgb in the repository.

Run the emulator using the 'test.bat' in 'scripts' folder or using the following command:
```
cd PATH_TO_REPO
3rdparty\bgb\bgb\bgb.exe -rom build\helloworld.gb
```

# Notes
## Useful links
| Title                                 | URL                                                                                                                 | Description                                     |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| Programming Game Boy Games using GBDK | https://videlais.com/2016/07/03/programming-game-boy-games-using-gbdk-part-1-configuring-programming-and-compiling/ | Tips for programming and advice on the hardware |
| GBDK Playground                       | https://github.com/mrombout/gbdk_playground                                                                         | Code examples                                   |

## Programming tips
 - Objects, as they might exist in other languages, aren’t in C. And you can’t use structs to mirror this functionality, either. Most of your code will be based on functions and arrays.
 - Whenever possible, use globals, too. Instead of defining a variable within a function, define it once and then, if possible after, re-use that same name as a way to cut down on calls to the stack.
 - Instead of using “int”, use “UINT8” at all times.
 - Other than in a few specific cases, most values will be in hexadecimal.