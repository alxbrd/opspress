# Install MySQL

class mysql::install {
  $password = 'vagrant'

  package {
    'mysql-community-release-el7-5':
    ensure => 'installed',
    source => 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm',
    provider => 'rpm'
  }

  package {
    'mysql-server':
    ensure => installed,
    require => Package['mysql-community-release-el7-5'],
  }

  service {
    'mysqld':
    ensure  => running,
    require => Package['mysql-server'],
  }

  exec {
    'Set MySQL server\'s root password':
    subscribe => [
      Package['mysql-server']
    ],
    refreshonly => true,
    unless      => "mysqladmin -u root -p${password} status",
    command     => "mysqladmin -u root password ${password}",
    require => Service['mysqld'],
  }
}
