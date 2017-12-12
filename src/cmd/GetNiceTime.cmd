@echo off
:: File:GetNiceTime.cmd v.1.2. docs at the end
 
echo set hhmmsss
:: this is Regional settings dependant so tweak this according your current settings
:: So this works for System Locale:fi;Finnish run the systeminfo commmand to see your own and adjust
for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a GEQ 10 set hhmmsss=%%a%%b%%c
for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a LSS 10 set hhmmsss=0%%a%%b%%c
for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a GEQ 10 set _hhmmsss=%%a:%%b:%%c
for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a LSS 10 set _hhmmsss=0%%a:%%b:%%c

for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a GEQ 10 set hh-mm-sss=%%a-%%b-%%c
for /f "tokens=1-3 delims=,:. " %%a in ('echo %time%') do IF %%a LSS 10 set  hh-mm-sss=0%%a-%%b-%%c
 
 
:: this is Regional settings dependant so tweak this according your current settings
for /f "tokens=2-4 delims=. " %%D in ('echo %DATE%') do set  yyyymmdd=%%F%%E%%D
for /f "tokens=2-4 delims=. " %%D in ('echo %DATE%') do set  _yyyymmdd=%%F.%%E.%%D
for /f "tokens=2-4 delims=. " %%D in ('echo %DATE%') do set  yyyy-mm-dd=%%F-%%E-%%D

::DEBUG ECHO yyyymmdd IS %yyyymmdd%
::DEBUG PAUSE

 
set NICETIME=%yyyymmdd%_%hhmmsss%
set _NICETIME=%yyyy-mm-dd% %_hhmmsss%
set NICE-TIME=%yyyy-mm-dd% %hh-mm-sss%

:: THIS NEEDS THE CLIP.EXE command line tool from the windows server 2003 resource kit 
echo %_NICETIME%|clip 

:: DEBUG PAUSE
echo THE NICETIME IS %NICETIME%
echo THE _NICETIME IS %_NICETIME%
ECHO THE NICE-TIME IS %NICE-TIME%
:: DEBUG
:: PAUSE
 
:: =========END FILE GetNiceTime.cmd 
:: Purpose:
:: To provide a simple copy paste for a nicely format time on the running windows host
:: HAVING THE FOLLOWING DATE TIME FORMATS time is 21:30:27,47 and date is to 20.05.2010 
:: Usage:
:: SET THE NICETIME 
:: SET NICETIME=BOO
:: CALL GetNiceTime.cmd 
:: ECHO %COMPUTERNAME% GETS HOSTNAME
:: ECHO NICETIME IS %NICETIME%
 
:: echo nice time is %NICETIME%
:: END USAGE  ==================================================================
:: VersionHistory
:: 1.2.0 -- 2016.06.22 10:36:19 -- ysg -- yoga time ...  
:: 1.1.0 -- ysg --- Added USA YYYY-MM-DD hh-mm--ss type of formatting 
:: 1.0.0 -- ysg --- Initial creation. Sick of having to hack windows date and time commands 