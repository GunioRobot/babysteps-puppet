import 'definitions.pp'

class sshusers {

  group { "sysadmins": gid => 5000 }
  @ssh_user { "stinky":
    comment => "Stinky McGinty",
    uid     => 5001,
    group   => 'sysadmins',
    mail    => 'stinky@gmail.com'
  }
  @ssh_user { "kinky":
    comment => "Kinky Afro",
    uid     => 5002,
    group   => 'sysadmins',
    mail    => 'kinky@gmail.com'
  }
  @ssh_user { "pinky":
    comment => "Mr. Pink",
    uid     => 5003,
    group   => 'sysadmins',
    mail    => 'pinky@gmail.com'
  }

}
