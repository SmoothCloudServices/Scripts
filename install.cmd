@echo off
setlocal EnableExtensions EnableDelayedExpansion
title SmoothCloudServices

set /p CheckIfStart="Do you want to start the Cloud? (y/n): "
if /i "%CheckIfStart%"=="n" (

    if defined JAVA_HOME (
        "%JAVA_HOME%\bin\java.exe" -version 2>&1 | findstr /C:"22"
        if ERRORLEVEL 1 (
            echo Current Java version is not 22. Detected version:
            "%JAVA_HOME%\bin\java.exe" -version 2>&1 | findstr /C:"version"
            goto VerifyJavaVersion
        ) else (
            echo Java 22 detected.
            goto CheckJar
        )
    ) else (
        echo JAVA_HOME is not set.
        goto VerifyJavaVersion
    )

    :VerifyJavaVersion
    echo Installed Java version is not 22 or Java 22 could not be verified.
    set /p InstallJava="Do you want to install Java 22 now? (y/n): "
    if /i "%InstallJava%"=="y" (
        goto InstallJavaPrompt
    ) else (
        echo Please set JAVA_HOME manually or install Java 22 to proceed.
        goto EndScript
    )

    :InstallJavaPrompt
    echo Downloading Java 22...
    powershell -command "Start-BitsTransfer -Source https://download.oracle.com/java/22/latest/jdk-22_windows-x64_bin.msi -Destination %TEMP%\jdk-22_windows-x64_bin.msi"
    if %ERRORLEVEL% neq 0 (
        echo Failed to download Java 22. Check your internet connection and try again.
        goto EndScript
    ) else (
        echo Installing Java...
        msiexec /i "%TEMP%\jdk-22_windows-x64_bin.msi" /qn
        if %ERRORLEVEL% neq 0 (
            echo Installation failed. Check the installer and try again.
            goto EndScript
        ) else (
            echo Java 22 installation completed successfully.
            setx JAVA_HOME "%ProgramFiles%\Java\jdk-22" /M
            setx PATH "%PATH%;%ProgramFiles%\Java\jdk-22\bin" /M
            echo Environment variables updated.
            goto CheckJar
        )
    )

    :CheckJar
    if not exist smoothcloud.jar (
        echo SmoothCloud not found. Attempting to download...
        curl -z smoothcloud.zip -o smoothcloud.zip -L https://github.com/SmoothCloudServices/download-test/releases/download/1.0/smoothcloud.zip
        if %ERRORLEVEL% neq 0 (
            echo Download failed. Check your internet connection and try again.
            goto EndScript
        )
        echo Extracting SmoothCloud...
        powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('smoothcloud.zip', '.'); }"
        if %ERRORLEVEL% neq 0 (
            echo Failed to extract SmoothCloud. Exiting.
            goto EndScript
        ) else (
            echo SmoothCloud installation completed!
            Goto AskStartCloud
        )
    ) else (
        Goto AskStartCloud
    )

) else (
    Goto StartCloud
)

:AskStartCloud
set /p StartCloud="Do you want to start SmoothCloud now? (y/n): "
if /i "%StartCloud%"=="y" (
    goto StartCloud
) else (
    echo Exiting without starting SmoothCloud.
)

:StartCloud
if exist smoothcloud.jar (
    java -Xms64M -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:CompileThreshold=100 -XX:+UnlockExperimentalVMOptions -XX:+UseCompressedOop -jar smoothcloud.jar
) else (
    echo No jar file found!
    goto EndScript
)

:EndScript
pause
endlocal
exit /b %ERRORLEVEL%
