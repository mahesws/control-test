class profile::base::linux (
  Optional[Array] $packages = hiera_array('profile::base::linux::packages', undef)
) {
  
  include ::ntp
  package { $packages :
    ensure  => present,
  }
}
