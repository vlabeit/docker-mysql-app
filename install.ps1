

# PowerShell script to download and install VirtualBox
$SCRIPT_DIR = (Get-Location).Path

# Define variables
$vmName = "decoya_server"
$vmUser = "user"
$vmHost = "localhost" # Temporary, will be defined again after vm start.

$vmPort = 22
$vmDestination = "~/decoya"
$guestPort = 22


# Creating App directory
New-Item -Path $vmDestination -ItemType Directory -Force

# Installing dependencies
& "$SCRIPT_DIR\app\scripts\depend.ps1"


# # Unzip and collect ziped ova file
# & "$SCRIPT_DIR\app\scripts\unzip.ps1"


# Importing VirtualBox
& "$SCRIPT_DIR\app\scripts\import_vbox.ps1"


# Deleting ova file
# Write-Output "Deleteing ova file..."
# Get-ChildItem -Path $SCRIPT_DIR -File -Filter *.ova* -Force | Remove-Item -Force

# # Installing guest addition
# bash $SCRIPT_DIR\guestAddition.sh

# Fetching new vm host IP
$vmIpAddress = & VBoxManage.exe guestproperty get $vmName "/VirtualBox/GuestInfo/Net/0/V4/IP" | Select-String -Pattern 'Value: ' | ForEach-Object { $_.ToString().Trim('Value: ') }
$vmHost = $vmIpAddress


# Creating main application folder
$sshCommand = "ssh.exe $vmUser@$vmHost -p $vmPort"
# Creating folder and premissions
$sshCommand += " 'mkdir -p $vmDestination; chmod 755 $vmDestination;'"
# Execute SSH command
Invoke-Expression $sshCommand


# Generating SSH key
& "$SCRIPT_DIR\app\scripts\create_ssh.ps1"


# # Add users to sudoers - not necassry now
# & "$SCRIPT_DIR\app\scripts\add_sudoers_files.ps1"
# # Add user to sudoers if not root 
# $scriptPath = "$vmDestination/app/scripts/add_sudoers.sh"
# $sshCommand = "ssh.exe -i ~/.ssh/id_rsa -p $vmPort $vmUser@$vmHost"
# # Construct the command to change script permissions and execute it
# $sshCommand += " 'bash -c $scriptPath'"
# # Execute the SSH command
# Invoke-Expression $sshCommand


# Copy files from host to vm 
& "$SCRIPT_DIR\app\scripts\files_copy.ps1"

Write-Output "Finished first part! now install the app."


# # ssh.exe "$SCRIPT_DIR\app\scripts\run_app.sh"

# $scriptPath = "$SCRIPT_DIR\app\scripts\run_app.sh"
# $sshCommand = "ssh user@192.168.7.16 'bash -s' < $scriptPath"
# Invoke-Expression $sshCommand


# $scriptPath = "$vmDestination/app/sshd_config.sh"
# $sshCommand = "ssh.exe -i ~/.ssh/id_rsa -p $vmPort $vmUser@$vmHost"

# # Construct the command to change script permissions and execute it
# $sshCommand += " 'chmod +x $scriptPath; bash -c $scriptPath'"

# # Execute the SSH command
# Invoke-Expression $sshCommand

# Write-Output "$scriptPath"