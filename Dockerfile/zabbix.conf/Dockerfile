FROM debian
RUN apt-get update && \
    apt-get -y install curl \
                       unzip \
                       wget \
		       vim \
		       iputils-ping \ 
		       dnsutils \
                       dpkg \
		       apache2 \
		       telnet \
		       sudo \
		       less \
		       cron \
		       openssh-client
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" | tee /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
RUN cat /etc/os-release
RUN wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest%2Bubuntu22.04_all.deb && \
    dpkg -i zabbix-release_latest+ubuntu22.04_all.deb && \
    apt-get update
RUN apt-get install -y zabbix-agent zabbix-sender
RUN apt-get install -y jq bc 
COPY ./zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
RUN aws --version 
COPY userparameter_aws.conf /etc/zabbix/zabbix_agentd.d
RUN mkdir /var/lib/zabbix
RUN mkdir /var/lib/zabbix/.aws
RUN chown zabbix:zabbix /var/lib/zabbix
RUN touch /var/lib/zabbix/.aws/config
RUN touch /var/lib/zabbix/.aws/credentials
RUN chown -R zabbix:zabbix /var/lib/zabbix/.aws && chmod 600 /var/lib/zabbix/.aws/*
RUN mkdir /etc/zabbix/scripts
COPY scripts/* /etc/zabbix/scripts/
RUN chmod +x /etc/zabbix/scripts/*
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN mkdir /var/lib/zabbix/keys
COPY keys/* /var/lib/zabbix/keys/
RUN chmod 600 /var/lib/zabbix/keys/*.pem
RUN chown zabbix:zabbix /var/lib/zabbix/keys/*.pem
RUN touch /var/log/crontab.log
EXPOSE 10050
USER zabbix
CMD ["/usr/local/bin/entrypoint.sh"]
