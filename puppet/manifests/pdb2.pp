#####
# Percona DB2 (Slave) Setup
#####

node default {

  class { 'percona': 
    #root_password => 'dummy1passw0rd123!',
    server_id => 2,
    is_slave => true
  }
}
