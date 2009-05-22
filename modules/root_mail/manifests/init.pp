# handles mail forwarding
class root_mail {
  exec { "newaliases": refreshonly => true }

  mailalias { "rootalias":
    ensure    => present,
    recipient => 'puppet@shoemaker.pixie',
    name      => 'root',
    notify    => Exec['newaliases']
  }
}
