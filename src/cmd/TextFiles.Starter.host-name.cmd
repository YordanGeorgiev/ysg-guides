@echo off
:: File: TextFiles.Starter.DESKTOP-M175NUE.cmd v1.1.0 docs at the end 

:: this just an iso-8601 wrapper for windows:
:: src: http://www.cs.tut.fi/~jkorpela/iso8601.html
call GetNiceTime.cmd

:: go the run dir
cd %~dp0z

:: this is the dir containing the batch file
set _MyDir=%CD%

:: look around , set vars
for %%A in (%0) do set _MyDriveLetter=%%~dA
for %%A in (%0) do set _MyPath=%%~pA
for %%A in (%0) do set _MyName=%%~nA
for %%A in (%0) do set _MyEtxtension=%%~xA

:: contains absolute file paths of the files to open like this
set _ListFile=%_MyDir%\%_MyName%.lst
:: example of lines in the list file - take out the ::space
:: C:\Users\ysg\Desktop\TextFiles.Starter.DESKTOP-M175NUE.cmd
:: C:\Users\ysg\Desktop\TextFiles.Starter.DESKTOP-M175NUE.lst


set _Program="C:\Program Files\TextPad 8\TextPad.exe"
:: set _Program="C:\Program Files\Sublime Text 3\sublime_text.exe"
set _
:: DEBUG PAUSE

:: sleep 2
ping -n 2 www.google.com > NUL

:: for each line of the cat file do perform an action ( in this case open url with opera ) 
:: for TextPad , obs note the quoting 
for /f "tokens=*" %%i in ('type "%_ListFile%"') do cmd /c "%_Program% "%%i""

:: for sublime, obs note the quoting 
:: for /f "tokens=*" %%i in ('type "%_ListFile%"') do cmd /c "%_Program% -n "%%i""
:: DEBUG PAUSE

:: Purpose: 
:: to start a list of non-binary files from a list file on Windows 10
:: Tested on Windows 10, should work on Win7 too
:: 
:: Requirements:
:: TextPad 8 or Sublime
:: 
:: 
:: Usage: 
:: copy this file to a folder where you would like to start the development of th.cmd file 
:: with some customer logic 
:: create a .cmd_file_name>>.cat file with an item per like in the same directory 
:: change the program name in the _Program var
:: 
:: VersionHistory: 
:: 1.1.0 --- 2017-10-06 09:42:54 --- ysg --- added sublime 
:: 1.0.1 --- 2013-04-15 08:19:10 --- ysg --- added - todo-%today%.txt file opening
:: 1.0.0 --- 2012-05-23 09:08:57 --- ysg -- Initial creation 
