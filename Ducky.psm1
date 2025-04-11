function Get-Duck {
    $hat = Get-LastDuckHat

    $duckBase = @(
        '                               '
        '        █████████              '
        '      ██        ██             '
        '   ████  ██      █             '
        ' ██   ██          █            '
        '  ██████        ██         ███ '
        '       ██       ███████████ ██ '
        '     ███                    █  '
        '    ██                      █  '
        '   ██                      ██  '
        '    █                      ██  '
        '    ██                   ███   '
        '      ██               ███     '
        '        ███████████████        '
        '                               '
    )
    # Define hat options
    $hatOptions = @{
        None   = @()
        TopHat = Get-Content -Path (Join-Path -Path (Get-Module -Name DuckModule).ModuleBase -ChildPath 'ASCIIArt/TopHat.txt')
    }

    $chosenHat = $hatOptions[$hat]
    $hatWithDuck = $chosenHat + $duckBase

    # Print the duck with the hat
    $hatWithDuck | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    Add-Type -AssemblyName System.Speech
    $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak('quack')
}
Export-ModuleMember -Function Get-Duck

function Set-DuckHat {
    param (
        [ValidateSet('None', 'TopHat')]
        [string]$Hat
    )

    # Save the chosen hat to a file
    $filePath = "$env:USERPROFILE\duckHatChoice.txt"
    Set-Content -Path $filePath -Value $Hat

    # Get the duck with the newly chosen hat
    Get-Duck -Hat $Hat
}
Export-ModuleMember -Function Set-DuckHat

function Get-LastDuckHat {
    $filePath = "$env:USERPROFILE\duckHatChoice.txt"
    
    # If file exists, get the last saved hat choice
    if (Test-Path $filePath) {
        return Get-Content -Path $filePath
    }
    else {
        return 'None' # Default if no file exists
    }
}
Export-ModuleMember -Function Get-LastDuckHat
