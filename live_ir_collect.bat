@echo off
title Live IR Collector
echo ==============================
echo Live Incident Response Script
echo ==============================

:: Create Cases folders on Desktop
set DESKTOP=%USERPROFILE%\Desktop
set CASEDIR=%DESKTOP%\Cases\Case01-PolicyViolation

mkdir "%CASEDIR%" 2>nul

cd /d "%CASEDIR%"

echo Output folder: %CASEDIR%
echo.

set OUTFILE=liveIR-%date:~-4,4%%date:~-10,2%%date:~-7,2%-%time:~0,2%%time:~3,2%.txt
set OUTFILE=%OUTFILE: =0%

echo Collecting volatile data...
echo %date% %time% > %OUTFILE%

echo ===== TASKS ===== >> %OUTFILE%
tasklist >> %OUTFILE%
tasklist /m >> %OUTFILE%
tasklist /svc >> %OUTFILE%

echo ===== NETWORK ===== >> %OUTFILE%
netstat -nao >> %OUTFILE%
arp -a >> %OUTFILE%
ipconfig /all >> %OUTFILE%
ipconfig /displaydns >> %OUTFILE%
route print >> %OUTFILE%

echo ===== ENVIRONMENT ===== >> %OUTFILE%
set >> %OUTFILE%

echo ===== USERS ===== >> %OUTFILE%
net user %username% >> %OUTFILE%
net user >> %OUTFILE%

echo ===== SHARES ===== >> %OUTFILE%
net share >> %OUTFILE%

echo ===== WORKSTATION ===== >> %OUTFILE%
net config workstation >> %OUTFILE%

echo ===== SYSTEM INFO ===== >> %OUTFILE%
systeminfo >> %OUTFILE%

echo.
echo Done.
echo Output file:
echo %CASEDIR%\%OUTFILE%
pause
