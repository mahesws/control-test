class profile::base (
 $packages
) {

  include ::ntp
  package { $packages :
    ensure  => present,
  }
}
