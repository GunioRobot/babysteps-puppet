# virtual vhosts - realise them on servers that need them

class vhosts {
  # ok to realise them on multiple nodes
  # (i.e. for load balancing)
  @simple_namevhost { "www.foo.com":
    admin => 'fumanchu@doobedoo.net'
  }
  @simple_namevhost { "www.bar.org":
    aliases => [ 'www.bar.net', 'www.bar.org.uk' ]
  }

}
