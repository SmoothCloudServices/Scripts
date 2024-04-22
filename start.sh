#!/bin/bash

# Check if Java is installed
if [ -x "$(command -v java)" ]; then
    # Check if screen is installed
    if [ -x "$(command -v screen)" ]; then
        # Start SmoothCloud in a new screen session
        screen -RS SmoothCloud java -Xms64M -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:CompileThreshold=100 -XX:+UnlockExperimentalVMOptions -XX:+UseCompressedOop -jar smoothcloud.jar
    else
        # Error message if screen is not installed
        echo "Screen is not installed to run SmoothCloud. Please execute 'apt install screen -y'."
        exit 1
    fi
else
    # Error message if Java is not installed
    echo "Java is not installed to run SmoothCloud. Java version 22 is required. Please execute 'apt install openjdk-22-jdk -y' or run 'install.sh'."
    exit 1
fi
