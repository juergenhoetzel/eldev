@echo off
rem This script downloads Eldev startup script as `%USERPROFILE%/.eldev/bin/eldev'.

rem optionally pass download URL as paramater to allow testing in PRs
IF [%1] == [] (
   set URL=https://raw.githubusercontent.com/doublep/eldev/master/bin/eldev
) else (
   set URL=%1
)

set DIR=%USERPROFILE%\.eldev\bin

mkdir %DIR%

powershell -command "Invoke-WebRequest %URL% -Outfile %DIR%\eldev.bat"

echo Eldev startup script has been installed.
echo Don't forget to add `%DIR% to PATH environment variable:
echo.
echo     set PATH=%DIR%;%%PATH%%

