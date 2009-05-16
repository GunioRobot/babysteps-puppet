# centOS 5.3 boxes
node 'node01' { include baseclass }
node 'node02' { include baseclass }
node 'node03' {
  include baseclass, mysqldb
}
# SLES11 box
# (haven't made the other things in baseclass
# portable yet
node 'iggy' { include mailsetup }
