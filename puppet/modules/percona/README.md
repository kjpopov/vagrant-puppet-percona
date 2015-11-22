puppet-percona
======

Puppet module for configuring Percona 1master + 1slave instace.


Usage
-----

### Example

This is a simple example to configure a percona server.

**Using the percona module**

```percona
class { 'percona':
    root_password => 'dummy_password',
    bind_address_ip = '0.0.0.0',
    $server_id = 1,
    . . . . . . . .
    . . . . . . . .
}
```

Please note that in case you already have other DB machines in the cluster you will need to use the same value of innodb_log_file_size for all the components of the cluster.

Contributors
------------

* https://github.com/kjpopov

Release Notes
-------------

