@ECHO OFF &SETLOCAL
color 0A
echo Note* Format of Date yyyy-mm-dd
set /P "start_date=Enter start Date:    "
set /P "end_date=Enter End Date:    "


CD "C:\Users\PVisal\Desktop\bat"
FOR /D /R %%G in (*) DO (
    SET "FileName=%%~G"
    SETLOCAL ENABLEDELAYEDEXPANSION
    FOR /F %%H IN ('wmic fsdir where name^="!FileName:\=\\!" get creationdate^|find "."') DO SET "cdate=%%H"
    CALL :loopbody "!cdate:~6,2!/!cdate:~4,2!/!cdate:~0,4!-!cdate:~8,2!:!cdate:~10,2!:!cdate:~12,2!" "!FileName!"

    FOR /F "tokens=1,* delims= " %%A IN ('DIR /T:C /A:-D "!FileName!" ^|FIND "/"') DO (
    SET Cdate=%%A
    SET Fname=%%B
    SET Fname=!Fname:~24!
    ::ECHO !Fname! created on: !CDate!
    ECHO [97mCreation Date:[0m    [92m!CDate![0m        [97mFile Name:[0m       [94m!Fname![0m   [97mFile Path:[0m  [96m!FileName![0m
    )

    ENDLOCAL

)
GOTO:EOF

:loopbody

set check_date=!cdate:~0,4!-!cdate:~4,2!-!cdate:~6,2!
set location = !FileName!

if "%check_date%" geq "%start_date%" if "%check_date%" leq "%end_date%" (
::ECHO "!cdate:~6,2!/!cdate:~4,2!/!cdate:~0,4!-!cdate:~8,2!:!cdate:~10,2!:!cdate:~12,2!" "!FileName!"
ECHO [45m"!cdate:~6,2!/!cdate:~4,2!/!cdate:~0,4!-!cdate:~8,2!:!cdate:~10,2!:!cdate:~12,2!" "!FileName!"[0m
)

EXIT /B

