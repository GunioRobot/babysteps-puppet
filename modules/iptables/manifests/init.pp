import 'definitions.pp'

class iptables {
  exec { "rebuild_iptables":
    command     => "/usr/sbin/rebuild-iptables",
    refreshonly => true,
    require     => File["/usr/sbin/rebuild-iptables"],
  }
  file { "/etc/iptables.d":
    ensure => directory,
    purge  => true,
    mode   => 755,
    notify => Exec["rebuild_iptables"]
  }
  file {  "/usr/sbin/rebuild-iptables":
    source => "puppet:///iptables/rebuild-iptables",
    mode   => 555,
    notify => Exec["rebuild_iptables"]
  }
  service { "iptables":
    ensure    => running,
    enable    => true,
    hasstatus => true
  }
  package { "iptables": ensure => present }
}

class iptables::disabled inherits iptables {
  Service['iptables'] {
    ensure => stopped,
    enable => false
  }
}
