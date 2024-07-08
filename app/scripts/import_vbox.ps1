##########################  Importing VirtualBox - working ###########################
$ovaPath = "$SCRIPT_DIR\ubuntu_server.ova"
# Define paths and variables
$ovaFilePath = $ovaPath
$vmMemory = 4096  # Memory size in MB
$vmCPUs = 4       # Number of CPU cores

# Import the virtual machine from the OVA file
Write-Output "Importing VM, it may take time..."
& VBoxManage import $ovaFilePath --vsys 0 --vmname $vmName > $null 2> ".\error.log"

# Modify VM settings (memory, CPUs and port forwarding)
# & VBoxManage modifyvm $vmName --memory $vmMemory
# & VBoxManage modifyvm $vmName --cpus $vmCPUs
# & VBoxManage modifyvm $vmName --natpf1 "SSH,tcp,,,$vmPort,,$guestPort"
# & VBoxManage.exe modifyvm $vmName --natpf1 "SSH,tcp,127.0.0.1,$vmPort,,$guestPort"

# Start the virtual machine
VBoxManage startvm $vmName --type headless

# Wait for 1 minute (90 seconds)
Start-Sleep -Seconds 90
Write-Output "Virtual machine '$vmName' imported and started successfully."