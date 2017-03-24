class profile::base::solaris (
  Optional[Array] $packages = lookup('profile::base::solaris::packages', 'unique', undef)
) {
  include ::ntp
  package { $packages :
    ensure  => present,
  }
}
