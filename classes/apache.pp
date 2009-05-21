class apache {
  package { ['httpd', 'mod_ssl', 'mod_perl'] :
    ensure => present,
    notify => Service['httpd'] }
  service { "httpd" :
    ensure => running,
    enable => true
  }
  # play nice and provide Includes in the right place

  file { "01general.conf" :
    name => '/etc/httpd/conf.d/01general.conf',
    notify  => Service['httpd'],
    content => template("httpd/01general.erb"),
  }
}
