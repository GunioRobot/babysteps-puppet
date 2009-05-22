class centos {

  $disabled_services = ['cups', 'bluetooth', 'avahi-daemon', 'madeup']

  service { $disabled_services:
    enable => false,
    ensure => stopped
  }

}
