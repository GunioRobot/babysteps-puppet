# take care of SSHing into the box as root
class ldap_client {
  $permitrootlogin = 'without-password'

  file { "/etc/customca.crt" :
    source => "puppet:///ldap_client/customca.crt",
    mode   => 444
  }

  package { "openldap-clients" : ensure => present }

  file { "/etc/openldap/ldap.conf":
    source  => "puppet:///ldap_client/ldap.conf",
    mode    => 444,
    require => Package['openldap-clients']
  }
}
