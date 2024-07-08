
# Copy files from host to vm 

Write-Output "Transfering application files..."

# Transfer all files and folders from host to virtual machine except $folderToExclude
$folderToExclude = "vm"
$items = Get-ChildItem -Path $SCRIPT_DIR -Exclude $folderToExclude

foreach ($item in $items) {
    $itemFullName = $item.FullName
    $destinationPath = "$vmDestination\$($item.Name)"
    $scpCommand = "scp.exe -i ~/.ssh/id_rsa -P $vmPort -r $itemFullName ${vmUser}@${vmHost}:${destinationPath}"

    Write-Output "Executing: $scpCommand"
    & scp.exe -i ~/.ssh/id_rsa -P $vmPort -r $itemFullName "${vmUser}@${vmHost}:${destinationPath}"
}

# Copy env file
ssh.exe $vmUser@$vmHost -p $vmPort "mv $vmDestination/env_example.txt $vmDestination/.env"

Write-Output "Script execution completed."
