@{
    RootModule        = 'Ducky.psm1'
    ModuleVersion     = '1.0.0.10'
    GUID              = '4e548d05-4ccc-40f1-b54d-1cab4ac1ea5d'
    Author            = 'siljavind'
    CompanyName       = 'Unknown'
    Copyright         = '(c) 2025 siljavind. All rights reserved.'
    Description       = "I have almost no clue what I'm doing, but here's a duck that quacks"
    FunctionsToExport = @('Get-Duck', 'Set-DuckHat', 'Get-LastDuckHat')
    CmdletsToExport   = @()
    VariablesToExport = '*'
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags         = @('fun', 'ducks', 'console')
            LicenseUri   = ''
            ProjectUri   = 'https://github.com/siljavind/Ducky'
            IconUri      = ''
            ReleaseNotes = 'Party hat!'
        }
    }
}