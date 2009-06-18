# define site specific virtual vhosts. 
# realise them on servers that need them

# they depend on the simple_namevhost definition in modules/httpd
import 'httpd'

@simple_namevhost { "www.foo.com":
  admin => 'fumanchu@doobedoo.net'
}
@simple_namevhost { "www.bar.org":
  aliases => [ 'www.bar.net', 'www.bar.org.uk' ]
}
