FROM centos:7

ENV JAVA_VERSION_MAJOR 7
ENV JAVA_VERSION_MINOR 79
ENV JAVA_VERSION_BUILD 15
ENV JAVA_HOME /usr/java/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}
ENV JENKINS_VERSION_MAJOR 2
ENV JENKINS_VERSION_MINOR 7
ENV JENKINS_HOME /var/lib/jenkins


# Installing JDK

RUN     curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm \
        > jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm &&\
        rpm -i jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm &&\
        rm -f jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.rpm &&\
        curl -sf -o /etc/yum.repos.d/jenkins.repo -L http://pkg.jenkins.io/redhat/jenkins.repo &&\

# Installing Jenkins, Ansible, Docker
        rpm --import http://pkg.jenkins.io/redhat/jenkins.io.key &&\
        yum -y install epel-release &&\
        yum -y update &&\
        yum -y install jenkins-${JENKINS_VERSION_MAJOR}.${JENKINS_VERSION_MINOR}-1.1 &&\
        yum -y install ansible &&\
        yum -y install docker &&\

# Installing Mercurial
        yum -y install mercurial \
        supervisor

WORKDIR $JENKINS_HOME/

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/files/supervisord.conf"]

