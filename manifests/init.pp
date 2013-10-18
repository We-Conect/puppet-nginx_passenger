define nginx_passenger ($ruby_version, $passenger_version) {
  include rvm
  include nginx_passenger::install

  rvm_system_ruby { $ruby_version:
    ensure      => 'present',
    default_use => true;
  }

  rvm_gem { "${ruby_version}/passenger":
    ensure  => $passenger_version,
    require => Rvm_system_ruby[$ruby_version],
  }

  service { 'nginx':
    ensure => running,
    hasstatus => true,
    require => [
      Package['nginx-full'],
      Package['passenger'],
      File['/etc/nginx/nginx.conf'],
    ],
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    content => template('nginx_passenger/nginx.conf.erb'),
    require => File['/etc/nginx'],
  }

  file { '/etc/nginx':
    ensure => directory,
  }
}
