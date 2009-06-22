# define the inheritance heirarchy for different
# roles

# classes common to all servers
class baseclass {

  case $operatingsystem {
    centos: { include centos }
    rhel: { include rhel }
    default: {include rhel}
  }

  include iptables
  include motd
  $syslogsink = 'node01.pixie'
  include syslog
  include root_mail
  include ssh
  include custom
  include ldap_client
}

class webserver {
  include baseclass
  include httpd
  realize( Group["sysadmins"])
  realize( Ssh_user["stinky"], Ssh_user["kinky"] )
}
