import 'definitions.pp'

class iptables {
  package { "iptables":
    ensure => present
  }
  service { "iptables":
    ensure    => running,
    enable    => true,
    hasstatus => true
  }

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
}
