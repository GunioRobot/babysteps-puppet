# classes included here need to handle
# different OSes
class baseclass {
  include mailsetup
  include sshsetup
  include ntpsetup

  #give fair warning
  file { "/etc/motd": content => 'This box is managed by Puppet.' }
}

# Solaris-specific resources
class solaris {
  include 'baseclass'
  # don't need a GUI
  service { "cde-login": ensure => stopped }
}

# CentOS-specific resources
class centos {
  include 'baseclass'
}

# handles mail forwarding
class mailsetup {
  # uses global $PATH as set in site.pp
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

  # same place on Solaris and CentOS
  file { "/etc/ssh/sshd_config" : notify => Service['ssh'] }

  service { "ssh" :
    name => $operatingsystem? {
      CentOS => 'sshd', 
      default => 'ssh'
    },
    ensure => running,
  }

# this goes into a separate file for safety
import 'pubkey'
include 'pubkey'
}

# enable NTP
class ntpsetup {

    file { "ntp.conf" :
      name => $operatingsystem? {
        CentOS => '/etc/ntp.conf',
        Solaris => '/etc/inet/ntp.conf'
      },
      content => 'server 10.0.0.254',
      notify => Service['ntp']
    }

    service { "ntp" :
      name => $operatingsystem? {
        CentOS => 'ntpd',
        default => 'ntp',
      },
      ensure => running
    }
}
