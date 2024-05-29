FROM debian
RUN apt-get update && \
    apt-get -y install curl \
                       unzip \
                       wget \
		       vim \
		       iputils-ping \ 
		       dnsutils \
                       dpkg \
		       apache2
RUN cat /etc/os-release
RUN wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest%2Bubuntu22.04_all.deb && \
    dpkg -i zabbix-release_latest+ubuntu22.04_all.deb && \
    apt-get update
RUN apt-get install -y zabbix-agent zabbix-sender
COPY ./zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./resolv.conf /etc/resolv.conf
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 10050
USER zabbix
CMD ["/usr/local/bin/entrypoint.sh"]
