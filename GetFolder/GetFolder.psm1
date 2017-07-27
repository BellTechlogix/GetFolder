<#
	This Function creates a dialogue to return a Folder Path
#>
function Get-Folder {
    param([string]$Description="Select Folder to place results in",[string]$RootFolder="Desktop")

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
     Out-Null     

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Error "Operation cancelled by user."
        }
}



# jrich method - this allows the developer good control with high odds they wont need to google for help
<#
	This Function creates a dialogue to return a File
	.example
	get-filename -filter "Name | *.filter"
	.example
	#something more complex
	
#>

#function Get-FileName($initialDirectory)
#{
#  param(
    #File filter param. Review examples for the format and check the notes for the MSDN link on the syntax
#    $Filter = "All Files | *.*",
#    $Title="Select User List Input File"
#    )
	
#	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
#	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
#  $OpenFileDialog.initialDirectory = $initialDirectory
#  $OpenFileDialog.FileName = $title
#	$OpenFileDialog.filter = $filter 
#
#  $OpenFileDialog.ShowDialog() | Out-Null
#  Return $OpenFileDialog.FileName
#}



#Alternative function -Szeraax
#Adopted as Primary function - 27July17
#Modified by TankCR
<#
	This Function creates a dialogue to return a File
	.example
	get-filename -filter "csv"
Will create an OpenFileDialog box with the filter: "CSV (*.csv)" (which shows only .csv files)
#>
function Get-FileName
{
  param([Parameter(Mandatory=$false)][string]$Filter, [Parameter(Mandatory=$false)][switch]$Obj,[Parameter(Mandatory=$False)][string]$Title)
  #  Mandatory = $false
  #  $Filter = "All Files | *.*",
  #  [switch]$Obj,
  #  $Title="Select User List Input File"
  #)
    if(!($Title)) { $Title="Select Input File"}
  
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
  $OpenFileDialog.initialDirectory = $initialDirectory
  $OpenFileDialog.FileName = $Title
  #can be set to filter file types
  IF($Filter -ne $null){
  $FilterString = '{0} (*.{1})|*.{1}' -f $Filter.ToUpper(), $Filter
	$OpenFileDialog.filter = $FilterString}
  if(!($Filter)) { $Filter = "All Files (*.*)| *.*"
  $OpenFileDialog.filter = $Filter
  }
  $OpenFileDialog.ShowDialog() | Out-Null
  IF($OBJ){
  $fileobject = GI -Path $OpenFileDialog.FileName.tostring()
  Return $fileObject
  }
  else{Return $OpenFileDialog.FileName}
}



Export-ModuleMember -Function 'Get-*'
