define simple_namevhost($aliases=[],$admin="wwwadmin@cf.ac.uk") {
  # docroot
  file { "/infotree/$name":
    ensure => directory,
    mode   => 755
  }
  # vhost def
  file { "$vhosting::vhost_include_dir/$name.vhost":
    mode    => 444,
    content => template("httpd/simple_namevhost.erb"),
    notify  => Service['httpd']
  }

}
