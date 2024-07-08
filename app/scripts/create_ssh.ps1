# Generating SSH key

# Get VBoxManage ip
$sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa"  # Path to SSH private key on Windows

$vmIpAddress = & VBoxManage.exe guestproperty get $vmName "/VirtualBox/GuestInfo/Net/0/V4/IP" | Select-String -Pattern 'Value: ' | ForEach-Object { $_.ToString().Trim('Value: ') }

Write-Output "welcome, vm ip $vmIpAddress, creating ssh keys"

if (!(Test-Path $sshKeyPath)) {
    ssh-keygen -t rsa -b 4096 -f $sshKeyPath
}

# Read the content of id_rsa.pub
$id_rsa_pub_content = Get-Content "$sshKeyPath.pub"


# Initialize SSH command
$sshCommand = "ssh.exe $vmUser@$vmHost -p $vmPort"

# Append SSH setup commands to copy public key to authorized_keys
$sshCommand += " 'mkdir -p ~/.ssh; echo $id_rsa_pub_content >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys'"

# Execute SSH command
Invoke-Expression $sshCommand