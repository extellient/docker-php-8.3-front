FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y wget gnupg2 libzip4 apt-transport-https lsb-release ca-certificates && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt-get update && apt-get install -y php8.3 php8.3-intl php8.3-gd php8.3-soap php8.3-apcu git curl \
    php8.3-cli php8.3-curl php8.3-pgsql php8.3-ldap php8.3-dom \
    php8.3-sqlite php8.3-mysql php8.3-zip php8.3-xml \
    php8.3-mbstring php8.3-dev make libmagickcore-6.q16-2-extra unzip \
    php8.3-redis php8.3-imagick php8.3-dev php-xdebug \
    libsystemd-dev && \
    apt-get autoremove -y && apt-get autoclean && apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
RUN update-alternatives --set php /usr/bin/php8.3
RUN update-alternatives --set phar /usr/bin/phar8.3
RUN update-alternatives --set phar.phar /usr/bin/phar.phar8.3
RUN update-alternatives --set phpize /usr/bin/phpize8.3
RUN update-alternatives --set php-config /usr/bin/php-config8.3
RUN phpenmod xml simplexml mbstring mysql ldap gd dom
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version-2.8.5
# Install node npm
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs
