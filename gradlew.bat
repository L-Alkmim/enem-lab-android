@echo off
setlocal
cd /d "%~dp0"
java -cp gradle\wrapper\gradle-wrapper.jar org.gradle.wrapper.GradleWrapperMain %*
exit /b %errorlevel%
