FROM artifactory-dev.jfrogbeta.com/docker-local/dsop/ubi7

MAINTAINER Mark Galpin markg@jfrog.com

RUN /bin/bash -c cd ~; cd /home ; mkdir -p exec
ADD jdk/openjdk-11-linux-x64.tar.gz /home/exec
ENV JAVA_HOME=/home/exec/jdk-11
RUN sed "/securerandom.source=/{s/file:\/dev\/random/file:\/dev\/urandom/}" /home/exec/jdk-11/jre/lib/security/java.security -i

ADD tomcat/apache-tomcat-8.tar.gz /home/exec
RUN /bin/bash -c cd /home/exec; mv /home/exec/apache-tomcat-8.* /home/exec/tomcat
ADD tomcat/server.xml /home/exec/tomcat/conf
ENV CATALINA_HOME=/home/exec/tomcat
ENV TEST_ENV=2

CMD /bin/bash -c cd /home/exec; /home/exec/tomcat/bin/catalina.sh run