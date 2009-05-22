# centOS 5.3 boxes
node 'node01' { include webserver }
node 'node02' { include webserver }

node 'node03' { include dbserver }
