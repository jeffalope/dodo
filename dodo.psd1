@{

  # Script module or binary module file associated with this manifest.
  ModuleToProcess = 'dodo.psm1'
  
  # Version number of this module.
  ModuleVersion = '0.0.1'
  
  # ID used to uniquely identify this module
  GUID = 'e4266f8f-5e5f-4e15-b79b-9b0e20486386'
  
  # Author of this module
  Author = 'Jeff Nowiski (sqljackalope)'
  
  # Company or vendor of this module
  CompanyName = 'sqljackalope'
  
  # Copyright statement for this module
  Copyright = 'Copyright (c) 2019 by dbatools, licensed under MIT'
  
  # Description of the functionality provided by this module
  Description = 'Right click deployment of tsql scripts to SQL Server'
  
  # Minimum version of the Windows PowerShell engine required by this module
  PowerShellVersion = '3.0'
  
  # Name of the Windows PowerShell host required by this module
  PowerShellHostName     = ''

  # Minimum version of the Windows PowerShell host required by this module
  PowerShellHostVersion  = ''

  # Minimum version of the .NET Framework required by this module
  DotNetFrameworkVersion = ''

  # Minimum version of the common language runtime (CLR) required by this module
  CLRVersion             = ''

  # Processor architecture (None, X86, Amd64, IA64) required by this module
  ProcessorArchitecture  = ''

  # Modules that must be imported into the global environment prior to importing this module
  RequiredModules        = @()

  # Assemblies that must be loaded prior to importing this module
  RequiredAssemblies     = @()

  # Script files () that are run in the caller's environment prior to importing this module
  ScriptsToProcess       = @()

  # Type files (xml) to be loaded when importing this module
  TypesToProcess         = @()

  # Format files (xml) to be loaded when importing this module
  # "xml\dbatools.Format.ps1xml"
  FormatsToProcess       = @()

  # Modules to import as nested modules of the module specified in ModuleToProcess
  NestedModules          = @()

  # Functions to export from this module
  # Specific functions to export for Core, etc are also found in psm1
  # FunctionsToExport specifically helps with AUTO-LOADING so do not remove
  FunctionsToExport      = @(
      'Invoke-DodoDeployment',
      'New-DodoSendToShortcut',
      'Get-UserInputFromList',
      'Get-DatabaseInstances',
      'Invoke-Sqlcmd2',
      'Write-ListOutput'
  )

  # Cmdlets to export from this module
  CmdletsToExport = '*'
  
  # Variables to export from this module
  VariablesToExport = '*'
  
  # Aliases to export from this module
  AliasesToExport = '*'
  
  # DSC resources to export from this module
  DscResourcesToExport = @()
  
  # List of all modules packaged with this module
  ModuleList = @()
  
  # List of all files packaged with this module
  FileList = @()
  
  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData = @{
  
      PSData = @{
  
          # Tags applied to this module. These help with module discovery in online galleries.
           Tags = @('SQL', 'SQLServer', 'Query', 'Data', 'Database', 'Deployment')
  
          # A URL to the license for this module.
           LicenseUri = 'https://github.com/sqljackalope/dodo/blob/master/LICENSE'
  
          # A URL to the main website for this project.
           ProjectUri = 'https://github.com/sqljackalope/dodo/'
  
          # A URL to an icon representing this module.
          # IconUri = ''
  
          # ReleaseNotes of this module
          # ReleaseNotes = ''
  
      } # End of PSData hashtable
  
  } # End of PrivateData hashtable
  
  # HelpInfo URI of this module
  HelpInfoURI = ''
  
  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  DefaultCommandPrefix = ''
  
  }