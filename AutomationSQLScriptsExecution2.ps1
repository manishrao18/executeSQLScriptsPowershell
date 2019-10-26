## Author: Manish.Patil
## Date: 08-10-2019
## Description: Automation script using Windows Powershell for executing MS SQL Scripts [select statements] and generate ## CSV output.
## For more details please follow the associated readme.txt file.

$current = Get-Date
Write-Output "Script Execution Started: $current"

#Connect to SQL and run QUERY 
$SQLServer = "SQLMYDBServer" 
$SQLDBName = "MYSampleDB"
$SQLUsername = "sa" ## SQL Authentication
$SQLPassword = "SomEP@$$Word"

# Folder and file details
$WorkFolder = "D:\Powershell\"
$OutputFile = $WorkFolder + "Merged\ExecutionResult.csv"

$ConnectionString = "Data Source=$SQLServer;Initial Catalog=$SQLDBName;User ID=$SQLUsername;Password = $SQLPassword"

# clean "*.csv" existing files from the WorkFolder
get-childitem $WorkFolder -include *.csv -recurse | foreach ($_) {remove-item $_.fullname}

$sqlScripts = Get-ChildItem -Path $WorkFolder -Name -Include *.sql 
foreach($sqlScript in $sqlScripts)
{ 
	$sqlScript
	$OutputCSV = $WorkFolder + $sqlScript -replace ".sql$", ".csv"
    ## - Connect to SQL Server using non-SMO class 'System.Data': 
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
    $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; User ID = $SQLUsername; Password = $SQLPassword"
  
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
    $SqlQuery = [System.IO.File]::ReadAllText($WorkFolder+$sqlScript)
    # Write-Output "SQL Query:  $SqlQuery"
    $SqlCmd.CommandText = $SqlQuery
    $SqlCmd.Connection = $SqlConnection
  
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
    $SqlAdapter.SelectCommand = $SqlCmd
  
    $DataSet = New-Object System.Data.DataSet 
    $SqlAdapter.Fill($DataSet) 
    $SqlConnection.Close() 
 
    # Output RESULTS to CSV
    $DataSet.Tables[0] | Export-Csv $OutputCSV -NoTypeInformation

	# Invoke-Sqlcmd -ConnectionString $ConnectionString -InputFile $sqlScript | Export-Csv $OutputCSV -NoTypeInformation
}

Get-ChildItem -Filter *.csv | foreach {[System.IO.File]::AppendAllText($OutputFile, 
[System.Environment]::NewLine + $_.Name + [System.Environment]::NewLine + [System.IO.File]::ReadAllText($_.FullName) + [System.Environment]::NewLine)}

$OutputFile

$end= Get-Date

$diff= New-TimeSpan -Start $current -End $end

Write-Output "Execution Time Required: $diff"