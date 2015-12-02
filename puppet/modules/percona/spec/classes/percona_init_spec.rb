require 'spec_helper'

describe 'percona' do

  describe "Debian percona init class" do
    let(:title) { 'percona' }
    let(:node) { 'percona' }
    let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux' } }

    it do 
      should create_class("percona")
      should contain_package('percona-server-server-5.6').with_ensure('installed')
      should contain_package('percona-server-client-5.6').with_ensure('installed')
    end

    it do
      should contain_file('/root/.my.cnf').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        })
    end

    it do
      should contain_file('/var/lib/mysql').with({
        'ensure' => 'directory',
        'owner'  => 'mysql',
        'group'  => 'mysql',
        })
    end

    it { should contain_file('/etc/environment') }

    it { should contain_file('/etc/mysql/my.cnf') }

    it do
      should contain_service('mysql').with({
        'ensure' => 'running',
        'enable'  => 'true',
        'hasrestart'  => 'true',
        'require' => "[File[/etc/mysql/my.cnf]{:path=>\"/etc/mysql/my.cnf\"}, File[/var/lib/mysql]{:path=>\"/var/lib/mysql\"}]",
        })
    end

  end

  describe "Debian percona server is slave init class" do
    let(:title) { 'percona' }
    let(:node) { 'percona' }
    let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux' } }
    let(:params) { {:is_slave => true, :server_id => 2 } }

    it do
      should create_class("percona")
      should contain_package('percona-server-server-5.6').with_ensure('installed')
      should contain_package('percona-server-client-5.6').with_ensure('installed')
    end

    it do
      should contain_file('mysql_slave_start.sql').with({
        'ensure' => 'present',
        'mode'   => '0600',
        'owner'  => 'mysql',
        'group'  => 'mysql',
        'path'   => '/root/mysql_slave_start.sql',
        })
    end
  end

  describe "Debian percona server is master init class" do
    let(:title) { 'percona' }
    let(:node) { 'percona' }
    let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux' } }
    let(:params) { {:is_slave => false, :server_id => 1 } }

    it do
      should create_class("percona")
      should contain_package('percona-server-server-5.6').with_ensure('installed')
      should contain_package('percona-server-client-5.6').with_ensure('installed')
    end

    it do
      should contain_file('mysql_master_grant_replica.sql').with({
        'ensure' => 'present',
        'mode'   => '0600',
        'owner'  => 'mysql',
        'group'  => 'mysql',
        'path'   => '/root/mysql_master_grant_replica.sql',
        })
    end
  end

end

