# NB: don't run this on VMs
# 'slave NTPd'; keeps up with master server
#
class slave_ntpd {

    $ntpmasters = ['10.0.0.254']

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
