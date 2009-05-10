# classes common to all servers
class baseclass {
  include mailsetup, sshsetup, ntpsetup

  #give fair warning
  file { "/etc/motd": content => "This box is managed by Puppet.\n" }
}

# handles mail forwarding
class mailsetup {
  exec { "newaliases": refreshonly => true }

  mailalias { "rootalias":
    ensure => present,
    recipient => 'rasputnik@hellooperator.net',
    name => 'root',
    notify => Exec['newaliases']
  }
}

# take care of SSHing into the box as root
# assume package was installed via kick/jumpstart
class sshsetup {
  $permitrootlogin = 'without-password'

  file { "/etc/ssh/sshd_config" :
    notify => Service['sshd'],
    content => template("sshd_config.erb"),
  }

  service { "sshd" : ensure => running }
  package { "openssh-server" : ensure => present }

# this goes into a separate file for safety
import 'pubkey'
include 'pubkey'
}

# enable NTP
class ntpsetup {

    $ntpserver = '10.0.0.254'

    file { "ntp.conf" :
      name => '/etc/ntp.conf',
      content => template('ntp.conf.erb'),
      notify => Service['ntpd']
    }

    service { "ntpd" : ensure => running }
    package { "ntp" : ensure => present }
}
