class httpd {

  $open_firewall = 'on'

  package { 'httpd' :
    ensure => present,
    notify => Service['httpd']
  }
  service { "httpd" :
    ensure => running,
    enable => true
  }

  # play nice and provide Includes in the right place
  file { "01general.conf" :
    name => '/etc/httpd/conf.d/01general.conf',
    notify  => Service['httpd'],
    source => "puppet:///httpd/01general.conf"
  }
}
