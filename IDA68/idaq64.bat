@ECHO OFF
CLS
:init
  SETLOCAL DisableDelayedExpansion
  SET "batchPath=%~0"
  FOR %%k IN (%0) DO SET batchName=%%~nk
  SET "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
  SETLOCAL EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  IF '%errorlevel%' == '0' ( GOTO gotPrivileges ) ELSE ( GOTO getPrivileges )

:getPrivileges
  if '%1'=='ELEV' ( ECHO ELEV & SHIFT /1 & GOTO gotPrivileges)
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: Request UAC
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = " " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " " >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  "%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
  DEL "%vbsGetPrivileges%"
  exit /B

:gotPrivileges
  SETLOCAL
  CD /d %~dp0

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ����Ϊ��Ҫ���е��������ļ����� ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �������¿��޸�Ϊ����Ҫ��bat�������������ð�ſ�ʼ�����涼��ɾ�ģ�

ECHO Yes | REG ADD HKLM\SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath /ve /t REG_SZ /d "D:\.symlink\IDAPython" 1>NUL 2>&1
ECHO Yes | REG ADD HKLM\SOFTWARE\Wow6432Node\Python\PythonCore\2.7\InstallPath\InstallGroup /ve /t REG_SZ /d "Python 2.7" 1>NUL 2>&1
ECHO Yes | REG ADD HKLM\SOFTWARE\Wow6432Node\Python\PythonCore\2.7\PythonPath /ve /t REG_SZ /d "D:\.symlink\IDAPython\Lib;D:\.symlink\IDAPython\DLLs;D:\.symlink\IDAPython\Lib\lib-tk" 1>NUL 2>&1
SET PATH=D:\.symlink\IDAPython
START .\idaq64.exe %*