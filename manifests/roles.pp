# define the inheritance heirarchy for different
# roles

# classes common to all servers
class baseclass {

  case $operatingsystem {
      centos: { include centos }
      rhel: { include rhel }
      default: {include rhel}
  }

  include root_mail, ssh

  #give fair warning
  file { "/etc/motd": content => "This box is managed by Puppet.\n" }
}

class webserver { include baseclass, apache }
class dbserver { include baseclass, mysql }
