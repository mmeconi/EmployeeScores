<#
    .SYNOPSIS
        Employee names, ID#, and Safety Training test scores are outputted to a text file.
    .DeSCRIPTION
        This program implements mandatory parameters, which can be passed to the file from the CLI
        or after program execution. The program first checks to see if the file "L2TrainingScores.txt" exists,
        and if so, it outputs and formats the inputted data to the text file. If the file does not exist,
        the user is given the option to create it. The file is then created with specific formatting and
        the inputted data is outputted to it. In both cases, inputted data is outputted to the console
        to ensure accuracy.
    .NOTES
        AuthorName: Marc Meconi
        DateLastModified: September 30, 2020
 #>

# Set parameters / required input data

 param (
    [parameter(Mandatory=$true)][string] $FullName,
    [parameter(Mandatory=$true)][string] $EmployeeNumber,
    [parameter(Mandatory=$true)][Int] $Score
    )

# Declared variables

$FilePath = "$home\documents\Win213\L2TrainingScores.txt"
$Grade = 0
$Title = "Level 2 Safety Training Scores"
[string]$Date = (Get-Date).adddays(-7)

Set-StrictMode -version latest
Set-Location $home\documents\Win213

# Converts the inputted score to a grade in word form

if ($Score -le 66)
    {
    $Grade = "Repeat"
    }
    elseif ($Score -le 72 -ge 67)
    {
    $Grade = "Remedial"
    }
    elseif ($Score -le 86 -ge 73)
    {
    $Grade = "Satisfactory"
    }
    elseif ($Score -le 100 -ge 87)
    {
    $Grade = "Excellent"
    }

# Test whether the output file exists

$test = Test-path -path .\L2TrainingScores.txt

# Conditional block based on whether the output file exists or not

if ($test -eq "True")
{
    # Outputs the user input to the console and formats spacing
   
    Write-Host -foregroundcolor Red "WARNING: A previous version of the score file exists."
    Write-Host ""
    Write-Host "==========================================="
    Write-Host -nonewline "Employee Name:"
    Write-Host -ForegroundColor Red $FullName
    Write-Host -nonewline "Employee Number:"
    Write-Host -ForegroundColor Red $EmployeeNumber
    Write-Host -nonewline "Grade:"
    Write-Host -ForegroundColor Red $Grade
    Write-Host "==========================================="
    "{0,-20}{1,-30}{2,-40}" -f "$FullName","$EmployeeNumber","$Grade" | Add-Content $Filepath
}
else
{
   <# 
   User given option to create the file (doesn't presently exist)
   The file is created with header information and titles.
   Initial data inputted prior to the file creation is then inserted. This won't pose 
   future formatting issues because this section of code is only run if the
   file does not exist.
   #>
   
   "File does not exist; would you like to create the file?"
   'Press CTRL + C to exit, or'
    pause
    Write-Host -foregroundcolor Yellow "Score file $filepath is ready for input"
    "">$FilePath
    '=============================================================================' >> $FilePath
    "{0,-20}{1,-30}{2,-40}" -f " ","$Title"," " | Add-Content $Filepath
    "{0,-27}{1,-30}{2,-40}" -f " ","$Date"," " | Add-Content $Filepath
    '=============================================================================' >> $FilePath
    "{0,-20}{1,-30}{2,-40}" -f "[Name]","[Number]","[Score]" | Add-Content $Filepath
    "{0,-20}{1,-30}{2,-40}" -f "$FullName","$EmployeeNumber","$Grade" | Add-Content $Filepath

   # Outputs the user input to the console and formats spacing
    
    Write-Host ""
    Write-Host "==========================================="
    Write-Host -nonewline "Employee Name:"
    Write-Host -ForegroundColor Red $FullName
    Write-Host -nonewline "Employee Number:"
    Write-Host -ForegroundColor Red $EmployeeNumber
    Write-Host -nonewline "Grade:"
    Write-Host -ForegroundColor Red $Grade
    Write-Host "==========================================="
}
