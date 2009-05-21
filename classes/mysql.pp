# setup mysql-server
class mysql {

  package { 'mysql-server' : ensure => present }
  service { "mysqld" :
    ensure => running,
    enable => true
  }
 
  # changing this here will *not* magically change it on the server 
  $mysqlrootpass = 'sekrti'
  # designed to only run when the package is installed
  exec { 'Set mysql root password' :
    command     => "mysqladmin -uroot password $mysqlrootpass",
    unless      => "mysqladmin -uroot -p$mysqlrootpass status",
    subscribe   => Package['mysql-server'],
    refreshonly => true
  }
}
