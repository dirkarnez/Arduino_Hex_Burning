@echo off

if not exist %USERPROFILE%\Downloads\serial-locate-v1.0.0 (
cd %USERPROFILE%\Downloads && 	^
%SystemRoot%\System32\curl.exe "https://github.com/dirkarnez/serial-locate/releases/download/v1.0.0/serial-locate-v1.0.0.zip" -L -O &&^
C:\PROGRA~1\7-Zip\7z.exe x serial-locate-v1.0.0.zip -O"%USERPROFILE%\Downloads\serial-locate-v1.0.0"
) else (
	echo serial-locate found
)


for /f "tokens=*" %%a in (
'%USERPROFILE%\Downloads\serial-locate-v1.0.0\serial-locate.exe --vid=2341 --pid=0043 --usb=true'
) do (
    set output=%%a
)

"C:\Program Files (x86)\Arduino\hardware\tools\avr\bin\avrdude.exe" -C"C:\Program Files (x86)\Arduino\hardware\tools\avr\etc\avrdude.conf" -v -v -v -patmega328p -carduino -P%output% -b115200 -D -Uflash:w:"Remote.hex":i
pause