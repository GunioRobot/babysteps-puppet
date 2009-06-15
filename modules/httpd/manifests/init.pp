class httpd {

  package { 'httpd' :
    ensure => present,
    notify => Service['httpd']
  }
  package { ['mod_ssl','mod_dav_svn'] :
    ensure  => present,
    require => Package['httpd'],
    notify  => Service['httpd']
  }
  package { 'mod_authz_ldap' :
    ensure  => present,
    require => Class['ldap_client'],
    require => Package['httpd'],
    notify  => Service['httpd']
  }

  service { "httpd" :
    ensure => running,
    enable => true
  }

  # play nice and provide Includes in the right place
  file { "01general.conf" :
    name   => '/etc/httpd/conf.d/01general.conf',
    notify => Service['httpd'],
    mode   => 444,
    source => "puppet:///httpd/01general.conf"
  }
}
