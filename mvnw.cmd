@echo off
setlocal
set MVNW_DIR=%~dp0
set WRAPPER_DIR=%MVNW_DIR%.mvn\wrapper
set WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar

if not exist "%WRAPPER_JAR%" (
  mkdir "%WRAPPER_DIR%" >nul 2>&1
  echo Downloading maven-wrapper.jar...
  powershell -Command "try { (New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/io/takari/maven-wrapper/0.5.6/maven-wrapper-0.5.6.jar', '%WRAPPER_JAR%') } catch { exit 1 }"
  if errorlevel 1 (
    echo Failed to download maven-wrapper.jar
    exit /b 1
  )
)

set JAVA_EXE=%JAVA_HOME%\bin\java.exe
if not exist "%JAVA_EXE%" (
  set JAVA_EXE=java
)

"%JAVA_EXE%" -Dmaven.multiModuleProjectDirectory="%CD%" -cp "%WRAPPER_JAR%" org.apache.maven.wrapper.MavenWrapperMain %*
