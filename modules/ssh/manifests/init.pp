# take care of SSHing into the box as root
# assume package was installed via kick/jumpstart
class ssh {
  $permitrootlogin = 'without-password'

  file { "/etc/ssh/sshd_config" :
    notify  => Service['sshd'],
    content => template("ssh/sshd_config.erb"),
    mode => 600
  }

  service { "sshd" :
    ensure => running,
    enable => true
  }
  package { "openssh-server" : ensure => present }


  ssh_authorized_key { "rasputnik@hellooperator.net" :
    user => 'root',
    type => 'ssh-dss',
    key => 'AAAAB3NzaC1kc3MAAACBAMi+/n6AHNkdSHNd89QeOBh/RNFxw7lWxowrLu/5yBtaVw6SLSdk7vML3+hds3ITJpXPNTeLoUV1TAGfeWo7gJsgV1LIKDtggsMmGrxkWKYZXKRu2YH24+3sEWRQ5JpXPWgnCGG89BLOozo9W4/QCEYrJ0XGNqD6mLqfzAC0IEjLAAAAFQDNJ+obt7mNBT9rDZGoIpRpaRZ8iwAAAIBDL1QzDe1keDBlhGRkYHPoIw25MTOPYQUM2d98o8OaK+ZdoEr0gIQ17x7PKelfagIpaCIeQfhZFGnsP3TuH9/yxs9LBNmn8FnfCuq/k+9D4JKqnCEs8jbiBeVhdbopDynaxntiAgAL0gexuOa7dB/Wsx8DKQQA2JUDJmStBzBrQwAAAIEAphmOjiL6trt3zwnlBcE80T/4+m6fx67p4lz/DZD5tclrHOStzkqZxPBEaIIPOhtYPLbtXa2ToNWDuZYDY0gpfnApTIasSqG40M9PSatN/2tallhmej8gM3kJ87pRk8u7sPenLY4UH73M0OEIWkoese59b1/QcyVxazYdLvQ1EBk=',
    ensure => present
  }  
}
