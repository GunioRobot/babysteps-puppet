import "os/*"
import "roles"
import "nodes"

# you can syntax check this file with
# 'puppet --parseonly site.pp'
# it won't catch more than the most basic errors,
# but is better than nothing

# global default PATH for all exec resources
Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }
