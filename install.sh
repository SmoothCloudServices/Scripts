#!/bin/bash

echo "Do you want to download SmoothCloud? (y/n)"

read wantInstall

if [ $wantInstall = "y" ]; then
    hash wget 2>/dev/null || {
        echo >&2 "You need to install wget. Do you want to install it? (y/n)";

        read wantInstall

        if [ $wantInstall = "y" ]; then
            apt install wget
        else
            echo "Aborting!"
            sleep 1
            exit 1
        fi
    }

    hash unzip 2>/dev/null || {
        echo >&2 "You need to install unzip. Do you want to install it? (y/n)";

        read wantInstall

        if [ $wantInstall = "y" ]; then
            apt install unzip
        else
            echo "Aborting!"
            sleep 1
            exit 1
        fi
    }

    hash screen 2>/dev/null || {
        echo >&2 "You need to install screen. Do you want to install it? (y/n)";

        read wantInstall

        if [ $wantInstall = "y" ]; then
            apt install screen
        else
            echo "Aborting!"
            sleep 1
            exit 1
        fi
    }

    hash java 2>/dev/null || {
        echo >&2 "You need to install java. Do you want to install it? (y/n)";

        read wantInstall

        if [ $wantInstall = "y" ]; then
            apt install software-properties-common
            echo "deb [arch=amd64] https://some.repository.url focal main" | sudo tee /etc/apt/sources.list.d/adoptium.list > /dev/null
            apt install -y wget apt-transport-https gpg
            wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
            echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
            apt install temurin-22-jdk
        else
            echo "Aborting!"
            sleep 1
            exit 1
        fi
    }

    echo "Downloading SmoothCloud"
    sleep 0.5
    echo "Downloading SmoothCloud."
    sleep 0.5
    echo "Downloading SmoothCloud.."
    sleep 0.5
    echo "Downloading SmoothCloud..."
    sleep 0.5
    echo "Downloading SmoothCloud."
    sleep 0.5
    echo "Downloading SmoothCloud.."
    sleep 0.5
    echo "Downloading SmoothCloud..."
    sleep 0.5

    wget https://github.com/SmoothCloudServices/download-test/releases/latest/download/smoothcloud.zip

    echo "Downloaded SmoothCloud."
    sleep 0.5
    echo "Unzipping SmoothCloud"
    sleep 0.5
    echo "Unzipping SmoothCloud."
    sleep 0.5
    echo "Unzipping SmoothCloud.."
    sleep 0.5
    echo "Unzipping SmoothCloud..."
    sleep 0.5
    echo "Unzipping SmoothCloud."
    sleep 0.5
    echo "Unzipping SmoothCloud.."
    sleep 0.5
    echo "Unzipping SmoothCloud..."
    sleep 0.5

    unzip smoothcloud.zip
    echo "Unzipped SmoothCloud."
    sleep 0.5
    echo "SmoothCloud folder has been successfully set up."
    sleep 0.5

    echo "Do you want to start the cloud? (y/n)"

    read wantStart
    if [ $wantStart = "y" ]; then
        bash start.sh
    else
        exit 0
    fi
else
    echo "Aborting!"
    sleep 1
    exit 1
fi