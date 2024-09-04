@echo off
set interval=10

:loop
manage-bde -status
echo Checking BitLocker status... %date% %time%
set /a count+=1
timeout /t %interval%
goto loop

:endloop
