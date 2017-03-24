class profile::puppetmaster (
  String $hiera_yaml = "${::settings::confdir}/hiera.yaml",
  Boolean $install_eyaml = false,
){

  # Metric Collection
  include pe_metric_curl_cron_jobs

  if $::puppetversion and versioncmp($::puppetversion, '4.9.0') >= 0 {
  # Hiera 5
    if $install_eyaml {
      include profile::puppetmaster::install
    }
  } else {
  # Default Packages
  package { ['hiera-eyaml', 'deep_merge']:
    ensure   => present,
    provider => puppetserver_gem,
    notify   => Service['pe-puppetserver'],
  }
  # Hiera 3
    class { 'hiera':
      hierarchy  => [
        'nodes/%{::trusted.certname}',
        'virtual/%{::virtual}',
        'osfamily/%{::osfamily}',
        'common',
      ],
      #eyaml      => true,
      hiera_yaml => $hiera_yaml,
      datadir    => '/etc/puppetlabs/code/environments/%{environment}/hieradata',
      owner      => 'pe-puppet',
      group      => 'pe-puppet',
      notify     => Service['pe-puppetserver'],
    }
  }
}
