#exec { 'yum_update':
#  command => 'yum update -y',
#  path    => '/usr/bin'
#}

# set global path variable for project
# http://www.puppetcookbook.com/posts/set-global-exec-path.html
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin", "/usr/local/sbin" ] }

class { 'epel::install': }
class { 'git::install': }
class { 'mysql::install': }
class { 'apache::install': }
class { 'firewall::install': }
class { 'php::install': }
class { 'wordpress::install': }
