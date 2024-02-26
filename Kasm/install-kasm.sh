#!/bin/bash

if [[ ${UID} -ne 0 ]];
then
    echo "You aren't ROOT";
    echo "Exiting...";
    exit 1;
else
    echo "You are ROOT";
    echo "Proceeding";
fi

# Just in case Debian 12 does NOT come with curl command
apt install -y curl;

# Need to ipv4_forward = 1
echo 1 > /proc/sys/net/ipv4/ip_forward;

# Chmod 777
echo "Chmod 777 to all essential directory!!";
sudo chmod 777 ./bin;
sudo chmod 777 ./bin/utils;
sudo chmod 777 ./bin/utils/yq_x86_64;
sudo chmod 777 ./bin/utils/*;
bash ./install.sh;

echo "Installing Docker.io for docker kommand :D";
sudo apt install -y docker\.io;
if [[ $? -eq 0 ]];
then
    echo "Succeeded in installing Docker.io for docker kommand :D";
else
    echo "Failed to install Docker.io for docker kommand :(";
    echo "Trying out yum install -y docker && yum install -y docker\.io :D";
    sudo yum install -y docker;
    if [[ $? -eq 0 ]];
    then
        echo "Succeeded in yum installing docker :D";
    else
        echo "Failed to yum install -y docker";
        echo "Trying out yum install -y docker\.io";
        sudo yum install -y docker\.io;
        if [[ $? -eq 0 ]];
        then
            echo "Succeeded in yum install -y docker\.io";
        else
            echo "Failed to yum install -y docker\.io";
        fi
    fi
fi

# Install Docker-compose
#echo "Installing Docker-compose for Kasm :D";
#mkdir -p /usr/local/lib/docker/cli-plugins
#curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose
#chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo "Preparing to do partition for Kasm";
sudo dd if=/dev/zero bs=1M count=1024 of=/mnt/1GiB.swap

if [[ ${?} -eq 0 ]];
then
    echo "Succeeded in creating .swap partition for Kasm :D";
    echo "chmod 600 /mnt/1GiB.swap";
else
    echo "Failed to create .swap partition for Kasm";
    echo "Skipping...";
fi

sudo chmod 600 /mnt/1GiB.swap;
if [[ ${?} -eq 0 ]];
then
    echo "Succeeded in chmod 600 /mnt/1GiB.swap";
else
    echo "Failed to chmod 600 /mnt/1GiB.swap";
    echo "Continue to Break-through installation!! :D";
fi

echo "Make it into swap\nmkswap /mnt/1GiB.swap";
sudo mkswap /mnt/1GiB.swap;
if [[ ${?} -eq 0 ]];
then
    echo "Done mkswap /mnt/1GiB.swap";
else
    echo "Failed to mkswap /mnt/1GiB.swap";
    echo "Breaking through installation of Kasm!!";
fi

echo "Turning on the swap...";
sudo swapon /mnt/1GiB.swap;
if [[ ${?} -eq 0 ]];
then
    echo "Succeeded in turning on the Swap";
else
    echo "Failed to turn on the Swap :(";
    echo "No worries! We'll break-through installation!!";
fi

echo "Making sure swap comes back after reboot...";
echo '/mnt/1GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab;
if [[ ${?} -eq 0 ]];
then
    echo "Alright, this swap comes back after reboot :)";
else
    echo "Failed to make this swap come back after reboot :(";
    echo "We'll break-through!!";
fi

echo "Downloading Kasm...";
sudo wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.10.0.238225.tar.gz;
if [[ ${?} -eq 0 ]];
then
    echo "Succeeded in downloading Kasm :D";
else
    echo "Failed to download Kasm :(";
    echo "No worries! We'll break-through!!";
fi

echo "Proceeding to untar Kasm...";
echo "chmod 777 ./kasm_release_1.10.0.238225.tar.gz";
sudo chmod 777 ./kasm_release_1.10.0.238225.tar.gz;
sudo tar -zxvf ./kasm_release_1.10.0.238225.tar.gz;
echo "chmod 777 ./kasm_release";
sudo chmod 777 ./kasm_release;
                            
echo "Downloading Docker Compose as a dependency of Kasm...";
sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
echo "chmod +x /usr/local/bin/docker-compose";
chmod +x /usr/local/bin/docker-compose;
echo "Current docker-compose version: ";
docker-compose --version;
docker;
                                                        
if [[ ${?} -eq 0 ]];
then
    echo "Succeeded in installing docker-compose :D";
    echo "Installing Kasm...";
                                
else
    echo "Failed to install docker-compose :(";
    echo "Please manually apt update && apt -y upgrade...";
fi

exit 0;     




