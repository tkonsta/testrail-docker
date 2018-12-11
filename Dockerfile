FROM ubuntu:18.04
# Configure your proxy here if needed
#ENV http_proxy http://yourproxy:port
#ENV https_proxy http://yourproxy:port

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get install -y --no-install-recommends \
         apache2 php php-cli php-mysql php-curl php-mbstring php-xml \
         mysql-server \
         curl \
         unzip \
    && rm -rf /var/lib/apt/lists/* \
	&& ln -fs /usr/share/zoneinfo/Europe/Berlin  /etc/localtime
	

RUN curl -O http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64_10.2.7.tar.gz && \
    tar vxfz ioncube_loaders_lin_*.tar.gz && \
    rm -f ioncube_loaders_lin_*.tar.gz

RUN echo "zend_extension=/ioncube/ioncube_loader_lin_7.2.so" > /etc/php/7.2/cli/php.ini.new && \
    cat /etc/php/7.2/cli/php.ini >> /etc/php/7.2/cli/php.ini.new && \
    mv /etc/php/7.2/cli/php.ini.new /etc/php/7.2/cli/php.ini && \
    echo "zend_extension=/ioncube/ioncube_loader_lin_7.2.so" > /etc/php/7.2/apache2/php.ini.new && \
    cat /etc/php/7.2/apache2/php.ini >> /etc/php/7.2/apache2/php.ini.new && \
    mv /etc/php/7.2/apache2/php.ini.new /etc/php/7.2/apache2/php.ini

COPY testrail-*.zip /
RUN cd /var/www/html && unzip -q /testrail-*.zip

COPY config.php /var/www/html/testrail/config.php
COPY testrail.sql /
COPY run.sh /

RUN mkdir /var/www/html/testrail/logs
RUN chown www-data /var/www/html/testrail/logs
RUN echo '* * * * * www-data /usr/bin/php /var/www/html/testrail/task.php' > /etc/cron.d/testrail

COPY initdb.sh /
RUN chmod +x initdb.sh
RUN /initdb.sh

CMD /run.sh
