# simplify creating a local account
# with no password, but an RSA/DSA key
#
# (see bottom of this file for some examples)

define ssh_user($comment,$uid,$group) {

  # create the user
  user { "$name":
    home       => "/home/$name",
    managehome => true,
    comment    => $comment,
    gid        => $group,
    require    => Group[$group],
    ensure     => present,
    password   => 'NP',
    uid        => $uid,
    shell      => '/bin/bash'
  }

  # create ~/.ssh (~/ is created by User[$name])
  file { "/home/$name/.ssh":
    ensure  => directory,
    mode    => 700,
    owner   => $name,
    group   => $group,
    require => User[$name]
  }
  file { "/home/$name/.ssh/authorized_keys":
    source  => "puppet:///sshusers/public_keys/$name",
    mode    => 400,
    owner   => $name,
    group   => $group,
    require => File["/home/$name/.ssh"]
  }
}

class sshusers {

  group { "sysadmins": gid => 5000 }
  ssh_user { "stinky":
    comment => "Stinky McGinty",
    uid     => 5001,
    group   => 'sysadmins'
  }
  ssh_user { "kinky":
    comment => "Kinky Afro",
    uid     => 5002,
    group   => 'sysadmins'
  }

}
