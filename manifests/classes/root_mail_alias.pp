# handles mail forwarding
class root_mail_alias {
  exec { "newaliases": refreshonly => true }

  mailalias { "rootalias":
    ensure    => present,
    recipient => 'root@shoemaker.pixie',
    name      => 'root',
    notify    => Exec['newaliases']
  }
}
