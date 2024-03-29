FROM artifactory-dev.jfrogbeta.com/docker-local/ubuntu:xenial

MAINTAINER Mark Galpin markg@jfrog.com

RUN /bin/bash -c cd ~; cd /home ; mkdir -p exec
ADD jdk/openjdk-11-linux-x64.tar.gz /home/exec
ENV JAVA_HOME=/home/exec/jdk-11
ADD tomcat/apache-tomcat-9.tar.gz /home/exec
RUN /bin/bash -c cd /home/exec; mv /home/exec/apache-tomcat-9.* /home/exec/tomcat
ADD tomcat/server.xml /home/exec/tomcat/conf
ENV CATALINA_HOME=/home/exec/tomcat
ENV TEST_ENV=4

CMD /bin/bash -c cd /home/exec; /home/exec/tomcat/bin/catalina.sh run
