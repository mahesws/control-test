class profile::puppetmaster (
  $hiera_yaml = "${::settings::confdir}/hiera.yaml"
){
  package { 'hiera-eyaml':
    ensure   => present,
    provider => puppet_gem,
  }
  class { 'hiera':
    hierarchy  => [
      'nodes/%{::trusted.certname}',
      'virtual/%{::virtual}',
      'osfamily/%{::osfamily}',
      'common',
    ],
    eyaml      => true,
    hiera_yaml => $hiera_yaml,
    datadir    => '/etc/puppetlabs/code/environments/%{environment}/hieradata',
    owner      => 'pe-puppet',
    group      => 'pe-puppet',
    notify     => Service['pe-puppetserver'],
    require    => Package['hiera-eyaml'],
  }
}
