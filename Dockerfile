#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/*

ADD app /app

ADD config/nginx.conf /etc/nginx/

RUN mkdir /tmp/nginx && \
    chown -R 1001:0 /tmp/nginx && \
    chmod -R ug+rwx /tmp/nginx && \
	chown -R 1001:0 /app && \
	chmod ug+rwx /etc/nginx/nginx.conf && \
	mkdir /tmp/logs && \
	chown -R 1001:0 /tmp/logs && \
	chmod -R ug+rwx /tmp/logs

# Define working directory.
WORKDIR /app

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 8080
