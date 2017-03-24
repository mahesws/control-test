class profile::puppetmaster::install (
  String $keypath,
  String $gemprovider,
  Array $packages,
  String $owner,
  String $group,
  Array $cmdpath,
) {
  # Default Packages
  package { $packages:
    ensure   => present,
    provider => $gemprovider,
    notify   => Service['pe-puppetserver'],
  }

  File {
    owner => $owner,
    group => $group,
  }

  file {$keypath:
    ensure => directory,
  }

  exec { 'createkeys':
    user    => $owner,
    cwd     => $keypath,
    command => 'eyaml createkeys',
    path    => $cmdpath,
    creates => "${keypath}/keys/private_key.pkcs7.pem",
    require => File[$keypath],
  }

  file { ["${keypath}/keys/private_key.pkcs7.pem", "${keypath}/keys/public_key.pkcs7.pem"]:
    ensure  => file,
    mode    => '0600',
    require => Exec['createkeys'],
  }

}
