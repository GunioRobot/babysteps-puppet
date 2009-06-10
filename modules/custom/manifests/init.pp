class custom {
  file { "/etc/puppet/puppet.conf":
    mode => 644,
    source => 'puppet:///custom/puppet.conf' 
  }
}
