# Function to check if VirtualBox is installed
function IsVirtualBoxInstalled {
    $virtualBoxPath = "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
    return Test-Path $virtualBoxPath
}

# Function to check if 7-Zip is installed
function Is7ZipInstalled {
    $sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
    return Test-Path $sevenZipPath
}


# Download and install VirtualBox
if (-not (IsVirtualBoxInstalled)) {
    $url = "https://download.virtualbox.org/virtualbox/7.0.18/VirtualBox-7.0.18-162988-Win.exe"

    $userprofile = $env:USERPROFILE
    $virtualBoxInstaller = "$userprofile\Downloads\VirtualBoxInstaller.exe"

    Write-Output "Downloading and installing VirtualBox..."
    Invoke-WebRequest -Uri $url -OutFile $virtualBoxInstaller
    Start-Process -FilePath $virtualBoxInstaller -ArgumentList '--silent', '--ignore-errors' -NoNewWindow -Wait
}  
 else {
    Write-Output "VirtualBox is already installed."
}


#Download and Install 7zip
if (-not (Is7ZipInstalled)) {
    Write-Output "Downloading and installing 7zip..."

    $url = 'https://www.7-zip.org/a/7z2407-x64.exe'
    $dest = "$env:temp\7z2407-x64.exe.exe"
    Invoke-WebRequest -Uri $url -OutFile $dest
    & $dest /S
}
else {
    Write-Output "7-Zip is already installed."
}
