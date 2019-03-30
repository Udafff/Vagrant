# -*- mode: ruby -*-
# vi: set ft=ruby :

config.vm.define "srv02" do |config|
    #config.vm.box = "debian/jessie64"
    config.vm.box = "ubuntu/bionic64"
    vm_name = "srv02"
    config.vm.hostname = "#{vm_name}"
    config.vm.define "#{vm_name}"
    config.vm.boot_timeout = 1500
    
    
    config.vm.synced_folder "data/#{vm_name}/", "/srv/data",
            owner: "root", group: "root"
    
    config.vm.synced_folder ".", "/vagrant", disabled: true

    config.vm.provider "virtualbox" do |v|
        v.name = "#{vm_name}" # Имя ВМ в VirtualBox
        v.memory = "2048" # ОЗУ
        v.customize ["modifyvm", :id, "--vram", "128"] # Видеопамять
        v.customize ["modifyvm", :id, "--groups", "/#{vm_lab_name}"] # Группировка ВМ
        v.cpus = 2 # Виртуальные CPU
    end
end
