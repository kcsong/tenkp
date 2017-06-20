@echo off

set RMBATCH=RISKCRAFT

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%1"=="start" goto start
goto step2

:step2
if "%1"=="status" goto status
goto step3

:step3
if "%1"=="stop" goto stop
goto message
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


rem 배치 실행
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:start
tasklist /FI "WINDOWTITLE eq %RMBATCH%" | find /i "java.exe" > null

if not "%ERRORLEVEL%" == "0" goto step5
goto step6

:step5
set MAIN_CLASS=com.fistglobal.riskcraft.bootstrap.EngineStartup
set CLASSPATH=.\config
FOR %%F IN (*.jar) DO call :addcp %%F
FOR %%F IN (lib\*.jar) DO call :addcp %%F
goto extlibe

echo CLASSPATH
:addcp
set CLASSPATH=%CLASSPATH%;%1
goto :eof

:extlibe
start "RISKCRAFT" java -Dname=RMBatch -Xmx1024M -XX:MaxPermSize=256m -server -cp "%CLASSPATH%" %MAIN_CLASS% %*
goto exit

:step6
echo "Service is running"
goto exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem 배치 상태
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:status
tasklist /FI "WINDOWTITLE eq %RMBATCH%" | find /i "java.exe" > null
if not "%ERRORLEVEL%" == "0" goto step9
goto step10

:step9
echo "Service is NOT running"
goto exit

:step10
echo "Service is running"
goto exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem 배치 정지
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:stop
taskkill  /fi "WINDOWTITLE eq %RMBATCH%"
goto exit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:message
echo "Usage : run_batch [ start | stop | status ]"
goto exit

:exit
pause