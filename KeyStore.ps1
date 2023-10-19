function Get-Fingerprint {
    param(
        [string]$storeFile,
        [string]$keyAlias,
        [string]$storePassword,
        [string]$keyPassword
    )

    $command = "keytool -list -v -keystore `"$storeFile`" -alias $keyAlias"

    if ($null -ne $storePassword) {
        $command += " -storepass $storePassword"
    }

    if ($null -ne $keyPassword) {
        $command += " -keypass $keyPassword"
    }

    return $command
}

function New-KeyProperties {
    param(
        [string]$keyPropertiesFile = "android\key.properties",
        [string]$storeFile,
        [string]$keyAlias,
        [string]$storePassword,
        [string]$keyPassword
    )

    # Check if the key.properties file exists
    if (Test-Path -Path $keyPropertiesFile) {
        # If it exists, delete the file
        Remove-Item -Path $keyPropertiesFile -Force
    }

    # Create the content for the key.properties file
    $keyPropertiesContent = @"
keyAlias=$keyAlias
storeFile=../../$storeFile
storePassword=$storePassword
keyPassword=$keyPassword
"@

    # Write the content to the key.properties file
    $keyPropertiesContent | Set-Content -Path $keyPropertiesFile -Force

    # Display a message indicating success
    Write-Host "Key properties have been created and written to $keyPropertiesFile."
    
}

# Define the key.properties file path
$keyPropertiesFile = "android\key.properties"

# Check if the script was called with '--create-release' argument
if ($args -contains "--create-release") {
    $storeFile = "upload-keystore.jks"
    $keyAlias = "upload"
    $createReleaseCommand = "keytool -genkey -v -keystore `".\$storeFile`" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias $keyAlias"
    Invoke-Expression -Command $createReleaseCommand

    $storePassword = Read-Host "Enter the store password"
    $keyPassword = Read-Host "Enter the key password"
    New-KeyProperties -storeFile $storefile -keyAlias $keyAlias -storePassword $storePassword -keyPassword $keyPassword
}

# Check if the script was called with '--get-release' argument
if ($args -contains "--get-release") {
    # Read the key.properties file and set variables based on its content
    if (Test-Path $keyPropertiesFile) {
        Get-Content $keyPropertiesFile | ForEach-Object {
            $line = $_.Trim()
            if ($line -match "^\w+=") {
                $varName, $varValue = $line -split "=", 2
                if ($varName -eq "storeFile") {
                    $varValue = $varValue -replace "^(\.\./)+", ""
                }
                Set-Variable -Name $varName -Value $varValue
            }
        }
    }

    if (-not $storeFile) {
        $storeFile = Read-Host "Enter the path to the store file"
    }
    
    if (-not $keyAlias) {
        $keyAlias = Read-Host "Enter the key alias"
    }
    
    if (-not $storePassword) {
        $storePassword = Read-Host "Enter the store password"
    }
    
    if (-not $keyPassword) {
        $keyPassword = Read-Host "Enter the key password"
    }
    
    if ($storeFile -and $keyAlias -and $storePassword -and $keyPassword) {
        $fingerprintCommand = Get-Fingerprint -storeFile $storefile -keyAlias $keyAlias -storePassword $storePassword -keyPassword $keyPassword
    }
    else {
        Write-Host "Error: Missing key.properties file or required values to get the release certificate fingerprint."
        Exit 1
    }
}

# Check if the script was called with '--get-debug' argument
elseif ($args -contains "--get-debug") {
    $storeFile = "`"$env:USERPROFILE\.android\debug.keystore`""
    $keyAlias = "androiddebugkey"
    $storePassword = "android"
    $keyPassword = "android"
    $fingerprintCommand = Get-Fingerprint -storeFile $storefile -keyAlias $keyAlias -storePassword $storePassword -keyPassword $keyPassword
}

if ($null -ne $fingerprintCommand) {
    # Run the selected keytool command
    Invoke-Expression -Command $fingerprintCommand
}
