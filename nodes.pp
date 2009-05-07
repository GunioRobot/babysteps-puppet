# solaris 10 update 7

node 'sunnyboy' {
  include solaris, baseclass
}

# centOS 5.3 boxes
node 'node01' { include baseclass }
node 'node02' { include baseclass }
node 'node03' { include baseclass }

