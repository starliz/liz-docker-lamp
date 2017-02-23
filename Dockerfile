# Specify the base image (FROM)
# Specify the maintainer (MAINTAINER)
# Run a command (RUN)
# Add a file or directory (ADD)
# Create an environment variable (ENV)
# What process to run when launching a container from this image (CMD)
# Create a mount point with the specified name and mark it as holding externally mounted volumes from native host (VOLUME)

# To use ubuntu blueprint image or "define base image" in other words.
FROM ubuntu:trusty

# Avoid need for manual intervention or the interactive post-install configuration dialog.
ENV DEBIAN_FRONTEND noninteractive
# Update sources: get information on the newest versions of packages and their dependencies.
RUN apt-get update -y
# "apt-get -y" - Assume "yes" as answer to all prompts and run non-interactively.


# Apache installation and configuration
#==========================================
RUN apt-get -y install apache2 curl
RUN mkdir -p /var/lock/apache2 /var/run/apache2
# Add starting scripts
ADD start-apache2.sh /start-apache2.sh
# use prepared configuration file
ADD apache2.conf /etc/apache2/apache2.conf
# make sure .sh is executable
RUN chmod 755 /*.sh

# config to enable .htaccess
# ADD apache_default /etc/apache2/sites-available/000-default.conf
# ADD a2enmod rewrite
# Enable user module, which allows user-specific directories to be accessed using the http://example.com/~user/ syntax.
#RUN a2enmod userdir
# Create a folder for html files
ADD index.html /var/www/html/index.html


# MySQL installation and configuration
#==========================================
RUN apt-get -y install mysql-server pwgen
# starting script
ADD start-mysqld.sh /start-mysqld.sh
# make sure *.sh is executable
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*
# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh
# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]


# PHP installation and setup
#==========================================
RUN apt-get -y install libapache2-mod-php5 php5-mysql php-apc
#RUN apt-get -y install php-mcrypt
#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M


# The PHP app
#==========================================
# Configure /app folder with sample app
# RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
# An app example copied from https://github.com/fermayo/hello-world-lamp/blob/master/index.php
ADD index.php /app/index.php
#RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
RUN rm -fr /var/www/html && ln -s /app /var/www/html


# supervisord
#==========================================
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/

ADD run.sh /run.sh
RUN chmod 755 /*.sh

# map apache 80 port and 3306 for mysql database server connections.
# EXPOSE informs Docker that the container listens on the specified network ports
EXPOSE 80 3306

#CMD ["supervisord", "-n"]
CMD ["/run.sh"]
