FROM fedora:37

LABEL maintainer "Igor Talevski <igor.talevski@internetbrands.com>"

EXPOSE 80

ARG HOST_UID
ARG PHP_VERSION

VOLUME /var/www/html

# Lets create some folders for the image_resizer
RUN mkdir -p /var/{media,content}
RUN mkdir /var/media/smb
RUN ln -s /var/media /var/media/smb/webmgr


RUN dnf -y update --refresh

RUN echo "Build for PHP" $PHP_VERSION


# Install node
RUN sudo dnf install -y gcc-c++ make 
RUN curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash - 
RUN dnf install -y nodejs 

# Install PHP
RUN dnf -y install http://rpms.remirepo.net/fedora/remi-release-37.rpm
RUN dnf module enable php:remi-$PHP_VERSION -y

RUN dnf -y install git mc wget curl iputils vim nano ne lynx tar bzip2 zip unzip mod_ssl httpd cronolog

RUN dnf -y install php php-gd  php-pdo  php-mbstring  php-pear  php-mysqlnd  php-bcmath  php-cli  
RUN dnf -y install php-common  php-devel  php-fpm  php-gmp  php-intl  php-json  php-mcrypt  php-pgsql  
RUN dnf -y install php-opcache  php-pear  php-process  php-pspell  php-xml  php-xdebug  php-soap  
RUN dnf -y install php-pecl-uuid  php-pecl-zip  php-tidy php-memcache php-memcached 
RUN dnf -y install tidy ImageMagick php-imagick php-redis

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/local/bin/composer 
RUN chmod +x /usr/local/bin/composer


# Install gitflow
RUN dnf install -y 'dnf-command(copr)'
RUN dnf copr enable -y elegos/gitflow
RUN dnf install -y gitflow

# update postgresql
RUN dnf module reset postgresql -y
RUN dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/F-37-x86_64/pgdg-fedora-repo-latest.noarch.rpm
RUN dnf install -y postgresql14

RUN dnf install -y bash-completion

RUN dnf install -y doas;
RUN mkdir -p /etc/doas.d/
RUN  adduser docker -G wheel; \
        echo 'docker:docker' | chpasswd; \
        echo 'permit nopass :wheel as root' > /etc/doas.d/doas.conf


RUN dnf clean all

RUN mkdir -p /run/php-fpm






# Apache SSL
COPY ./ssl/certs/localhost.crt /etc/pki/tls/certs/localhost.crt
COPY ./ssl/private/localhost.key /etc/pki/tls/private/localhost.key



# Fix some permission issues

RUN mkdir -p /etc/httpd/logs

RUN chown -R docker:$HOST_UID /etc/httpd/logs
RUN chown -R docker:$HOST_UID /run/httpd
RUN chown -R docker:$HOST_UID /etc/httpd
RUN chown -R docker:$HOST_UID /var/log
RUN chown -R docker:$HOST_UID /var/media
RUN chown -R docker:$HOST_UID /run/php-fpm

RUN curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /home/docker/.git-completion.bash


RUN git clone https://github.com/mubaris/motivate.git
RUN mkdir -p /opt/motivate
RUN cp -r /motivate/motivate/data /opt/motivate/
RUN chmod -R 777 /opt/motivate/data
RUN cp /motivate/motivate/motivate.py /opt/motivate/
RUN ln -s /opt/motivate/motivate.py /usr/local/bin/motivate

USER docker

# ENTRYPOINT ["/bin/sh", "-c" , "/usr/local/bin/entrypoint.sh && source /home/docker/.bashrc && /usr/sbin/php-fpm && /usr/sbin/httpd -DFOREGROUND "]
ENTRYPOINT ["/bin/sh", "-c" , "/usr/local/bin/entrypoint.sh && /usr/sbin/php-fpm && /usr/sbin/httpd -DFOREGROUND && cat /etc/motd "]

