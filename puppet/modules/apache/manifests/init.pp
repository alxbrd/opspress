class apache::install {

  File {
    ensure => file,
    owner => 'root',
    group => "root",
    mode  => '0644',
    require => Package['httpd'],
    notify  => Service['httpd'],
  }

  package { 'httpd':
    ensure => present,
  }

  service { 'httpd':
    require => Package['httpd'],
    enable => true,
    ensure => running,
  }

  file {
    '/var/www/sites':
    ensure => 'directory',
    owner => 'vagrant',
    group => 'vagrant',
    mode  => '755'
  }

  file {
    '/etc/httpd/conf.d/httpd.conf':
    source => '/vagrant/files/development/apache/conf.d/httpd.conf',
  }

  file {
    '/etc/httpd/conf.d/1-www.opspress.dev.conf':
    source => '/vagrant/files/development/apache/conf.d/1-www.opspress.dev.conf',
  }
}
