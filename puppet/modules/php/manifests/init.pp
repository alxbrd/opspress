class php::install {

  package { [
    'php',
    'php-mysql',
    'php-curl',
    'php-gd',
    'php-fpm',
    'php-cli'
    ]:
    ensure => present,
  }

}
