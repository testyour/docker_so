FROM centos:7
ENV container docker
RUN yum install -y epel-release; \
yum update -y; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*; \
yum -y install nginx; \
echo 'Hi, I am in your container' > /usr/share/nginx/html/index.html; \
systemctl restart nginx.service; \
yum clean all; 
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]