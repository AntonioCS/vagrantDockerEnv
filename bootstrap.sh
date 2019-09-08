#!/usr/bin/env bash

# Add repositories + `apt-get update`
add-apt-repository ppa:ondrej/php # PHP
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - # Yarn
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list # Yarn
curl -sL https://deb.nodesource.com/setup_12.x | bash - # Node
apt-get update

# Install Docker Compose
apt-get install -y docker-compose

# Install fish 
apt-get install -y fish
chsh -s /usr/bin/fish vagrant

# Install PHP + extensions
apt-get install -y php7.3
apt-get install -y php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-curl php7.3-dba php7.3-enchant php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-pspell php7.3-readline php7.3-recode php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-xsl php7.3-zip 

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /bin/composer

# Install Node and Yarn
apt-get install -y nodejs
apt-get install -y yarn

# Install misc. packages
apt-get install -y unzip

# https://docs.docker.com/install/linux/linux-postinstall/
# usermod -aG docker veselin
usermod -aG docker vagrant

# Disable the Ubuntu MOTD
touch /home/vagrant/.hushlogin

# Disable the default fish greeting
mkdir -p /home/vagrant/.config/fish/
echo "set fish_greeting" >> /home/vagrant/.config/fish/config.fish
chown -R vagrant:vagrant /home/vagrant/.config/

# .dircolors
cp /dev_config/.dircolors /home/vagrant/.dircolors
echo "eval (dircolors -c ~/.dircolors)" >> /home/vagrant/.config/fish/config.fish