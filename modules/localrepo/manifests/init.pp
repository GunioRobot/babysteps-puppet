class localrepo {

  $repobox = 'shoemaker.pixie'

  yumrepo { "localbits":
    baseurl  => "http://$repobox/localbits",
    descr    => "$name repository on $repobox",
    enabled  => 1,
    gpgcheck => 0
  }
}
