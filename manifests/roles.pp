# define the inheritance heirarchy for different
# roles

# classes common to all servers
class baseclass {

  case $operatingsystem {
      centos: { include centos }
      rhel: { include rhel }
      default: {include rhel}
  }

  include root_mail
  include ssh
  include custom

  #give fair warning
  file { "/etc/motd": content => "This box is managed by Puppet.\n" }

  # Argh. this isn't seeing root_mail/ssh tags etc. defined
  include tagtest
}

class webserver {
  # include these in the wrong order and you get an error - why?
  include apache
  include baseclass
}
