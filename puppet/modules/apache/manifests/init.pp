   class apache {
     # 1. Установка пакета
     package { 'apache2':
       ensure => installed,
     }
     
     # 2. Запуск службы
     service { 'apache2':
       ensure  => running,
       enable  => true,
       require => Package['apache2'],
     }
     
     # 3. Развертывание основного index.html
     file { '/var/www/html/index.html':
       ensure  => file,
       source  => 'puppet:///modules/apache/index.html',
       owner   => 'www-data',
       group   => 'www-data',
       mode    => '0644',
       require => Package['apache2'],
       notify  => Service['apache2'],
     }

     # 4. Создание директории для кастомного VirtualHost
     file { '/var/www/custom_html':
       ensure => directory,
       owner  => 'www-data',
       group  => 'www-data',
     }

     # 5. Генерация конфига VirtualHost из ERB-шаблона
     file { '/etc/apache2/sites-available/custom.conf':
       ensure  => file,
       content => template('apache/custom_vhost.erb'),
       owner   => 'root',
       group   => 'root',
       mode    => '0644',
       notify  => Service['apache2'],
     }

     # 6. Включение сайта (a2ensite)
     exec { 'enable_custom_site':
       command => '/usr/sbin/a2ensite custom.conf',
       notify  => Service['apache2'],
       unless  => '/usr/bin/test -L /etc/apache2/sites-enabled/custom.conf',
     }
     }
