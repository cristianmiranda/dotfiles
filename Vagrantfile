Vagrant.configure("2") do |config|
    #config.vm.box = "ubuntu/bionic64"
    config.vm.box = "cmiranda/linux-mint-19.3"

    # SSH credentials
    config.ssh.username = "cmiranda"
    config.ssh.password = "cmiranda"

    # Optional - enlarge disk (will also convert the format from VMDK to VDI):
    config.disksize.size = "50GB"
  
    config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    end
  
    #config.vm.provision "shell", inline: <<-SHELL
    #  echo "dotfiles"
    #SHELL

    # Not used because we use a fully functional VM image 
    #config.vm.provision "shell", path: "scripts/vagrant/install-desktop.sh"
    
    # Not used because we clone the entire repo
    # config.vm.synced_folder "~/dotfiles", "/home/cmiranda/Documents/Work/Workspace/dotfiles", type: "rsync", rsync__auto: true, rsync__exclude: ['tests']
end
