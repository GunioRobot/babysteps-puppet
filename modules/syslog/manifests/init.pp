class syslog {

  package { "sysklogd": ensure => present }
  service { "syslog":
    ensure => running,
    enable => true
  }

  # find out if you're the sink or a source
  case $fqdn {
    $syslogsink: { include syslogsink }
    default: { include syslogsource }
  }

}

class syslogsink {
  file { "/etc/syslog.conf":
    mode   => 444,
    source => "puppet:///syslog/syslog.conf.sink",
    notify => Service['syslog']
  }
  file { "/etc/sysconfig/syslog":
    mode   => 444,
    source => 'puppet:///syslog/sysconfig.syslog.sink',
    notify => Service['syslog']
  }
  ipt_fragment{'filter-syslog': ensure => present}
}

class syslogsource {
  file { "/etc/syslog.conf":
    mode    => 444,
    content => template("syslog/syslog.conf.source.erb"),
    notify  => Service['syslog']
  }
  file { "/etc/sysconfig/syslog":
    ensure => absent,
    notify => Service['syslog']
  }
  ipt_fragment{'filter-syslog': ensure => absent}
}
