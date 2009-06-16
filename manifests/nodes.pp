# centOS 5.3 boxes
# CAVEAT: have done no testing of other OSes yet;
# RHEL 5.x should be trivial. Solaris is a bit patchy
# SLES should be there to some extent too.
node 'node01' {
  include webserver
  realize(Simple_namevhost['www.foo.com'])
}
node 'node02' {
  include webserver
  realize(Simple_namevhost["www.bar.org"])
  realize(Simple_namevhost["www.foo.com"])
}

node 'node03' { include baseclass }
