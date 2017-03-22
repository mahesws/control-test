class profile::base (
  Optional[Array] $packages = hiera_array('profile::base::packages', undef)
) {
   if ( $::kernel == 'Windows' ) {
    class { 'profile::base::windows':
      packages => $packages,
    }
  }
  elsif ( $::kernel == 'Linux' ) {
    class { 'profile::base::linux':
      packages => $packages,
    }
  } 
}
