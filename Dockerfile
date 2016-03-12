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
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

ADD app /app

ADD config/nginx.conf /etc/nginx/

# Define working directory.
WORKDIR /app

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 8080
