FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update --fix-missing
RUN apt-get install -y build-essential git golang-1.14-go curl 

RUN git clone https://github.com/kubesphere/kubeeye.git
WORKDIR /kubeeye
RUN PATH=$PATH:/usr/lib/go-1.14/bin make install

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh 
RUN ./get_helm.sh

FROM ubuntu
SHELL ["/bin/bash", "-c"]
COPY --from=0 /usr/local/bin/ke /usr/local/bin
COPY --from=0 /usr/local/bin/helm /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install emacs-nox procps nmap bind9-dnsutils netcat socat nginx openssl binwalk nmap curl 
RUN curl -LO https://dl.k8s.io/release/v1.21.0/bin/linux/$(if [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin
