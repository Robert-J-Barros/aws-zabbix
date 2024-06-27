#!/bin/bash

echo "____  _     ___   ____ _  _______ ___ __  __ _____"
echo "| __ )| |   / _ \ / ___| |/ /_   _|_ _|  \/  | ____|"
echo "|  _ \| |  | | | | |   | ' /  | |  | || |\/| |  _|"
echo "| |_) | |__| |_| | |___| . \  | |  | || |  | | |___"
echo "|____/|_____\___/ \____|_|\_\ |_| |___|_|  |_|_____|"
echo ""
echo "__        _______ _     ____ ___  __  __ _____"
echo "\ \      / / ____| |   / ___/ _ \|  \/  | ____|"
echo " \ \ /\ / /|  _| | |  | |  | | | | |\/| |  _|"
echo "  \ V  V / | |___| |__| |__| |_| | |  | | |___"
echo "   \_/\_/  |_____|_____\____\___/|_|  |_|_____|"
echo ""

show_menu() {
    echo "1) Start first time application"
    echo "2) Create new client"
    echo "3) Delete client "
    echo "4) Exit"
}

while true; do
    show_menu
    read -p "Select a option: " option

    case $option in
        1)
            echo "Start Application"
            # Verifica se o Docker está instalado
            if ! command -v docker &> /dev/null; then
                echo "Docker is not installed. Instaling Docker..."
                sudo apt-get update
                sudo apt-get install -y ca-certificates curl
                sudo mkdir -p /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker-archive-keyring.asc
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose
                sudo groupadd docker
                sudo usermod -aG docker $USER
                newgrp docker
            else
                echo "Docker installed."
            fi

            echo "Configuring aws credential..."
            read -p "provide access_key: " access_key
            read -p "provide secret_key: " secret_key
            read -p "provide region: " region

    	    cd ~/aws-zabbix/ && docker-compose up -d --build
	    docker exec -it zabbix-agent aws configure set aws_access_key_id $access_key
            docker exec -it zabbix-agent aws configure set aws_secret_access_key $secret_key
            docker exec -it zabbix-agent aws configure set region $region
            sudo echo "./Dockerfile/zabbix.conf/runner/crontab" >> /etc/crontab
            sudo chmod +x ./Dockerfile/zabbix.conf/runner/crontab.sh
            sudo ./Dockerfile/zabbix.conf/runner/crontab.sh
	    ;;
        2)
	   echo "Creating a new client"
            read -p "Input new client (will use how container name): " novo_cliente
            image="robert132/zabbix-agent:1.3"
            network="aws-zabbix_zabbix-net"

            # Criar diretório e copiar arquivo de configuração
            mkdir -p ./volumes/zabbix-agent/$novo_cliente
            cp ./volumes/zabbix-agent/zabbix_agentd.conf ./volumes/zabbix-agent/$novo_cliente/zabbix_agentd.conf
            sed -i "s/^Hostname=.*/Hostname=$novo_cliente/" "./volumes/zabbix-agent/$novo_cliente/zabbix_agentd.conf"

            docker pull $image
            if docker image inspect $image &> /dev/null; then
                docker run -d --name $novo_cliente --network $network $image
                docker cp ./volumes/zabbix-agent/$novo_cliente/zabbix_agentd.conf $novo_cliente:/etc/zabbix/zabbix_agentd.conf
                echo "New container '$novo_cliente' successful created and conneted on network '$network'."
		echo "Configuring aws credential..."
            	read -p "provide access_key: " access_key
                read -p "provide secret_key: " secret_key
                read -p "provide region: " region

                cd ~/aws-zabbix/ && docker-compose up -d --build
                docker exec -it $novo_cliente aws configure set aws_access_key_id $access_key
                docker exec -it $novo_cliente aws configure set aws_secret_access_key $secret_key
                docker exec -it $novo_cliente aws configure set region $region
            else
                echo "Erro: The Docker image '$image' not is avaliable."
            fi
	    ;;
        3)
            echo "Deleting  client..."
            echo "Delete cliente..."
            read -p "Enter the name of the client to be deleted (container name): " cliente
            docker rm -f $cliente
	    rm -rf ./volumes/zabbix-agent/$cliente
            echo "Container '$cliente' successful"
            ;;
        4)
            echo "Exit Program"
	    echo "
 ______   _______   ______   _______
| __ ) \ / / ____| | __ ) \ / / ____|
|  _ \\ V /|  _|   |  _ \\ V /|  _|
| |_) || | | |___  | |_) || | | |___
|____/ |_| |_____| |____/ |_| |_____|
	    "
            break
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done

