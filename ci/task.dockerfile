FROM debian:9

RUN apt-get update
RUN apt-get install wget -y
RUN apt-get install unzip -y

RUN wget https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip
RUN unzip vault_1.2.3_linux_amd64.zip
RUN mv vault /usr/local/bin/vault

ENTRYPOINT [ "vault" ]