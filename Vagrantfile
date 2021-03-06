# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

host_project_path = File.expand_path("..", __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
project_name = "nginx1.4"

Vagrant.configure("2") do |config|

  config.vm.hostname = "#{project_name}-omnibus-build-lab"

  config.vm.define 'ubuntu-12.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
      c.vm.box = "precise64"
    config.vm.provider :vmware_fusion do |vmware, override|
      override.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
    end
    config.vm.provider :virtualbox do |virtualbox, override|
      override.vm.box_url = "http://files.vagrantup.com/precise64.box"
    end
  end

  config.vm.define 'centos-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
      c.vm.box = "centos-6.4"
    config.vm.provider :vmware_fusion do |vmware, override|
      override.vm.box_url = "https://dl.dropbox.com/u/5721940/vagrant-boxes/vagrant-centos-6.4-x86_64-vmware_fusion.box"
    end
    config.vm.provider :virtualbox do |virtualbox, override|
      override.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"
    end
  end

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "1536",
      "--cpus", "2"
    ]
  end

  # Ensure a recent version of the Chef Omnibus packages are installed
  config.omnibus.chef_version = :latest

  # Enable the berkshelf-vagrant plugin
  config.berkshelf.enabled = true
  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.berksfile_path = "./Berksfile"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  config.ssh.forward_agent = true

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  # prepare VM to be an Omnibus builder
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "omnibus" => {
        "build_user" => "vagrant",
        "build_dir" => guest_project_path,
        "install_dir" => "/opt/#{project_name}"
      }
    }

    chef.run_list = [
      "recipe[omnibus::default]"
    ]
  end

  config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
    export PATH=/usr/local/bin:$PATH
    cd #{guest_project_path}
    su vagrant -c "bundle install --binstubs"
    su vagrant -c "bin/omnibus build project #{project_name}"
  OMNIBUS_BUILD
end
