FROM centos:7

# install httpd
RUN yum update -y && yum install -y httpd httpd-tools vim net-tools telnet

# install php 7.4
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install yum-utils
RUN yum-config-manager --enable remi-php74
RUN yum update -y
RUN yum install -y php php-cli php-mysql

EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]