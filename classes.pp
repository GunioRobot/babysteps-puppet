# things that apply to every OS
class baseclass {
  include mailsetup
  include sshsetup
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
# assume package was installed via
# our base Solaris and Linux kick/jumpstart
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

import  'pubkey'
include  'pubkey'
}
