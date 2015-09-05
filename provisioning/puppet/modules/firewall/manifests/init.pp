class firewall::install {

    $http_port = '80'
    $mysql_port = '3306'

  # Open ports
  exec {
    'firewall-open-ports':
    command     => "firewall-cmd --permanent --zone=public --add-port=$http_port/tcp --add-port=$mysql_port/tcp",
    require => Service['httpd', 'mysqld'],
  }

  exec {
    'firewall-reload':
    refreshonly => true,
    command     => "firewall-cmd --reload",
    require     => Exec['firewall-open-ports'],
    subscribe   => Exec['firewall-open-ports'],
  }
}
