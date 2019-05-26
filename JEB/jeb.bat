@ECHO OFF

:init
  SETLOCAL DisableDelayedExpansion
  MD log 1>NUL 2>&1
  SET "batchPath=%CD%\jeb_wincon.bat"
  FOR %%k IN (%0) DO SET batchName=%%~nk
  SET "runvbs=.\run_%batchName%.vbs"

  SET "year=%date:~0,4%"
  SET "month=%date:~5,2%"
  SET "day=%date:~8,2%"
  SET "hour_ten=%time:~0,1%"
  SET "hour_one=%time:~1,1%"
  SET "minute=%time:~3,2%"
  SET "second=%time:~6,2%"
  IF "%hour_ten%" == " " (
      SET log=log\%year%%month%%day%0%hour_one%%minute%%second%.log
  ) else (
      SET log=log\%year%%month%%day%%hour_ten%%hour_one%%minute%%second%.log
  )
  SETLOCAL EnableDelayedExpansion

ECHO.args = "cmd /c !batchPath! 1>!log! 2>&1 "> "%runvbs%"
ECHO.For Each strArg in WScript.Arguments>> "%runvbs%"
ECHO.  args = args ^& strArg ^& " ">> "%runvbs%"
ECHO.Next>> "%runvbs%"
ECHO.CreateObject^("Wscript.Shell"^).Run args, 0 >> "%runvbs%"
"%SystemRoot%\System32\WScript.exe" "%runvbs%" %*
DEL %runvbs%