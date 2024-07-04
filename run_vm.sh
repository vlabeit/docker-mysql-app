#!bin/bash

echo "Starting virtual machine script..."

# Determine current directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy files from host to virtual machine
Define other variables
VM_USER="user"
VM_HOST="localhost"
VM_PORT="2222"
VM_DESTINATION="/decoya"

ssh $VM_USER@$VM_HOST -p $VM_PORT 'mkdir -p /decoya'
scp -P $VM_PORT -r "$SCRIPT_DIR"/* $VM_USER@$VM_HOST:$VM_DESTINATION
ssh $VM_USER@$VM_HOST -p $VM_PORT  'mv /decoya/env_example.txt /decoya/.env'


# Still on work - to do automate vm create.

function load_vm() {
    echo "importing vm (to do), you can exit now and create vbox menually"
    # VBoxManage --name=ubuntuvm import /home/vladi/Desktop/Decoya/dubuntu.ova --register
}

function import_vm() {
    echo "importing vm (to do), you can exit now and create vbox menually"
    # VBoxManage --name=ubuntuvm import /home/vladi/Desktop/Decoya/dubuntu.ova --register
    ssh $VM_USER@$VM_HOST -p $VM_PORT << EOF
    # Commands to execute on the remote machine
    echo "Connected to \$(hostname)"
    
    echo "Updating and installing VirtualBox..."
    
    echo "pass123" | sudo -S apt-get install virtualbox -y 
    
    echo "Done updating and installing VirtualBox..."
    
    
    # Import the VM from OVA
    VBoxManage import "/decoya/dubuntu.ova" --name="ubuntuv2"
    
    # Start the imported VM
    VBoxManage startvm "ubuntuv2" --type headless
EOF
}

function create_vm() {
    ssh $VM_USER@$VM_HOST -p $VM_PORT << EOF
    # Commands to execute on the remote machine
    echo "Connected to $(hostname)"

    echo "Updating and installing VirtualBox..."
    echo "pass123" | sudo -S apt-get update -y 
    echo "pass123" | sudo -S apt-get install virtualbox -y 

    echo "Done updating and installing VirtualBox..."

    # Create and configure the VM
    VBoxManage createvm --name "ubuntu3" --ostype "Ubuntu_64" --register
    VBoxManage modifyvm "ubuntu3" --memory 4096 --cpus 2
    VBoxManage createhd --filename "ubuntu3.vdi" --size 20000  # 20GB disk size
    VBoxManage storagectl "ubuntu3" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "ubuntu3" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "ubuntu3.vdi"

    # Add port forwarding rule for SSH
    VBoxManage modifyvm "ubuntu3" --natpf1 "guestssh,tcp,,2222,,22"

    # Start the VM
    VBoxManage startvm "ubuntu3" --type headless
EOF
}

ssh $VM_USER@$VM_HOST -p $VM_PORT 'sudo debconf-set-selections /decoya/ubuntu_preseed.cfg && sudo apt-get -y install ubuntu-server'

echo "Create VBox VM menually or automatically?:"
echo "Click 1 for Menually, Click 2 to create new vm, Click 3 to import vm:"
echo "Only 1 fully working now:"

read choice

case $choice in
    1)
        load_vm
        ;;
    2)
        create_vm
        ;;
    3)
        import_vm
        ;;
    *)
        echo "Invalid input. Please provide a number (1 or 2)."
        exit 1
        ;;
esac
