class sshusers {

  user { "stinky":
    home       => '/home/stinky',
    managehome => true,
    comment    => "Stinky McGinty",
    gid        => 'sysadmins',
    require    => Group['sysadmins'],
    ensure     => present,
    password   => 'NP',
    uid        => 5001,
    shell      => '/bin/bash'
  }

  group { "sysadmins" :
    gid => 5000
  }

  file { "/home/stinky/.ssh":
    ensure  => directory,
    mode    => 700,
    owner   => stinky,
    group   => sysadmins,
    require => User['stinky']
  }

  file { "/home/stinky/.ssh/authorized_keys":
    source  => "puppet:///sshusers/stinky.pubkey",
    mode    => 400,
    owner   => stinky,
    group   => sysadmins,
    require => File['/home/stinky/.ssh']
  }
}
