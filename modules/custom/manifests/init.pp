class custom {
  file { "/etc/puppet/puppet.conf":
    mode   => 444,
    source => 'puppet:///custom/puppet.conf'
  }
}
