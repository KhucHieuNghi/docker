#!/bin/bash

# Script to install PRM server and all related components

####### Global #######
# OS_INDEX=0
# SUPPORT_OS=("Ubuntu1604" "Ubuntu1804" "Ubuntu2004" "RHEL7" "RHEL82" "OpenSUSE")
# REDIS_VERSION=("5.0.5" "5.0.5" "5.0.5" "5.0.5" "5.0.5" "5.0.5")
# PYTHON_VERSION=("2.7.12" "2.7.17" "2.7.18" "2.7.5" "2.7.17" "2.7.18")
# NODE_VERSION=("16.13.2" "16.13.2" "16.13.2" "16.13.2" "16.13.2" "16.13.2")
# NODE4PES_VERSION=("12.18.4" "12.18.4" "12.18.4" "12.18.4" "12.18.4" "12.18.4")
# NGINX_VERSION=("1.20.2" "1.20.2" "1.20.2" "1.20.2" "1.20.2" "1.20.2")

# USER=$(who am i | awk '{print $1}')
# GROUP=$(id -Gn)

# ETC_HOSTS_FILE="/etc/hosts"
# BASE_DIR="/home/$USER"
# TEMP_DIR="/tmp"
# PROJECT_DIR="PRM"
# DATA_DIR="$PROJECT_DIR/Data"
# SCRATCH_DIR="$DATA_DIR/scratch"
# UPLOAD_DIR="$SCRATCH_DIR/uploads"
# CONFIG_DIR="$DATA_DIR/config"
# CONFIG_BACKUP_DIR="$CONFIG_DIR/backup"
# PID_DIR="$PROJECT_DIR/pid"
# LOGS_DIR="$PROJECT_DIR/mrbs_logs"
# HUB_DIR="$PROJECT_DIR/Hub"
# SUPERVISOR_DIR="$PROJECT_DIR/Supervisor"
# WEB_DIR="$PROJECT_DIR/Web"
# PES_DIR="$PROJECT_DIR/Pes"
# NODE_BASE_DIR="/opt/PRM/nodejs"
# SCRIPT_DATA_FILE="/var/cache/prm_setup_info"

# HOST_IP=""

# PSQL_USERNAME="postgres"
# PSQL_PASSWORD=""
# PSQL_DB_NAME="mrbs"
# PSQL_DB_PES="PES"

# BRT_CERTIFICATES="Y"
# HTTP_CERT_KEY="$DATA_DIR/certs/ec_private_key_prm.pem"
# HTTP_CERT="$DATA_DIR/certs/ec_cert_prm.pem"
        
# PRM_PACKAGE_DIR="PRM_v4.2.9"

SETUP_LOG="PRM_Setup.log"

RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'  

check_prerequisites (){
  echo "[Info] Checking Prerequisites…"
  DOCKER_V=$( docker version --format '{{.Server.Version}}' )
  DOCKER_COMPOSE_V=$( docker-compose version --short )
  DOCKER_SWARM_V=$( docker swarm ca  )
  
  if [ -z $DOCKER_V ]
  then
    echo "[Error] Before running this script file, ensure 'docker' has been executed"
    echo -e "${RED}----------Install Docker Step by Step----------"
    echo -e "${BLUE}>> sudo apt-get update -y"
    echo -e "${BLUE}>> sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin"
    echo -e "${RED}------------------------------------------------------${NC}"
    exit 1;
  fi;

  if [ -z $DOCKER_COMPOSE_V ]
  then
    echo "[Error] Before running this script file, ensure docker-compose has been executed"
    echo -e "${RED}----------Install DockerCompose Step by Step----------"
    echo -e "${BLUE}>> sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose"
    echo ">> sudo chmod +x /usr/local/bin/docker-compose"
    echo -e ">> docker-compose --version${NC}"
    echo -e "${RED}------------------------------------------------------${NC}"
    exit 1;
  fi;

  if [ -z $DOCKER_SWARM_V ]
  then
    echo "[Error] Before running this script file, ensure 'docker swarm' has been executed"
    echo -e "${RED}----------Install DockerCompose Step by Step----------"
    echo -e "${BLUE}>> docker swarm init && docker swarm join-token manager"
    echo -e ">> docker swarm ca${NC}"
    echo -e "${RED}------------------------------------------------------${NC}"
    exit 1;
  fi;
  
}

function install() {
 echo -e "${BLUE}--------------------Runing--------------------${NC}"

if [ $( docker ps -a | grep portainer | wc -l ) -gt 0 ]; then
    echo -e "${RED}Portainer existed${NC} "
else
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
fi

 echo -e "${BLUE}--------------------Loading Images--------------------${NC}"

#  docker load < prmImages.tar.gz

 echo -e "${BLUE}--------------------Success Load Images--------------------${NC}"
 
 echo -e "${BLUE}--------------------Running Stack--------------------${NC}"

 docker-compose up --detach --build

 echo -e "${BLUE}--------------------Success Run--------------------${NC}"


 echo  -e "Portal: ${RED}https://localhost:9443${NC}"
 echo  -e "WMC: ${RED}https://web.prm.local${NC}"

 docker restart portainer
 exit;
}

function uninstall() {
    echo -e "${BLUE}--------------------Runing Uninstall--------------------"
    
    docker-compose down -v
    
    docker rmi postgres redis nginx pes prm wmc

    echo -e "${BLUE}--------------------Success Uninstall--------------------"

    exit;
}

function main() {
    # check_prerequisites
    install
    # uninstall
    # whiptail --msgbox "Welcome to PRM installer!" 0 0 --ok-button "Next"

    # if [ $( docker ps -a | grep wmc | wc -l ) -gt 0 ]; then
    #     _choice=$(whiptail --title "PRM Installation" --radiolist "What would you like to proceed?" 0 0 0 "Uninstall" "" OFF "Cancel" "" OFF 3>&2 2>&1 1>&3)
    # else
    #     _choice=$(whiptail --title "PRM Installation" --radiolist "What would you like to proceed?" 0 0 0 "Install" "" OFF "Cancel" "" OFF 3>&2 2>&1 1>&3)
    # fi

    # case $_choice in
    # "Install")
    #     install
    # ;;
    # "Uninstall")
    #     uninstall
    # ;;
    # esac
}

# Tee all output to log file
exec &> >(tee -a "$SETUP_LOG")

main $@