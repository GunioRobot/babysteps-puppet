# centOS 5.3 boxes
node 'node01' { include baseclass }
node 'node02' { include baseclass }
node 'node03' {
  include baseclass, mysqldb
}
