# puppet-nginx-rvm-passenger

A Puppet module, installing Nginx, RVM and Passenger on Debian/Ubuntu from the official APT
sources.

## Usage

Get the module:

```bash
git clone git://github.com/blt04/puppet-rvm.git /etc/puppet/modules/rvm
git clone git://github.com/We-Conect/puppet-nginx_passenger /etc/puppet/modules/nginx_passenger
```
... or similar.

Add the following to your node definition or wherever you need it:

```puppet
nginx_passenger { 'some name':
  ruby_version      => 'ruby-2.0.0-p247', # a version specification known to RVM
  passenger_version => '4.0.18',
}
```

## Links

[Phusion Passenger installation documentation](http://www.modrails.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu)
