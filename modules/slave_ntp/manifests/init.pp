# NB: don't run this on VMs
# 'slave' NTPD; keeps up with master server(s)
#
class slave_ntp {

  file { "ntp.conf" :
    name    => '/etc/ntp.conf',
    content => template('slave_ntp/ntp.conf.erb'),
    notify  => Service['ntpd'],
    mode    => 444
  }

  package { "ntp" : ensure => present }
  service { "ntpd" :
    ensure => running,
    enable => true
  }
}
