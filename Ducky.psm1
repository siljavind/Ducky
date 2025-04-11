function Get-Duck {
    $duck = @(
        '   __',
        '<( o )__',
        ' (  ._>  )',
        '  `----'' '
    )

    $duck | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    Add-Type -AssemblyName System.Speech
    $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak('quack')
}
Export-ModuleMember -Function Get-Duck




function Get-Duck {
    $hat = Get-LastDuckHat

    $duckBase = @(
        '                               '
        '        █████████              '
        '      ██▒▒▒▒▒▒▒▒██             '
        '   ████▒▒██▒▒▒▒▒▒█             '
        ' ██▒▒▒██▒▒▒▒▒▒▒▒▒▒█            '
        '  ██████▒▒▒▒▒▒▒▒██         ███ '
        '       ██▒▒▒▒▒▒▒███████████▒██ '
        '     ███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█  '
        '    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█  '
        '   ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  '
        '    █▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  '
        '    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███   '
        '      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███     '
        '        ███████████████        '
        '                               '
    )
    # Define hat options
    $hatOptions = @{
        None      = @()
        Pirate    = Get-Content -Path (Join-Path -Path (Get-Module -Name DuckModule).ModuleBase -ChildPath 'ASCIIArt/PirateHat.txt')
        TopHat    = Get-Content -Path (Join-Path -Path (Get-Module -Name DuckModule).ModuleBase -ChildPath 'ASCIIArt/TopHat.txt')
        WitchHat  = Get-Content -Path (Join-Path -Path (Get-Module -Name DuckModule).ModuleBase -ChildPath 'ASCIIArt/WitchHat.txt')
        BeanieHat = Get-Content -Path (Join-Path -Path (Get-Module -Name DuckModule).ModuleBase -ChildPath 'ASCIIArt/BeanieHat.txt')
    }

    $chosenHat = $hatOptions[$hat]
    $hatWithDuck = $chosenHat + $duckBase

    # Print the duck with the hat
    $hatWithDuck | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    # Optionally, add speech synthesis
    Add-Type -AssemblyName System.Speech
    $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak('quack')
}


function Get-Duck {
    # Get the last chosen hat
    $hat = Get-LastDuckHat

    # Base ASCII Art for the duck
    $duckBase = @(
        '                               '
        '        █████████              '
        '      ██▒▒▒▒▒▒▒▒██             '
        '   ████▒▒██▒▒▒▒▒▒█             '
        ' ██▒▒▒██▒▒▒▒▒▒▒▒▒▒█            '
        '  ██████▒▒▒▒▒▒▒▒██         ███ '
        '       ██▒▒▒▒▒▒▒███████████▒██ '
        '     ███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█  '
        '    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█  '
        '   ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  '
        '    █▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  '
        '    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███   '
        '      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███     '
        '        ███████████████        '
        '                               '
    )
    

    # Define hat options
    $hatOptions = @{
        None      = @()
        Pirate    = @('   _______________', '  /               \\', '  |   O  O  |', '   \\_____/')
        TopHat    = @('     _____', '    /     \\', '   /_______\\ ', '  |   ^   |')
        WitchHat  = @('     /\\', '    /  \\', '   /    \\', '  /______\\')
        CowboyHat = @('    ________', '   /        \\', '  /   .--.   \\', '  |  |    |   |')
        BeanieHat = @('     ______', '    /      \\', '   |  O O  |', '    \\______/')
    }

    # Get the chosen hat (defaulting to None if the user hasn't selected one)
    $chosenHat = Get-Content tophat.txt

    # Combine the chosen hat with the base duck art
    $hatWithDuck = $chosenHat + $duckBase

    # Print the duck with the chosen hat
    $hatWithDuck | ForEach-Object { Write-Host "$_" -ForegroundColor DarkYellow }

    # Optionally, you can add speech synthesis here if you like
    Add-Type -AssemblyName System.Speech
    $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak('quack')
}

function Set-DuckHat {
    param (
        [ValidateSet('None', 'Pirate', 'TopHat', 'WitchHat', 'CowboyHat', 'BeanieHat')]
        [string]$Hat
    )

    # Save the chosen hat to a file
    $filePath = "$env:USERPROFILE\duckHatChoice.txt"
    Set-Content -Path $filePath -Value $Hat

    # Get the duck with the newly chosen hat
    Get-Duck -Hat $Hat
}

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

function Get-Duck {
    # Get the last chosen hat
    $hat = Get-LastDuckHat

    $duckBase = @(
        '   __',
        '<( o )__',
        ' (  ._>  )',
        '  `----'' '
    )

    # Define hat options
    $hatOptions = @{
        None      = @()
        Pirate    = @('   _______________', '  /               \', '  |   O  O  |', '   \_____/')
        TopHat    = @('     _____', '    /     \', '   /_______\ ', '  |   ^   |')
        WitchHat  = @('     /\\', '    /  \\', '   /    \\', '  /______\\')
        CowboyHat = @('    ________', '   /        \\', '  /   .--.   \\', '  |  |    |   |')
        BeanieHat = @('     ______', '    /      \\', '   |  O O  |', '    \______/')
    }

    # Get the chosen hat
    $chosenHat = $hatOptions[$hat]
    $hatWithDuck = $chosenHat + $duckBase

    # Print the duck with the hat
    $hatWithDuck | ForEach-Object { Write-Host "$_" -ForegroundColor Yellow }

    # Optionally, you can add speech synthesis here if you like
    Add-Type -AssemblyName System.Speech
    $voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak('quack')
}