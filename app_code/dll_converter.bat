@echo off
cls
echo             ==Professor Wang's improved dll batch converter==
echo.
if not exist "C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat" goto visualstudio8x64
call "C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat"
goto continue
:visualstudio8x64
if not exist "C:\Program Files (x86)\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat" goto visualstudio9x86
call "C:\Program Files (x86)\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat"
goto continue
:visualstudio9x86
if not exist "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" goto visualstudio9x64
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
goto continue
:visualstudio9x64
if not exist "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" goto notfound
call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
goto continue
:notfound
echo Cannot locate Visual Studio Command Prompt
echo Please launch this file from within it manually.
echo.
pause
exit
:continue
echo.
echo Step 1: Move this file into the same folder as the .vb file you wish to convert
echo.
echo Step 2: Enter the filename (without .vb extension) you wish to convert below
echo.
set /p filename= Filename:
echo.
echo Converting %filename%.vb, Please Wait...
echo.
set assemblies=System.dll,System.Web.dll,System.Data.dll,System.XML.dll
vbc /t:library /out:%filename%.dll /r:%assemblies% %filename%.vb
echo.
echo The file "%filename%.dll" should have been created in the folder. If not please
echo contact the instructor for help
echo.
pause