vm_name = "gateway"
vm_box = "bento/ubuntu-18.10"

config.vm.define "#{vm_name}" do |config|
    config.vm.box = "#{vm_box}"
    config.vm.hostname = "#{vm_name}"
    config.vm.define "#{vm_name}"
    config.vm.boot_timeout = 1500

    # Network
    config.vm.network "private_network", type: "dhcp",  auto_config: false

    # Provisioners - Shell
    # config.vm.provision "shell", path: "provisioners/init.sh"

    # Provisioners - Ansible
    config.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "/share/playbooks/01_init.yml"      
        ansible.verbose = true
    end

    # Synced folder
    config.vm.synced_folder "data/#{vm_name}", "/share/data",
      mount_options: ["dmode=775,fmode=660"], owner: "vagrant", group: "root"

    config.vm.synced_folder "playbooks", "/share/playbooks",
      mount_options: ["dmode=775,fmode=660"], owner: "vagrant", group: "root"

    config.vm.synced_folder ".", "/vagrant",
      mount_options: ["dmode=775,fmode=660"], owner: "vagrant", group: "root"

      # Virtualbox provider config
    config.vm.provider "virtualbox" do |vb|
        vb.name = "#{vm_name}" # Имя ВМ в VirtualBox
        vb.memory = "2048" # ОЗУ
        vb.customize ["modifyvm", :id, "--vram", "128"] # Видеопамять
        vb.customize ["modifyvm", :id, "--groups", "/#{vm_lab_name}"] # Группировка ВМ
        vb.cpus = 2 # Виртуальные CPU
    end
end