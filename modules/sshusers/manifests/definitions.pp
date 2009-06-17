# simplify creating a local account
# with no password, but an RSA/DSA key
#
# (see bottom of file for how this definition is used)

define ssh_user($comment,$uid,$group,$mail,$shell="/bin/bash") {

  # create the user
  user { "$name":
    home       => "/home/$name",
    managehome => true,
    comment    => $comment,
    gid        => $group,
    require    => Group[$group],
    ensure     => present,
    password   => '!',
    uid        => $uid,
    shell      => $shell
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
    source  => "puppet:///sshusers/authorized_keys/$name",
    mode    => 400,
    owner   => $name,
    group   => $group,
    require => File["/home/$name/.ssh"]
  }

  mailalias { "$name":
    ensure    => present,
    recipient => $mail,
    notify    => Exec['newaliases']
  }

}
