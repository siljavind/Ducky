function Get-Duck {
    $hat = Get-LastDuckHat

    # Define hat options
    $hatOptions = @{
        NoHat    = @{
            Hat   = @()
            Color = ''
        }
        TopHat   = @{
            Hat   = Get-Content -Path (Get-FilePath 'ASCIIArt/TopHat.txt') -Encoding utf8
            Color = 'Black'
        }
        PartyHat = @{
            Hat   = Get-Content -Path (Get-FilePath 'ASCIIArt/PartyHat.txt') -Encoding utf8
            Color = 'Multicolor'
        }
    }

    $duckBase = Get-Content -Path (Get-FilePath('ASCIIArt/DuckBase.txt')) -Encoding utf8
    $chosenHat = $hatOptions[$hat]
    
    if ($chosenHat.Hat -ne @()) {
        # If a hat is chosen, omit the first line of the duck's base for better hat alignment
        $duckBase = $duckBase | Select-Object -Skip 1

        # Handle multicolored party hat
        if ($chosenHat.Color -eq 'Multicolor') {
            $chosenHat.Hat | ForEach-Object {
                $line = $_
                foreach ($char in $line.ToCharArray()) {
                    switch ($char) {
                        '█' { Write-Host -NoNewline "$char" -ForegroundColor 'Magenta' }
                        '▒' { Write-Host -NoNewline "$char" -ForegroundColor 'Blue' }
                        default { Write-Host -NoNewline "$char" -ForegroundColor 'Yellow' }
                    }
                }
                Write-Host "" # Move to the next line
            }
        }
        else {
            # Print the hat in its specified color
            $chosenHat.Hat | ForEach-Object { Write-Host "$_" -ForegroundColor $chosenHat.Color }
        }
    }

    # Print the duckbase
    $duckBase | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    $global:SpeechSynthesizer.Speak('quack')
}

function Set-DuckHat {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('NoHat', 'TopHat', 'PartyHat')]
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
    return Join-Path -Path $PSScriptRoot -ChildPath $ChildPath
}

# Module initialization
if (-not $global:SpeechSynthesizer) {
    Add-Type -AssemblyName System.Speech
    $global:SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
}

# Export functions
Export-ModuleMember -Function Get-Duck, Set-DuckHat, Get-LastDuckHat