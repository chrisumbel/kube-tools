FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install emacs-nox procps nmap bind9-dnsutils netcat socat nginx openssl binwalk nmap
