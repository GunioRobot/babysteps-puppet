# classes common to all servers
class baseclass {
  # VirtualBox clocks drift so far when laptop sleeps
  # that NTPd can't fix it, so disable in that case
  ## include ntpsetup
  include mailsetup, sshsetup, toolchain

  package { "koan": ensure => installed }

  #give fair warning
  file { "/etc/motd": content => "This box is managed by Puppet.\n" }
}

class webserver { include baseclass, apache }

# handles mail forwarding
class mailsetup {
  exec { "newaliases": refreshonly => true }

  mailalias { "rootalias":
    ensure    => present,
    recipient => 'root@shoemaker.pixie',
    name      => 'root',
    notify    => Exec['newaliases']
  }
}

# take care of SSHing into the box as root
# assume package was installed via kick/jumpstart
class sshsetup {
  $permitrootlogin = 'without-password'

  file { "/etc/ssh/sshd_config" :
    notify  => Service['sshd'],
    content => template("sshd_config.erb"),
  }

  service { "sshd" :
    ensure => running,
    enable => true
  }
  package { "openssh-server" : ensure => present }

# this goes into a separate file for safety
import 'pubkey'
include 'pubkey'
}

# enable NTP
class ntpsetup {

    $ntpserver = '10.0.0.254'

    file { "ntp.conf" :
      name    => '/etc/ntp.conf',
      content => template('ntp.conf.erb'),
      notify  => Service['ntpd']
    }

    package { "ntp" : ensure => present }
    service { "ntpd" :
      ensure => running,
      enable => true
    }
}

# setup mysql-server
class mysqldb {

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

# basic compiler etc. - just enough to build VirtualBox guest additions
class toolchain {
  package { 'gcc' : ensure => present }
  package { 'kernel-devel' : ensure => present }
}

class apache {
  package { ['httpd', 'mod_ssl', 'mod_perl'] :
    ensure => present,
    notify => Service['httpd'] }
  service { "httpd" :
    ensure => running,
    enable => true
  }
  # play nice and provide Includes in the right place

  file { "01general.conf" :
    name => '/etc/httpd/conf.d/01general.conf',
    notify  => Service['httpd'],
    content => template("httpd/01general.erb"),
  }
}
