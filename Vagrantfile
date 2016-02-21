VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box     = "wily"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/wily/current/wily-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
  end

  config.vm.network :private_network, ip: "33.33.33.99"
  # config.vm.network "forwarded_port", guest: 80, host: 80

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/code/searchapp", type: 'nfs'

  config.vm.provision :shell, :inline => 'apt-get update'
  config.vm.provision :shell, :inline => 'apt-get install -y apt-transport-https ca-certificates'
  config.vm.provision :shell, :inline => 'apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D'
  config.vm.provision :shell, :inline => 'apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D'
  config.vm.provision :shell, :inline => 'rm -f /etc/apt/sources.list.d/docker.list'
  config.vm.provision :shell, :inline => 'touch /etc/apt/sources.list.d/docker.list'
  config.vm.provision :shell, :inline => 'echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" >> /etc/apt/sources.list.d/docker.list'
  config.vm.provision :shell, :inline => 'apt-get update'
  config.vm.provision :shell, :inline => 'apt-get purge lxc-docker'
  config.vm.provision :shell, :inline => 'apt-cache policy docker-engine'
  config.vm.provision :shell, :inline => 'apt-get install -y docker-engine'
  config.vm.provision :shell, :inline => 'service docker start'
  config.vm.provision :shell, :inline => 'usermod -aG docker vagrant'

  config.vm.provision :shell, :inline => 'curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
  config.vm.provision :shell, :inline => 'chmod +x /usr/local/bin/docker-compose'

end
