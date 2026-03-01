FROM ubuntu:22.04
RUN apt-get update -y && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata openjdk-11-jdk tar wget git zip openssh-server curl apt-transport-https ca-certificates curl gnupg-agent software-properties-common
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata
WORKDIR /opt

RUN wget https://services.gradle.org/distributions/gradle-6.6.1-bin.zip -P /tmp && unzip -d /opt/gradle /tmp/gradle-*.zip

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip && unzip sonar-scanner-cli-4.2.0.1873-linux.zip  &&  mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner

COPY ./sonar-scanner.properties /opt/sonar-scanner/conf/sonar-scanner.properties

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && apt-get  -y install docker-ce docker-ce-cli containerd.io

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/aws-iam-authenticator  && \
    curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/aws-iam-authenticator.sha256  && \
    openssl sha1 -sha256 aws-iam-authenticator  && \
    chmod +x ./aws-iam-authenticator  && \
    mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin  && \
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    apt-get install zip && \
    unzip awscliv2.zip && \
    ./aws/install
RUN helm plugin install https://github.com/hypnoglow/helm-s3.git
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV GRADLE_HOME=/opt/gradle/gradle-6.6.1
ENV PATH ${GRADLE_HOME}/bin:${PATH}
ENV PATH="$PATH:/opt/sonar-scanner/bin"

WORKDIR /root

#COPYING SSH CREDENTIALS

COPY ./ssh/ .ssh/

ADD ./sshd_config /etc/ssh/sshd_config
ADD ./ssh_config /etc/ssh/ssh_config

CMD ["/usr/sbin/sshd", "-D"]