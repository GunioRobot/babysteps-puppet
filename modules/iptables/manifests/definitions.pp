# Handles iptables concerns.  See also ipt_fragment definition
define ipt_fragment($ensure) {
  case $ensure {
    absent: {
      file { "/etc/iptables.d/$name":
        ensure => absent,
      }
    }
    present: {
      file {
         "/etc/iptables.d/$name":
          source => "puppet:///iptables/fragments/$name",
          notify => Exec[rebuild_iptables],
      }
    }
  }
}
