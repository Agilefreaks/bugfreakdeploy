# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'ubuntu/trusty64'
  config.ssh.forward_agent = true

  config.vm.provider :digital_ocean do |digital, override|
    override.vm.box = 'digital_ocean'
    override.ssh.private_key_path = "~/.ssh/id_rsa"

    digital.token                = ENV['BUGFREAK_DIGITAL_OCEAN_TOKEN']
    digital.ssh_key_name         = ENV['BUGFREAK_DIGITAL_SSH_KEY_NAME']
    digital.image                = "Ubuntu 14.04 x64"
    digital.region               = "ams3"
    digital.size                 = "512MB"
    digital.private_networking   = "true"
    digital.domain               = 'bugfreak.co'
  end

  define_machine = ->(name) { config.vm.define(name) { |machine| machine.vm.hostname = name } }

  1.times { |i| define_machine.call("staging0#{i + 1}") }

  1.times { |i| define_machine.call("production0#{i + 1}") }

  1.times { |i| define_machine.call("mongo0#{i + 1}") }
  
  config.vm.provision :shell, path: "scripts/puppet.sh" 

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file  = 'site.pp'
    puppet.options = '--verbose'
    puppet.facter = { newrelic_license_key: ENV['BUGFREAK_NEWRELIC_LICENSE_KEY'], rvm_version: '1.25.31', ruby_version: '2.1.3', authorized_keys: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFil+rudpl92tedkYrDrJuwDjDySkgPsbEy1dGk300H4u+7/0tjTr/f6iOuMKsJOLzS/zyVSIsyOAB2E99b8oe4D0oqAdBASmW6LOOYVvgEcsE5YEfiexgfYnwxnt39OYkEeD9V+t5EiVqyRgWrppzfqDQZo0c+ps9nEDJ1EV5dIczH4L4emlXabhxrMLboTLRHR7Qj1R78TPculiif7QD7gqhsGxeNhcNIMdIC3V3flkp2aB4Lfuns5Y50JIracQqHeo3rYtyWxvc7CPI1DEfpDdfYnbUA5bVVPWexZlr2DAgmZbc4w1h7wsD6YY2edvyrn9bI20/Ynj7fpeoE+F/ calinoiu.alexandru@agilefreaks.com' }
  end
end
