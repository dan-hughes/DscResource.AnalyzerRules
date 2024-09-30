$ProjectPath = "$PSScriptRoot\..\..\.." | Convert-Path
$ProjectName = ((Get-ChildItem -Path $ProjectPath\*\*.psd1).Where{
        ($_.Directory.Name -match 'source|src' -or $_.Directory.Name -eq $_.BaseName) -and
        $(try
            { Test-ModuleManifest -Path $_.FullName -ErrorAction Stop
            }
            catch
            { $false
            } )
    }).BaseName


Import-Module $ProjectName

InModuleScope $ProjectName {
    Describe 'New-SuggestedCorrection tests' {
        $invokeScriptAnalyzerParameters = @{
            CustomRulePath = "$PSScriptRoot\..\..\..\output\builtModule\DscResource.AnalyzerRules" | Convert-Path
            IncludeRule    = 'Measure-Keyword'
        }

        Context 'When suggested correction should be created' {
            It 'Should create suggested correction' {
                $invokeScriptAnalyzerParameters['ScriptDefinition'] = '
                        if("example" -eq "example" -or "magic")
                        {
                            Write-Verbose -Message "Example found."
                        }
                    '

                $record = Invoke-ScriptAnalyzer @invokeScriptAnalyzerParameters

                $record.SuggestedCorrections | Should -Not -BeNullOrEmpty
            }
        }
        Context 'When suggested correction should not be created' {
            It 'Should create suggested correction' {
                $invokeScriptAnalyzerParameters['ScriptDefinition'] = '
                        if ("example" -eq "example" -or "magic")
                        {
                            Write-Verbose -Message "Example found."
                        }
                    '

                $record = Invoke-ScriptAnalyzer @invokeScriptAnalyzerParameters

                $record | Should -BeNullOrEmpty
            }
        }
    }
}
