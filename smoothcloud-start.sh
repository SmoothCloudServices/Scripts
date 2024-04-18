JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F '.' '{sub("^$", "0", $2); print $1$2}')

BIN=$"/usr/bin"
case $JAVA_VER in
    [8-20]*)
      while true; do
        read -p "Do you wish to update java? (Yy/Nn): " yn
        case $yn in
        [Yy]*)
          wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.deb
          sudo dpkg -i jdk-22_linux-x64_bin.deb
          java --version

          ls -ld /usr/lib/jvm/jdk*
          sudo nano /etc/environment

          export JAVA_HOME="/usr/lib/jvm/jdk-22-oracle-x64"
          export PATH="$PATH:${JAVA_HOME}/bin"

          source  /etc/environment
          echo $JAVA_HOME
          break;;
        [Nn]*)
          echo "Aborting setup!"
          exit;;
        *) echo "Please answer yes or no!";;
        esac
      done
      ;;
    21*)
      ;;
esac

JAVA_INSTALLED=$(command -v screen)
case $JAVA_INSTALLED in
$BIN*)
  while true; do
    read -p "Java is not installed. Do you wish to install it? (Yy/Nn): " yn
    case $yn in
    [Yy]*)
      wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.deb
      sudo dpkg -i jdk-22_linux-x64_bin.deb
      java --version

      ls -ld /usr/lib/jvm/jdk*
      sudo nano /etc/environment

      export JAVA_HOME="/usr/lib/jvm/jdk-22-oracle-x64"
      export PATH="$PATH:${JAVA_HOME}/bin"

      source  /etc/environment
      echo $JAVA_HOME
      break;;
    [Nn]*)
      echo "Aborting setup!"
      exit;;
    *) echo "Please answer yes or no!";;
    esac
  done
  ;;
esac

SCREEN_INSTALLED=$(command -v screen)
case $SCREEN_INSTALLED in
$BIN*)
  while true; do
    read -p "Screen is not installed. Do you wish to install it? (Yy/Nn): " yn
    case $yn in
    [Yy]*)
      sudo apt install screen
      break;;
    [Nn]*)
      echo "Aborting setup!"
      exit;;
    *) echo "Please answer yes or no!";;
    esac
  done
  ;;
esac

java -jar Smoothcloud.jar
