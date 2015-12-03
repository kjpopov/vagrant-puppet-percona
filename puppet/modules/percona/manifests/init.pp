#
# Copyright 2015 Kjpopov
#

class percona (
  $percona_conf = '/etc/mysql/my.cnf',
  $percona_service = 'mysql',
  $percona_packages = ['percona-server-server-5.6','percona-server-client-5.6'],
  $bind_address_ip = '0.0.0.0',
  $log_bin = 'mysql-bin',
  $root_password = undef,
  $datadir = '/var/lib/mysql',
  $server_id = 1,
  $replica_user = 'repl', 
  $replica_pass = 'dummy1passw0rd123456!',
  $master_ip = '10.0.5.55',
  $slave_ip = '10.0.5.56',
  $is_slave = false )
{

  package { $percona_packages: ensure => 'installed' }
  file { '/root/.my.cnf' : 
    content => template('percona/root.my.cnf.erb'),
    ensure => present,
    owner => root,
    group => root 
  }

  file { '/etc/environment' : content => template('percona/etc.env.erb') }  

  file { $percona_conf:
    content => template('percona/my.cnf.erb'),
    require => Package[$percona_packages],
    notify  => Service[$percona_service]
  }

  file { $datadir:
    ensure => directory,
    owner  => mysql,
    group  => mysql,
    require => Package[$percona_packages],
    notify  => Service[$percona_service]
  }

  service { $percona_service:
    ensure => running,
    enable => true,
    hasrestart => true,
    require => [File[$percona_conf],File[$datadir]],
  }

  if ($root_password) {
      exec {"set-percona-root-password":
          command => "mysqladmin -u root password \"$root_password\"",
          path    => ["/usr/bin"],
          onlyif  => "mysqladmin -u root status 2>&1 > /dev/null",
          require => Service[$percona_service]
      }
  }
  
  if ($is_slave) {
      $mysql_slave_start_file = 'mysql_slave_start.sql'

      file { $mysql_slave_start_file :
        ensure  => present,
        mode    => '0600',
        owner   => 'mysql',
        group   => 'mysql',
        path    => "/root/${mysql_slave_start_file}",
        content => template('percona/sql.start.slave.erb'),
      }

      exec { "start-percona-slave":
          command => "mysql --defaults-file=/root/.my.cnf < /root/${mysql_slave_start_file}",
          path    => ["/usr/bin"],
          require => [ Service[$percona_service], File['/root/.my.cnf'] ],
          subscribe   => File[$mysql_slave_start_file],
          refreshonly => true
      }
    }

  if (!$is_slave) {
      $mysql_grant_replica_file = 'mysql_master_grant_replica.sql'

      file { $mysql_grant_replica_file :
        ensure  => present,
        mode    => '0600',
        owner   => 'mysql',
        group   => 'mysql',
        path    => "/root/${mysql_grant_replica_file}",
        content => template('percona/sql.grant.replica.erb'),
      }

      exec { "grant-replica":
          command => "mysql --defaults-file=/root/.my.cnf < /root/${mysql_grant_replica_file}",
          path    => ["/usr/bin"],
          require => [ Service[$percona_service], File['/root/.my.cnf'] ],
          subscribe   => File[$mysql_grant_replica_file],
          refreshonly => true
      }
    }
  

}
