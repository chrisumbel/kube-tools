FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get install -y build-essential git golang-1.14-go
RUN git clone https://github.com/kubesphere/kubeeye.git
WORKDIR /kubeeye
RUN PATH=$PATH:/usr/lib/go-1.14/bin make install

FROM ubuntu
COPY --from=0 /usr/local/bin/ke /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install emacs-nox procps nmap bind9-dnsutils netcat socat nginx openssl binwalk nmap curl 
RUN curl -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(uname -m)/kubectl" 
RUN chmod +x /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh 
RUN ./get_helm.sh

