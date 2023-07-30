REM Compiling crispy-doom
MSBUILD "build\Crispy Doom.sln" /t:crispy-doom /p:Configuration="Release" /p:Platform="Win32"
COPY build\bin\Release\crispy-doom.exe Release\crispy-apdoom.exe
COPY build\bin\Release\crispy-setup.exe Release\crispy-setup.exe
COPY build\bin\Release\APCpp.dll Release\APCpp.dll

REM REM Compiling launcher
MSBUILD Launcher\APDoomLauncher\APDoomLauncher.sln /t:APDoomLauncher /p:Configuration="Release"
COPY Launcher\APDoomLauncher\bin\Release\APDoomLauncher.exe Release\apdoom-launcher.exe

REM REM Archiving apworld
DEL /F /Q ..\Archipelago\worlds\doom_1993\__pycache__
winrar a -afzip -ep1 -r Release\doom_1993.apworld ..\Archipelago\worlds\doom_1993

REM Generating default yaml
python3 ..\Archipelago\Launcher.py "Generate Template Settings"
COPY "..\Archipelago\Players\Templates\DOOM 1993.yaml" "Release\DOOM 1993.yaml"
COPY "..\Archipelago\Players\Templates\DOOM II.yaml" "Release\DOOM II.yaml"

REM Credits
COPY credits-doom-1993.txt Release\credits-doom-1993.txt
COPY credits-doom-ii.txt Release\credits-doom-ii.txt

REM Archiving release
winrar a -afzip -ep1 -r Release\APDOOM_x_x_x_beta.zip @release.lst
