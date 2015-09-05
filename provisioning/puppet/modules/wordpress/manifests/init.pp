# Install latest Wordpress

class wordpress::install {

  $wordpress_install_directory = '/var/app/current'

  # MySQL
  exec {
    'create-database':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute=\'create database wordpress\'',
  }

  exec {
    'create-user':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress.* TO \'wordpress\'@\'localhost\' IDENTIFIED BY \'wordpress\'"',
  }

  # Wordpress CLI
  exec {
    'download-wordpress-cli':
    command => 'wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp',
    creates => '/usr/local/bin/wp',
    notify => File['/usr/local/bin/wp'],
  }

  file {
    '/usr/local/bin/wp':
    owner => "root",
    group => "root",
    mode => "755",
    ensure => "present",
    require => Exec['download-wordpress-cli'],
  }

  exec {
    'wordpress-installation-path':
    command => "mkdir -p $wordpress_install_directory",
    creates => '/var/app/current',
    notify => Exec['download-wordpress-core'],
  }

  file {
    $wordpress_install_directory:
    ensure => 'directory',
    owner => 'vagrant',
    group => 'vagrant',
    mode  => '755',
    notify => Exec['download-wordpress-core'],
  }

  file {
    '/var/www/sites/wordpress':
    ensure => 'link',
    target => $wordpress_install_directory,
    require => File[$wordpress_install_directory],
    notify => Service['httpd']
  }

  exec {
    'download-wordpress-core':
    command => "/usr/local/bin/wp core download --locale=en_GB --path=$wordpress_install_directory --force",
    require => File['/usr/local/bin/wp', $wordpress_install_directory],
    notify => Exec['set-up-wordpress-config']
  }

  exec {
    'set-up-wordpress-config':
    command => '/usr/local/bin/wp core config --dbname=wordpress --dbuser=root --dbpass=vagrant --locale=en_GB  --path=/var/www/sites/wordpress',
    unless  => "test -f $wordpress_install_directory/wp-config.php",
    require => Exec['download-wordpress-core']
  }
}
