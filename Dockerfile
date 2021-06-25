# *******************************************************
# build
# *******************************************************
FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y update --fix-missing
RUN apt-get install -y build-essential git golang-1.14-go curl 

# kubeeye
RUN git clone https://github.com/kubesphere/kubeeye.git
WORKDIR /kubeeye
RUN PATH=$PATH:/usr/lib/go-1.14/bin make install

# helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh 
RUN ./get_helm.sh
  
# *******************************************************
# run
# *******************************************************
FROM ubuntu
SHELL bash
COPY --from=0 /usr/local/bin/ke /usr/local/bin
COPY --from=0 /usr/local/bin/helm /usr/local/bin

# network and general tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update --fix-missing
RUN apt-get -y install emacs-nox procps nmap bind9-dnsutils netcat socat nginx openssl binwalk curl unzip tcpdump tcpreplay iputils-ping

# kubectl
RUN curl -LO https://dl.k8s.io/release/v1.21.0/bin/linux/$(if [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin

# amicontained
ENV AMICONTAINED_SHA256="d8c49e2cf44ee9668219acd092ed961fc1aa420a6e036e0822d7a31033776c9f"

RUN curl -fSL "https://github.com/genuinetools/amicontained/releases/download/v0.4.9/amicontained-linux-amd64" -o "/usr/local/bin/amicontained" \
	&& echo "${AMICONTAINED_SHA256}  /usr/local/bin/amicontained" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/amicontained"
