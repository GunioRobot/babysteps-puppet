# define the inheritance heirarchy for different
# roles

# classes common to all servers
class standardbuild {
  case $operatingsystem {
    centos: { include centos }
    rhel: { include rhel }
    default: {include rhel}
  }
  include localrepo
  include iptables
  include motd
  $syslogsink = 'node01.pixie'
  include syslog
  include root_mail
  include ssh
  include custom
  include ldap_client
}
class nofirewallbuild inherits standardbuild {
  include iptables::disabled
}
