#####
# Percona DB1 (Master) Setup
#####

node default {

  class { 'percona': 
    #root_password => 'dummy1passw0rd123!',
    server_id => 1,
    is_slave => false
  }
}
