class iptables {

  service { "iptables":
    ensure => running,
    enable => true,
    hasstatus => true
  }

  file { "/etc/sysconfig/iptables":
    mode => 400,
    content => template("iptables/iptables.erb"),
    notify => Service['iptables']
  }
}
