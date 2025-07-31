@{
    PSDependOptions            = @{
        AddToPath  = $true
        Target     = 'output\RequiredModules'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    InvokeBuild                = '5.14.0'
    PSScriptAnalyzer           = 'latest'
    Pester                     = 'latest'
    Plaster                    = 'latest'
    ModuleBuilder              = 'latest'
    ChangelogManagement        = 'latest'
    Sampler                    = 'latest'
    'Sampler.GitHubTasks'      = 'latest'
    MarkdownLinkCheck          = 'latest'
    'DscResource.Test'         = 'latest'
    xDscResourceDesigner       = 'latest'

    # Prerequisite modules for documentation.
    'DscResource.DocGenerator' = 'latest'
    PlatyPS                    = 'latest'
}
