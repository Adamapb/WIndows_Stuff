#**EXPERIMENTAL** MENU FUNCTION BELOW
@echo off
echo Checking for admin privs...
net sessions
if %errorlevel%==0 (
echo We good.
) else (
echo Rerun with admin privs
pause
exit
)
#Rootkit scan needs to be reviewed
:MENU
echo Choose An option:
echo 1. Hacking tools removal
echo 2. System Scan
echo 3. Rootkit Scan

CHOICE /C 123 /M "Enter your choice:"
if ERRORLEVEL 3 goto Three
if ERRORLEVEL 2 goto Two
if ERRORLEVEL 1 goto One


#Hacktools removal
:One
echo Finding Hacktools now...
findstr "Cain" programfiles.flashed
if %errorlevel%==0 (
echo Cain detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "nmap" programfiles.flashed
if %errorlevel%==0 (
echo Nmap detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "keylogger" programfiles.flashed
if %errorlevel%==0 (
echo Potential keylogger detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "Armitage" programfiles.flashed
if %errorlevel%==0 (
echo Potential Armitage detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "Metasploit" programfiles.flashed
if %errorlevel%==0 (
echo Potential Metasploit framework detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "Shellter" programfiles.flashed
if %errorlevel%==0 (
echo Potential Shellter detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "narc" programfiles.flashed
if %errorlevel%==0 (
echo Potential Shellter detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "malware" programfiles.flashed
if %errorlevel%==0 (
echo Potential Shellter detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "rtkit" programfiles.flashed
if %errorlevel%==0 (
echo Potential Shellter detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
findstr "rootkit" programfiles.flashed
if %errorlevel%==0 (
echo Potential Shellter detected. WRITE DOWN, ask Adam if help needed
pause >NUL
)
cls
goto MENU

#System Scan
:Two
REM START SYS INTEG SCAN!
echo "STARTING SYSTEM INTERGRITY SCAN"
echo "If it fails make sure you can access Sfc.exe"
Sfc.exe /scannow
goto MENU

#Rootkit Scan
:Three
REM PowerShell RootKit detection start
echo "POWERSHELL ROOTKIT DETECTION WITH MALWAREBYTES ROOTKIT BETA (Requires powershell execution policy)"
REM Downloads MalwareBytes scan file
powershell Invoke-WebRequest -OutFile MBRTKit.exe https://data-cdn.mbamupdates.com/web/mbar-1.10.3.1001.exe
MBRTKit.exe
goto MENU
PAUSE
