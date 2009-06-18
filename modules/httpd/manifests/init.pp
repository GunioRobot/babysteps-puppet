import 'definitions.pp'
import 'vhosts.pp'

class httpd {
  include baseserver
  ipt_fragment { "filter-http": ensure => present }
  include vhosting
  include vhosts
}

class vhosting {

  # vhost docroots live under this
  file { "/infotree":
    ensure => directory,
    mode   => 755
  }
  
  # Include any file name *.vhost from here
  $vhost_include_dir = '/etc/httpd/conf/vhosts'
  # make somewhere to put vhost definitions
  file { $vhost_include_dir:
    ensure => directory,
    mode   => 755,
    owner  => root,
    require => Package['httpd']
  }
  # snippet to pull in any vhosts in that directory
  # (stupid name so it loads last)
  file { "/etc/httpd/conf.d/ZZvhosts.conf":
    notify => Service['httpd'],
    mode   => 444,
    content => "NameVirtualHost *:80\nInclude $vhost_include_dir/*.vhost\n"
  }

}

# basic packages, add-on modules and their boilerplate
# and log rotation
class baseserver {

  package { 'httpd' :
    ensure => present,
    notify => Service['httpd']
  }
  file { "/etc/httpd/conf.d/01general.conf" :
    notify => Service['httpd'],
    mode   => 444,
    content => template('httpd/01general.conf.erb')
  }
  # lose the default welcome page thing.
  file { "/etc/httpd/conf.d/welcome.conf" :
    notify => Service['httpd'],
    ensure => absent
  }

  package { ['mod_ssl','mod_dav_svn'] :
    ensure  => present,
    notify  => Service['httpd']
  }
  package { 'mod_authz_ldap' :
    ensure  => present,
    require => Class['ldap_client'],
    notify  => Service['httpd']
  }

  service { "httpd" :
    ensure => running,
    enable => true
  }

  # tweaked logrotate to manage /var/log/httpd/*.log
  file { "logrotate.httpd" :
    name    => '/etc/logrotate.d/httpd',
    require => Package['httpd'],
    source  => "puppet:///httpd/logrotate.httpd"
  }
}
