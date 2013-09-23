class nginx_passenger::install {
  exec { 'import pgp key':
    command => '/usr/bin/gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 && /usr/bin/gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -',
  }

  package { 'apt-transport-https':
    ensure => present,
    require => Exec['apt-get update'],
  }

  file { '/etc/apt/sources.list.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => 0755,
  }

  file { '/etc/apt/sources.list.d/nginx_passenger.list':
    content => "deb https://oss-binaries.phusionpassenger.com/apt/passenger ${::lsbdistcodename} main\n",
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    require => File['/etc/apt/sources.list.d'],
  }

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    require => [
      Exec['import pgp key'],
      File['/etc/apt/sources.list.d/nginx_passenger.list'],
    ],
  }

  package { 'nginx-full':
    ensure  => present,
    require => Exec['apt-get update'],
  }

  package { 'passenger':
    ensure  => present,
    require => Exec['apt-get update'],
  }
}
