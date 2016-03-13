#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

FROM openshift/base-centos7
MAINTAINER david.strejc@gmail.com

RUN yum update -y ;\
	  yum install -y nginx


ADD config/nginx.conf /etc/nginx/

RUN mkdir /tmp/nginx && \
    chown -R 1001:0 /tmp/nginx && \
    chown -R 1001:0 /app && \
    chmod -R ug+rwx /tmp/nginx && \
	chmod ug+rwx /etc/nginx/nginx.conf && \
	mkdir /tmp/logs && \
	chown -R 1001:0 /tmp/logs && \
	chmod -R ug+rwx /tmp/logs

# Define working directory.
WORKDIR /app

ADD app /app

RUN fix-permissions /app || echo "OK"

USER 1001

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 8080
