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