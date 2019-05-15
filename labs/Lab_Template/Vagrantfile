Vagrant.configure("2") do |config|
    # Variables:
    # vm_lab_name - Lab name for grouping VM in the VirtualBox
    # vm_files_dir - dir with VM files configs
    vm_lab_name = "Lab_Template"
    vm_files_dir = "machines"

    # Read only file names from vm_files_dir dir to array (exclude dirs)
    vagrant_files = Dir.foreach(vm_files_dir).select { |x| File.file?("#{vm_files_dir}/#{x}") }
    # Debug: print array
    #p vagrant_files
    
    # For each file name do steps:
    # - Create Data dir for VM in data folder with VM file name
    # - Expand full path to VM file into variable
    # - Read and include config.vm.define files 
    vagrant_files.each do |vm_file|
        Dir.mkdir "data/#{vm_file}" unless File.exists?("data/#{vm_file}")
        
        vm_file = File.expand_path("#{vm_files_dir}/#{vm_file}")        
        eval File.read(vm_file) if File.exists?(vm_file)
    end
end