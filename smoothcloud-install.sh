BIN="/usr/bin/"
APT="false"
YUM="false"
PACMAN="false"
ZYPPER="false"
DNF="false"

APT_INSTALLED=$(command -v apt)
case $APT_INSTALLED in
$BIN*)
  APT="true";;
*)
  YUM_INSTALLED=$(command -v yum)
  case $YUM_INSTALLED in
  $BIN*)
    YUM="true";;
  *)
    PACMAN_INSTALLED=$(command -v pacman)
    case $PACMAN_INSTALLED in
    $BIN*)
      PACMAN="true";;
    *)
      ZYPPER_INSTALLED=$(command -v zypper)
      case $ZYPPER_INSTALLED in
      $BIN*)
        ZYPPER="true";;
      *)
        DNF_INSTALLED=$(command -v dnf)
        case $DNF_INSTALLED in
        $BIN*)
          DNF="true";;
        esac
      esac
    esac
  esac
esac

while true; do
    read -r -p "Do you wish to install this programm? (Yy/Nn): " yn
    case $yn in
      [Yy]*)
        UNZIP_INSTALLED=$(command -v unzip)
        case $UNZIP_INSTALLED in
        $BIN*) ;;
        *)
          while true; do
              read -r -p "No installation of unzip found. Do you wish to install it? (Yy/Nn): " yn
              case $yn in
              [Yy]*)
                if "$APT" == "true"; then
                    sudo apt install unzip
                elif "$YUM" == "true"; then
                    sudo yum install unzip
                elif "$PACMAN" == "true"; then
                    sudo pacman -S unzip
                elif "$ZYPPER" == "true" ; then
                    sudo zypper install unzip
                elif "$DNF" == "true"; then
                    sudo dnf install unzip
                else
                  echo "No valid installation method found! Please install apt, yum, pacman, zypper or dnf before executing this file!"
                  exit;
                fi
                break;;
              [Nn]*) exit;;
              *) echo "Please answer yes or no!";;
              esac
          done
          ;;
        esac

        WGET_INSTALLED=$(command -v wget)
        case $WGET_INSTALLED in
        $BIN*) ;;
        *)
          while true; do
              read -r -p "No installation of wget found. Do you wish to install it?"
              case $yn in
              [Yy]*)
                if "$APT" == "true"; then
                    sudo apt install wget
                elif "$YUM" == "true"; then
                    sudo yum install wget
                elif "$PACMAN" == "true"; then
                    sudo pacman -S wget
                elif "$ZYPPER" == "true"; then
                    sudo zypper install wget
                elif "$DNF" == "true"; then
                    sudo dnf install wget
                else
                  echo "No valid installation method found! Please install apt, yum, pacman, zypper or dnf before executing this file!"
                  exit;
                fi
                break;;
              [Nn]*) exit;;
              *) echo "Please answer yes or no!";;
              esac
          done
          ;;
        esac

        wget https://github.com/SmoothCloudServices/download-test/releases/latest/download/smoothcloud.zip
        unzip smoothcloud.zip
        rm smoothcloud.zip
        echo "Installation finished!"
        while true; do
            read -r -p "Do you wish to start smoothcloud? (Yy/Nn): " yn
            case $yn in
            [Yy]*)
              (chmod +x smoothcloud-start.sh && ./smoothcloud-start.sh)
              break;;
            [Nn]*)  exit;;
            *) echo "Please answer yes or no!";;
            esac
        done
        break;;
      [Nn]*) exit;;
      *) echo "Please answer yes or no!"
    esac
done