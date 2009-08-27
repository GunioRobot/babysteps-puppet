class sysstat {

  package { "sysstat" : ensure => present }
  # there is no process/daemon running here;
  # the init script just sets a counter at boot time
  service { 'sysstat' :
    enable  => true,
    require => Package['sysstat']
  }

  $sardays = 28
  file { "/etc/sysconfig/sysstat":
    content => template("sysstat/sysconfig/sysstat.erb"),
    mode    => 444,
    require => Package['sysstat']
  }

  if $architecture == 'x86_64' {
    file { '/usr/lib64/sa/sa1':
      content => template('sysstat/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    } 
  } else {
    file { '/usr/lib/sa/sa1':
      content => template('sysstat/sa1.sh.erb'),
      mode    => '555',
      require => Package['sysstat']
    }
  }
}
