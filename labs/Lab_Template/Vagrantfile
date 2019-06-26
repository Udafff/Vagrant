Vagrant.configure("2") do |config|
    # Variables:
    # vm_lab_name - Lab name for grouping VM in the VirtualBox
    # vm_files_dir - dir with VM files configs
    vm_lab_name = "Lab_Template"
    vm_files_dir = "machines"

    # Read only file names from vm_files_dir dir to array (exclude dirs)
    vagrant_files = Dir.foreach(vm_files_dir).select { |x| File.file?("#{vm_files_dir}/#{x}") }    
    # Debug print
    #p "#{vagrant_files[0]} ansible_ssh_host=#{private_subnet}#{ip}"
    #p (vagrant_files.find_index(vagrant_files[0])+1)

    # Network settings
    private_subnet="192.168.1."
    first_ip=10
    first_forward_port = 2200

    # Remove Ansible inventory file to generate new one
    File.delete("playbooks/inventory") if File.exist?("playbooks/inventory")
       
    # For each file name do steps:    
        # - Create VM info variables
        # - Add line Ansible inventory file
        # - Create Data dir for VM in data folder with VM file name
        # - Expand full path to VM file into variable
        # - Read and include config.vm.define files 
    vagrant_files.each do |vm_file|
        # File name as VM hostname
        vm_name = vm_file
        # Network for VM
        ip = "#{private_subnet}#{first_ip + vagrant_files.find_index(vm_name)}"
        forward_port = first_forward_port + vagrant_files.find_index(vm_name)
                
        # Add line to Ansible inventory file
        File.write("playbooks/inventory", "#{vm_name} ansible_ssh_host=#{ip}\n", mode: 'a')

        # Create dir for VM Data
        Dir.mkdir "data/#{vm_file}" unless File.exists?("data/#{vm_file}")
        
        # Get full path name of VM file and load/run it
        vm_file = File.expand_path("#{vm_files_dir}/#{vm_file}")        
        eval File.read(vm_file) if File.exists?(vm_file)
    end
end