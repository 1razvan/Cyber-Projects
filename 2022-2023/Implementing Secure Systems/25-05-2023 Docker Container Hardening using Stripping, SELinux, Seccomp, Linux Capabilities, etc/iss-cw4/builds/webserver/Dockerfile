# Webserver Dockerfile

FROM centos:7

# Install the required packages on the container.
RUN 	yum install epel-release -y && \
	yum update -y && \
	yum install -y \
	nginx \
	php \
	php-mysqlnd \
	php-fpm
	
# Copy webfiles directory into container.
COPY webfiles/ /usr/share/nginx/html

# Copy the provided configuration and webfiles into container.
COPY configfiles/nginx.conf     /etc/nginx/nginx.conf
COPY configfiles/php.ini        /etc/php.ini
COPY configfiles/www.conf       /etc/php-fpm.d/www.conf
COPY configfiles/php-fpm.conf   /etc/nginx/conf.d/php-fpm.conf
COPY configfiles/docker-entrypoint.sh /

# Remove not needed webfiles. Make entrypoint script executable. Change php file permissions.
RUN rm -f /usr/share/nginx/html/index.html /usr/share/nginx/html/nginx-logo.png /usr/share/nginx/html/poweredby.png
RUN chmod +x /docker-entrypoint.sh && \
    chown apache:apache /usr/share/nginx/html/*.php

# Specify which port the container listens on.
EXPOSE 80

# Specify container's entrypoint.
ENTRYPOINT ["/docker-entrypoint.sh"]
