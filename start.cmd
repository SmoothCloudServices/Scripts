@echo off
setlocal EnableExtensions EnableDelayedExpansion
title SmoothCloud

if defined JAVA_HOME (
    "%JAVA_HOME%\bin\java.exe" -version 2>&1 | findstr /C:"22"
    cls
    if not ERRORLEVEL 1 (
        if not exist smoothcloud.jar (
            echo No cloud file found. Please redownload the cloud file or check if the file exists.
        ) else (
            "%JAVA_HOME%\bin\java.exe" -Xms64M -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:CompileThreshold=100 -XX:+UnlockExperimentalVMOptions -XX:+UseCompressedOop -jar smoothcloud.jar
        )
    ) else (
        echo Please check your Java installation!
    )
) else (
    echo JAVA_HOME is not defined. Please define JAVA_HOME correctly.
)

pause
endlocal
