@echo off
CD /d %~dp0

echo.
echo Microsoft Visual C++ All-In-One Runtimes
echo.
pause

echo Checking packages...

if not exist "packages.zip" (
    echo Downloading packages...
    powershell -Command "Invoke-WebRequest -Uri https://github.com/zile42O/vsall/raw/refs/heads/main/packages.zip -OutFile packages.zip"
)

if exist "packages.zip" (
    echo Extracting packages...
    powershell -Command "Expand-Archive -Path 'packages.zip' -DestinationPath '.'"
)

echo.

echo Installing runtime packages...

set IS_X64=0 && if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set IS_X64=1) else (if "%PROCESSOR_ARCHITEW6432%"=="AMD64" (set IS_X64=1))

if "%IS_X64%" == "1" goto X64

echo 2005...
start /wait vcredist2005_x86.exe /q

echo 2008...
start /wait vcredist2008_x86.exe /qb

echo 2010...
start /wait vcredist2010_x86.exe /passive /norestart

echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart

echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart

echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart

goto END

:X64

echo 2005...
start /wait vcredist2005_x86.exe /q
start /wait vcredist2005_x64.exe /q

echo 2008...
start /wait vcredist2008_x86.exe /qb
start /wait vcredist2008_x64.exe /qb

echo 2010...
start /wait vcredist2010_x86.exe /passive /norestart
start /wait vcredist2010_x64.exe /passive /norestart

echo 2012...
start /wait vcredist2012_x86.exe /passive /norestart
start /wait vcredist2012_x64.exe /passive /norestart

echo 2013...
start /wait vcredist2013_x86.exe /passive /norestart
start /wait vcredist2013_x64.exe /passive /norestart

echo 2015 - 2022...
start /wait vcredist2015_2017_2019_2022_x86.exe /passive /norestart
start /wait vcredist2015_2017_2019_2022_x64.exe /passive /norestart

goto END

:END

echo.
echo Installation completed successfully
del /q packages.zip
del /q *.exe

pause