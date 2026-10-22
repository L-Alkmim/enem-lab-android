@echo off
setlocal EnableExtensions
cd /d "%~dp0"
echo -----------------------------------------
echo     ENEM Lab - Compilar Android APK
echo -----------------------------------------
where java >nul 2>&1
if errorlevel 1 (
  echo Instale o JDK 17 e adicione java ao PATH.
  pause
  exit /b 1
)
if "%ANDROID_HOME%"=="" if "%ANDROID_SDK_ROOT%"=="" (
  set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
)
if not exist "%ANDROID_HOME%\platforms\android-35\android.jar" (
  echo SDK Android API 35 nao encontrado. Abra o Android Studio,
  echo acesse Settings ^> Android SDK e instale Android API 35.
  echo ANDROID_HOME: %ANDROID_HOME%
  pause
  exit /b 1
)
where gradle >nul 2>&1
if not errorlevel 1 (
    echo Usando o Gradle instalado.
    gradle --no-daemon assembleDebug
) else (
    echo Gradle nao encontrado no PATH. Baixando Gradle 8.9...
    if not exist ".buildtools" mkdir ".buildtools"
    if not exist ".buildtools\gradle-8.9\bin\gradle.bat" (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $zip='%CD%\.buildtools\gradle-8.9-bin.zip'; if(!(Test-Path $zip)){Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.9-bin.zip' -OutFile $zip}; Expand-Archive -Force $zip '%CD%\.buildtools'"
        if errorlevel 1 (echo Nao foi possivel baixar Gradle & pause & exit /b 1)
    )
    call ".buildtools\gradle-8.9\bin\gradle.bat" --no-daemon assembleDebug
)
if errorlevel 1 (
   echo Falha na compilacao: examine as mensagens acima.
   pause
   exit /b 1
)
echo.
echo APK GERADO EM:
echo %CD%\app\build\outputs\apk\debug\app-debug.apk
pause
