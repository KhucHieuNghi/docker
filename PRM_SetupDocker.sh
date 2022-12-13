#!/bin/bash

# Script to install PRM server and all related components

####### Global #######
OS_INDEX=0
SUPPORT_OS=("Ubuntu1604" "Ubuntu1804" "Ubuntu2004" "RHEL7" "RHEL82" "OpenSUSE")
REDIS_VERSION=("5.0.5" "5.0.5" "5.0.5" "5.0.5" "5.0.5" "5.0.5")
PYTHON_VERSION=("2.7.12" "2.7.17" "2.7.18" "2.7.5" "2.7.17" "2.7.18")
NODE_VERSION=("16.13.2" "16.13.2" "16.13.2" "16.13.2" "16.13.2" "16.13.2")
NODE4PES_VERSION=("12.18.4" "12.18.4" "12.18.4" "12.18.4" "12.18.4" "12.18.4")
NGINX_VERSION=("1.20.2" "1.20.2" "1.20.2" "1.20.2" "1.20.2" "1.20.2")

USER=$(who am i | awk '{print $1}')
GROUP=$(id -Gn)

ETC_HOSTS_FILE="/etc/hosts"
BASE_DIR="/home/$USER"
TEMP_DIR="/tmp"
PROJECT_DIR="PRM"
DATA_DIR="$PROJECT_DIR/Data"
SCRATCH_DIR="$DATA_DIR/scratch"
UPLOAD_DIR="$SCRATCH_DIR/uploads"
CONFIG_DIR="$DATA_DIR/config"
CONFIG_BACKUP_DIR="$CONFIG_DIR/backup"
PID_DIR="$PROJECT_DIR/pid"
LOGS_DIR="$PROJECT_DIR/mrbs_logs"
HUB_DIR="$PROJECT_DIR/Hub"
SUPERVISOR_DIR="$PROJECT_DIR/Supervisor"
WEB_DIR="$PROJECT_DIR/Web"
PES_DIR="$PROJECT_DIR/Pes"
NODE_BASE_DIR="/opt/PRM/nodejs"
SCRIPT_DATA_FILE="/var/cache/prm_setup_info"

HOST_IP=""

PSQL_USERNAME="postgres"
PSQL_PASSWORD=""
PSQL_DB_NAME="mrbs"
PSQL_DB_PES="PES"

BRT_CERTIFICATES="Y"
HTTP_CERT_KEY="$DATA_DIR/certs/ec_private_key_prm.pem"
HTTP_CERT="$DATA_DIR/certs/ec_cert_prm.pem"
        
PRM_PACKAGE_DIR="PRM_v4.2.9"

SETUP_LOG="PRM_Setup.log"

check_prerequisites (){
  echo "[Info] Checking Prerequisites…"
  DOCKERV=$( docker version --format '{{.Server.Version}}' )
  
  if [ -z $DOCKERV ]
  then
    echo "[Error] Before running this script file, ensure ' ./PRM_SetupDocker.sh' has been executed"
    exit 1
  fi
  
}

# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
# sudo docker–compose --version
function install() {
 echo 'Runing'
 docker volume create portainer_data
 docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
 
 docker-compose up --build -d

 docker restart portainer

 echo '${RED}https://localhost:9443'
}

function uninstall() {
    echo 'Uninstall Runing'
    
    docker stop portainer
    docker rm portainer
    docker volume rm portainer_data

    docker-compose down -v
    
    docker rmi $(docker images -a -q)
    echo 'Uninstall Success' 
}

function main() {
    check_prerequisites

    whiptail --msgbox "Welcome to PRM installer!" 0 0 --ok-button "Next"

    if [[ ! -f $SCRIPT_DATA_FILE ]]; then
        _choice=$(whiptail --title "PRM Installation" --radiolist "What would you like to proceed?" 0 0 0 "Install" "" OFF "Cancel" "" OFF 3>&2 2>&1 1>&3)
    else
        _choice=$(whiptail --title "PRM Installation" --radiolist "What would you like to proceed?" 0 0 0 "Reinstall" "" OFF "Uninstall" "" OFF 3>&2 2>&1 1>&3)
    fi

    case $_choice in
    "Install")
        install
    ;;
    "Reinstall")
        uninstall
        install
    ;;
    "Uninstall")
        uninstall
    ;;
    "Cancel")
        uninstall
    ;;
    esac
}

# Tee all output to log file
exec &> >(tee -a "$SETUP_LOG")

main $@

require
install docker 
docker-swam
python