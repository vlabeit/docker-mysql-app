

# Unzip and collect ziped ova file
$zipFileP1 = "$SCRIPT_DIR\vm\unbuntu.7z.001"
$zipFileP2 = "$SCRIPT_DIR\vm\unbuntu.7z.002"

# Extract the archive into the script directory
Write-Output "Extracting 7-Zip archive into script directory..."
& "C:\Program Files\7-Zip\7z.exe" x $zipFileP1 -o"$SCRIPT_DIR" -y
& "C:\Program Files\7-Zip\7z.exe" x $zipFileP2 -o"$SCRIPT_DIR" -y
Write-Output "Extraction completed successfully."
