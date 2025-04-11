function Get-Duck {
    $hat = Get-LastDuckHat

    # Define hat options
    $hatOptions = @{
        NoHat  = @()
        TopHat = Get-Content -Path (Get-FilePath 'ASCIIArt/TopHat.txt') -Encoding utf8
    }

    $chosenHat = $hatOptions[$hat]

    $duckBase = Get-Content -Path (Get-FilePath('ASCIIArt/DuckBase.txt')) -Encoding utf8

    # If a hat is chosen, skip the first line of the duck's base
    if ($chosenHat -ne @()) {
        $duckBase = $duckBase | Select-Object -Skip 1
    }

    $duckWithHat = $chosenHat + $duckBase

    # Print the duck with the hat
    $duckWithHat | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    $global:SpeechSynthesizer.Speak('quack')
}

function Set-DuckHat {
    param (
        [ValidateSet('NoHat', 'TopHat')]
        [string]$Hat
    )

    # Save the chosen hat to a file
    $filePath = "$env:USERPROFILE\duckHatChoice.txt"
    Set-Content -Path $filePath -Value $Hat

    Write-Output "$Hat chosen"
}

function Get-LastDuckHat {
    $filePath = "$env:USERPROFILE\duckHatChoice.txt"
    
    # If file exists, get the last saved hat choice
    if (Test-Path $filePath) {
        return Get-Content -Path $filePath
    }
    else {
        return 'NoHat' # Default if no file exists
    }
}

# Helper function to construct file paths
function Get-FilePath {
    param (
        [string]$ChildPath
    )
    return Join-Path -Path (Get-Module -Name Ducky).ModuleBase -ChildPath $ChildPath
}

# Module initialization
if (-not $global:SpeechSynthesizer) {
    Add-Type -AssemblyName System.Speech
    $global:SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
}

# Export functions
Export-ModuleMember -Function Get-Duck, Set-DuckHat, Get-LastDuckHat